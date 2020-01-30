#!/bin/bash
# Run one full experiment on Peregrine:
#
#  # Run default experiment type
#  sbatch ./scripts/run.sh
#
#  # Run test experiment
#  sbatch ./scripts/run.sh test
#
#  # Run full experiment
#  sbatch ./scripts/run.sh full
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=run
#SBATCH --output=run.log
module load R

experiment_type=$1
if [ "$#" -ne 1 ]; then
  experiment_type=full
fi

echo "Experiment type: "$experiment_type

echo "NO NEW INSTALL OF RAZZO: Do this yourself, by calling scripts/1_install_razzo.sh"
# ./scripts/1_install_razzo.sh

./scripts/2_create_parameter_files.sh $experiment_type

jobid=$(./scripts/3_run_razzo.sh | cut -d ' ' -f 4)

echo "Job IDs obtained from 3_run_razzo.sh: "$jobid

# Later scripts:
# - Start with one or two digits before the underscore
# - Are not among the first three
later_scripts=$(ls scripts | sort -g | egrep "^..?_.*sh" | tail -n +4)

for script in $later_scripts
do
  jobid=$(sbatch --dependency=afterok:$jobid scripts/$script | cut -d ' ' -f 4)
  echo "x. Job ID: "$jobid
done

