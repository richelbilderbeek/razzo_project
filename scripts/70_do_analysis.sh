#!/bin/bash
#
# Runs the analysis, 
# with one job per parameter file.
# This takes place after all jobs have been processed by '3_run.sh'
#
# It runs 6_..., 7_..., 8_...., etc... sequentially
#
#
# Usage, locally:
#
#   ./scripts/70_do_analysis
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/70_do_analysis
#
# Peregrine directives:
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=70_do_analysis
#SBATCH --output=70_do_analysis.log
jobid=$(sbatch 6_create_mbd_file.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 7_create_nltt_stats_file.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 8_create_esses_files.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 9_create_marg_liks_file.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 10_create_n_mb_species_file.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 11_create_n_taxa_file.sh | cut -d ' ' -f 4)
jobid=$(sbatch --dependency=afterok:$jobid 12_create_run_times_file.sh | cut -d ' ' -f 4)
