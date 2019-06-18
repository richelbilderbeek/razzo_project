#!/bin/bash
# Create file for figure 1
#
# Usage, locally:
#
#   ./scripts/10_create_fig_1_file
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/10_create_fig_1_file
#
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=10_create_fig_1_file
#SBATCH --output=10_create_fig_1_file.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R
module load ImageMagick
module load X11
module load cairo
echo "xvfb-run Rscript $@"
xvfb-run Rscript -e 'razzo::create_fig_1_file()'
