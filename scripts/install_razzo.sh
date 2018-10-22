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

# From https://askubuntu.com/a/30157
#if ! [ $(id -u) = 0 ]; then
# echo "User must be root, please use 'sudo sbatch install_razzo.sh'"
# exit 1
#fi


Rscript -e 'devtools::install_github("richelbilderbeek/beautier")'
Rscript -e 'devtools::install_github("richelbilderbeek/tracerer")'
Rscript -e 'devtools::install_github("richelbilderbeek/beastier")'
Rscript -e 'devtools::install_github("richelbilderbeek/mauricer")'
Rscript -e 'devtools::install_github("richelbilderbeek/babette")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette")'
Rscript -e 'devtools::install_github("Giappo/mbd")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo")'
Rscript -e 'beastier::install_beast2()'
