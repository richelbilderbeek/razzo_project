#!/bin/bash
# Runs the experiment with one job per parameter file.
#
# Usage, locally:
#
#   ./scripts/3_run_razzo
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/3_run_razzo
#
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
  sbatch run_r_script "razzo::run_razzo_from_file(\"$filename\")"
done

