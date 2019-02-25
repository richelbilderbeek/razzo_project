#!/bin/bash
# Script to install razzo and its dependencies
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
Rscript -e 'devtools::install_github("ropensci/beautier")'
Rscript -e 'devtools::install_github("ropensci/tracerer")'
Rscript -e 'devtools::install_github("ropensci/beastier")'
Rscript -e 'devtools::install_github("ropensci/mauricer")'
Rscript -e 'devtools::install_github("ropensci/babette")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette")'
Rscript -e 'devtools::install_github("Giappo/mbd")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo")'
Rscript -e 'beastier::install_beast2()'
Rscript -e 'mauricer::install_beast2_pkg("NS")'
