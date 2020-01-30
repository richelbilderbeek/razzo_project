#!/bin/bash
# Runs the experiment with one job per parameter file.
#
# Usage, locally:
#
#   ./scripts/3_run_razzo
#
# Usage, on Peregrine:
#
#   sbatch ./scripts/3_run_razzo
#
# Will return the following text:
#
# Submitted batch jobs 12345677,12345678,12345679
#
# This is similar to other batch jobs, that return:
#
# Submitted batch job 12345677
#
# The reason is that run.sh parses the output of this script in the same way
# as the other scripts.
#
# Peregrine directives:
#SBATCH --partition=gelifes
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --job-name=3_run_razzo
#SBATCH --output=3_run_razzo.log
module load R
module load MPFR
jobids=()

for filename in $(find . | egrep "parameters\.RDa")
do
  jobid=$(sbatch ./scripts/run_r_cmd "razzo::run_razzo_from_file(\"$filename\")" | cut -d ' ' -f 4)
  jobids+=($jobid)
done

# Convert array of job IDs to colon-seperated string
txt=$(printf ":%s" "${jobids[@]}")
txt=${txt:1}
echo "Submitted batch jobs "$txt 

