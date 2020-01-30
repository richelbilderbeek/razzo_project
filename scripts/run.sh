#!/bin/bash
# Run one full experiment
#
# Usage, locally:
#
#  # Run default experiment type
#  ./scripts/run.sh
#
#  # Run test experiment
#  ./scripts/run.sh test
#
#  # Run full experiment
#  ./scripts/run.sh full
#
# Usage, on Peregrine:
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
#SBATCH --job-name=run.sh
#SBATCH --output=run.sh.log
module load R

experiment_type=$1
if [ "$#" -ne 1 ]; then
  experiment_type=full
fi

echo "Experiment type: "$experiment_type

# 1
jobid=$(sbatch 1_install_razzo.sh | cut -d ' ' -f 4)
print "1. Job ID: "$jobid

# 2
jobid=$(sbatch --dependency=afterok:$jobid 2_create_parameter_files.sh $experiment_type | cut -d ' ' -f 4)
print "2. Job ID: "$jobid

# 3
jobid=$(sbatch --dependency=afterok:$jobid 3_run_razzo.sh | cut -d ' ' -f 4)
print "3. Job ID: "$jobid

# Later scripts:
# - Start with one or two digits before the underscore
# - Are not among the first three
later_scripts=$(ls | sort -g | egrep "^..?_.*sh" | tail -n +4)

for script in $later_scripts
do
  jobid=$(sbatch --dependency=afterok:$jobid $script | cut -d ' ' -f 4)
  print "x. Job ID: "$jobid
done

