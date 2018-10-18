#!/bin/bash
# Create input files
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=create_input_files_general
#SBATCH --output=create_input_files_general.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
cd data
Rscript -e 'razzo::raz_create_parameters_files()'
