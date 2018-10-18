#!/bin/bash
# Script to install raket and its dependencies
# on the Peregrine computer cluster
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=install_razzo
#SBATCH --output=install_razzo.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
#module load R/3.3.1-foss-2016a
module load R
Rscript -e 'devtools::install_github("richelbilderbeek/razzo", ref = "devel")'
Rscript -e 'beastier::install_beast2()'