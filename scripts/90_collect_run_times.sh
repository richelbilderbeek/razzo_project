#!/bin/bash
# Create file for figure 1
#
# Usage, locally:
#
#   ./scripts/90_collect_run_times
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/90_collect_run_times
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
#SBATCH --job-name=90_collect_run_times
#SBATCH --output=90_collect_run_times.log
module load R
module load ImageMagick
module load X11
module load cairo
module load libX11
module load xprop
echo "Rscript 90_collect_run_times.R"
Rscript scripts/90_collect_run_times.R
