#!/bin/bash
# Create file with all number of multiple-born species
#
# Usage, locally:
#
#   ./scripts/10_create_n_mb_species_file
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/10_create_n_mb_species_file
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=10_create_n_mb_species_file
#SBATCH --output=10_create_n_mb_species_file.log
module load R
Rscript -e 'razzo::create_n_mb_species_file()'
