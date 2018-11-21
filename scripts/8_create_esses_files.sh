#!/bin/bash
# Create file with all collected ESSes
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=raz_create_esses_file
#SBATCH --output=raz_create_esses_file.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
Rscript -e 'razzo::raz_create_esses_file("scripts/razzo_project")'
