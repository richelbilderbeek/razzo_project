#!/bin/bash
# Create input files
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=raz_create_posterior_files
#SBATCH --output=raz_create_create_posterior_files.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
for filename in $(find . | egrep "parameters\.csv")
do
  echo $filename
  echo "MBD"
  Rscript -e 'razzo::raz_create_mbd_marg_lik_file("'$filename'")'
  echo "BD"
  Rscript -e 'razzo::raz_create_bd_marg_lik_file("'$filename'")'
done
