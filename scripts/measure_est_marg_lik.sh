#!/bin/bash
# Estimate a marginal likelihood
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=measure_est_marg_lik_%j
#SBATCH --output=measure_est_marg_lik_%j.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
echo $1
Rscript -e 'mcbette::est_marg_liks("'$1'")'
