#!/bin/bash
# Create file for the figure that shows the marginal likelihood estimations
# and the error
#
# Usage, locally:
#
#   ./scripts/83_create_fig_marg_liks
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/83_create_fig_marg_liks
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
#SBATCH --job-name=83_create_fig_marg_liks
#SBATCH --output=83_create_fig_marg_liks.log
module load R
module load ImageMagick
module load X11
module load cairo
module load libX11
module load xprop
echo "Rscript scripts/create_fig_marg_liks.R"
Rscript scripts/create_fig_marg_liks.R
