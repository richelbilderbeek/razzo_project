#!/bin/bash
# Create file for the figure that shows the number of taxa
#
# Usage, locally:
#
#   ./scripts/12_create_fig_n_taxa
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/12_create_fig_n_taxa
#
# Note that the output on Peregrine will look bad. Prefer to run this script 
# locally.
#
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=12_create_fig_n_taxa
#SBATCH --output=12_create_fig_n_taxa.log
module load R
module load ImageMagick
module load X11
module load cairo
module load libX11
module load xprop
echo "Rscript scripts/create_fig_n_taxa.R"
Rscript scripts/create_fig_n_taxa.R
