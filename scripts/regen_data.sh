#!/bin/bash
#
# Regenerate/re-create all data
#
# Usage, locally:
#
#   ./scripts/regen_data
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/regen_data
#
# Peregrine directives:
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --job-name=regen_data
#SBATCH --output=regen_data.log

./scripts/1_install_razzo.sh
./scripts/2_create_parameter_files.sh
./scripts/3_create_input_files.sh
./scripts/5_create_nltt_files.sh
./scripts/6_create_marg_lik_files.sh