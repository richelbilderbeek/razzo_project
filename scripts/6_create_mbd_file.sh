#!/bin/bash
# Collect all the MBD parameter in one file
#
# Usage, locally:
#
#   ./scripts/6_create_mbd_params_file
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/6_create_mbd_params_file
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=6_create_mbd_params_file
#SBATCH --output=6_create_mbd_params_file.log
module load R
Rscript -e 'razzo::create_mbd_params_file(project_folder_name = getwd())'
