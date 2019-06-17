#!/bin/bash
# Create input files
#
# Usage, locally:
#
#   ./scripts/2_create_parameter_files
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/2_create_parameter_files
#
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=2_create_parameter_files
#SBATCH --output=2_create_parameter_files.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
Rscript -e 'razzo::create_parameters_files()'
