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
module load R
module load HDF5/1.10.1-foss-2018a
module add HDF5/1.10.1-foss-2018a
module list

Rscript -e 'devtools::update_packages()'

Rscript -e 'install.packages("BiocManager", repos="http://cran.r-project.org")'
Rscript -e 'BiocManager::install(version = "3.10")'
Rscript -e 'BiocManager::install()'
Rscript -e 'BiocManager::install(c("multtest"))'

Rscript -e 'devtools::install_github("thijsjanzen/nLTT", ref = "v1.4.3")'
Rscript -e 'devtools::install_github("ropensci/beautier", ref = "v2.3.3")'
Rscript -e 'devtools::install_github("ropensci/tracerer", ref = "v2.0.3")'
Rscript -e 'devtools::install_github("ropensci/beastier", ref = "v2.1.2")'
Rscript -e 'devtools::install_github("ropensci/mauricer", ref = "v2.0.6")'
Rscript -e 'devtools::install_github("ropensci/babette", ref = "v2.1.1")'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette", ref = "v1.8")'
Rscript -e 'devtools::install_github("thijsjanzen/nodeSub", ref = "v0.4.2")'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette", ref = "v1.6.2")'
Rscript -e 'devtools::install_github("Giappo/mbd", ref = "v1.0")'
Rscript -e 'devtools::install_github("Giappo/mbd.SimTrees", ref = "v0.1")'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys", ref = "v1.0.1")'
Rscript -e 'devtools::install_github("richelbilderbeek/peregrine", ref = "v1.0")'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo", ref = "v0.7.2")'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS")'


