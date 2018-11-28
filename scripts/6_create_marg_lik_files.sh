#!/bin/bash
# Create marginal likelihood estimation files
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=create_marg_lik_files
#SBATCH --output=create_create_marg_lik_files.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
for filename in $(find . | egrep "parameters\.csv")
do
  echo $filename
  echo "MBD"
  Rscript -e 'razzo::create_mbd_marg_lik_file("'$filename'")'
  echo "BD"
  Rscript -e 'razzo::create_bd_marg_lik_file("'$filename'")'
done
