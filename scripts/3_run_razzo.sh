#!/bin/bash
# Create input files
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=3_run_razzo
#SBATCH --output=3_run_razzo.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
module load MPFR
for filename in $(find . | egrep "parameters\.RDa")
do
  echo $filename
  Rscript -e 'razzo::run_razzo_from_file("'$filename'")'
done

