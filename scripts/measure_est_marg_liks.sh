#!/bin/bash
# Measure how long it takes to estimate marginal likelihoods
# by doing so on each FASTA file in the folder
#SBATCH --time=0:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=measure_est_marg_liks
#SBATCH --output=measure_est_marg_liks.log
module load GCCcore/4.9.3 
module load XZ/5.2.2-foss-2016a
module load R

Rscript -e 'devtools::install_github("ropensci/beautier")'
Rscript -e 'devtools::install_github("ropensci/tracerer")'
Rscript -e 'devtools::install_github("ropensci/beastier")'
Rscript -e 'devtools::install_github("ropensci/mauricer")'
Rscript -e 'devtools::install_github("richelbilderbeek/babette")'
Rscript -e 'devtools::install_github("richelbilderbeek/mcbette")'
Rscript -e 'beastier::install_beast2()'
Rscript -e 'mauricer::mrc_install("NS")'

for filename in $(find . | egrep "\.fas")
do
  echo $filename
  sbatch ./measure_est_marg_lik.sh $filename
done
