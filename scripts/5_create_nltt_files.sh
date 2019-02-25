#!/bin/bash
# Create nLTT files
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=5_create_nltt_files
#SBATCH --output=5_create_create_nltt_files.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
for filename in $(find . | egrep "parameters\.RDa")
do
  echo $filename
  Rscript -e 'razzo::create_mbd_nltts_file("'$filename'")'
  Rscript -e 'razzo::create_bd_nltts_file("'$filename'")'
done
