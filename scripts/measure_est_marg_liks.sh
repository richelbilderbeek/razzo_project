#!/bin/bash
# Measure how long it takes to estimate marginal likelihoods
# by doing so on each FASTA file in the folder
#SBATCH --time=0:01:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=measure_est_marg_liks
#SBATCH --output=measure_est_marg_liks.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R

for filename in $(find . | egrep "\.fas")
do
  echo $filename
  sbatch est_marg_lik.sh $filename
done