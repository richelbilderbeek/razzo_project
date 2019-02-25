#!/bin/bash
# Create file with all collected ESSes
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=9_create_marg_liks_file
#SBATCH --output=9_create_marg_liks_file.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
Rscript -e 'razzo::create_marg_liks_file()'
