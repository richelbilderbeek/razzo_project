#!/bin/bash
# Script to install razzo and its dependencies
# on the Peregrine computer cluster
#
# Usage, locally:
#
#   ./scripts/1_install_razzo
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/1_install_razzo
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=1_install_razzo
#SBATCH --output=1_install_razzo.log
module load R HDF5/1.10.1-foss-2018a
Rscript -e 'install.packages("BiocManager")'
Rscript -e 'BiocManager::install(version = "3.10")'
Rscript -e 'BiocManager::install()'
Rscript -e 'BiocManager::install(c("multtest"))'

Rscript -e 'devtools::install_github("richelbilderbeek/nLTT")'
Rscript -e 'devtools::install_github("ropensci/beautier", ref = "develop")'
Rscript -e 'devtools::install_github("ropensci/tracerer", ref = "develop")'
Rscript -e 'devtools::install_github("ropensci/beastier", ref = "develop")'
Rscript -e 'devtools::install_github("ropensci/mauricer", ref = "develop")'
Rscript -e 'devtools::install_github("ropensci/babette", ref = "develop")'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette", ref = "develop")'
Rscript -e 'devtools::install_github("thijsjanzen/nodeSub")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette", ref = "richel")'
Rscript -e 'devtools::install_github("Giappo/mbd")'
Rscript -e 'devtools::install_github("Giappo/mbd.SimTrees")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys")'
Rscript -e 'devtools::install_github("richelbilderbeek/peregrine")'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo", ref = "richel")'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'

Rscript -e 'devtools::update_packages()'

