#!/bin/bash
# Create file for figure 1
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=create_fig_1_file
#SBATCH --output=create_fig_1_file.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
Rscript -e 'razzo::create_fig_1_file()'
