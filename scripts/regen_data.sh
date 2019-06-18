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

time ./scripts/1_install_razzo.sh
time ./scripts/2_create_parameter_files.sh
time ./scripts/3_run_razzo.sh
time ./scripts/7_create_nltt_stats_file.sh
time ./scripts/8_create_esses_files.sh
time ./scripts/9_create_marg_liks_file.sh
time ./scripts/10_create_fig_1_file.sh
