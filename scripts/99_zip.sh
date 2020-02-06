#!/bin/bash
# Script to zip all razzo results
# on the Peregrine computer cluster
#
# Usage, locally:
#
#   ./scripts/99_zip
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/99_zip
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=240:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=99_zip
#SBATCH --output=99_zip.log
zip -r /data/p230198/razzo_project.zip data/ results/ scripts/ $(ls *.log)
