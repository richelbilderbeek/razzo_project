#!/bin/bash
# Create file for figure 1
#
# Usage, locally:
#
#   ./scripts/91_create_summary_figs
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/91_create_summary_figs
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
#SBATCH --job-name=91_create_summary_figs
#SBATCH --output=91_create_summary_figs.log
module load R
module load ImageMagick
module load X11
module load cairo
module load libX11
module load xprop
echo "Rscript 91_create_summary_figs.R"
Rscript scripts/91_create_summary_figs.R
