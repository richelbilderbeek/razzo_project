#!/bin/bash
# Create file for the figure that shows the Effective Sample Sizes
#
# Usage, locally:
#
#   ./scripts/82_create_fig_esses
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/82_create_fig_esses
#
# Note that the output on Peregrine will look bad. Prefer to run this script 
# locally.
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=82_create_fig_esses
#SBATCH --output=82_create_fig_esses.log
module load R
module load ImageMagick
module load X11
module load cairo
module load libX11
module load xprop
echo "Rscript scripts/create_fig_esses.R"
Rscript scripts/create_fig_esses.R
