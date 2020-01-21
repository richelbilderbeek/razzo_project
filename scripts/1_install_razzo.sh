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

Rscript -e 'install.packages("devtools")'

Rscript -e 'devtools::update_packages()'

Rscript -e 'install.packages("BiocManager", repos="http://cran.r-project.org", dependencies = TRUE)'
Rscript -e 'BiocManager::install(version = "3.10", dependencies = TRUE)'
Rscript -e 'BiocManager::install()'
Rscript -e 'BiocManager::install(c("multtest"))'

Rscript -e 'devtools::install_github("thijsjanzen/nLTT", ref = "v1.4.3", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette", ref = "v1.8", dependencies = TRUE)'
Rscript -e 'devtools::install_github("thijsjanzen/nodeSub", ref = "v0.4.2", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/pirouette", ref = "v1.6.2", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/peregrine", ref = "v1.0", dependencies = TRUE)'
Rscript -e 'devtools::install_github("Giappo/mbd", ref = "v1.0", dependencies = TRUE)'
Rscript -e 'devtools::install_github("Giappo/mbd.SimTrees", ref = "v0.1", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/becosys", ref = "v1.0.1", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/raztr", ref = "v1.0", dependencies = TRUE)'
Rscript -e 'devtools::install_github("richelbilderbeek/razzo", ref = "richel", dependencies = TRUE)'
Rscript -e 'if (!beastier::is_beast2_installed()) beastier::install_beast2()'
Rscript -e 'if (!mauricer::is_beast2_pkg_installed("NS")) mauricer::install_beast2_pkg("NS", dependencies = TRUE)'


