#!/bin/bash
#
# Create all figures on a local computer after a Peregrine run.
#
# Because one cannot create figures on Peregrine, this script
# goes through all runs and creates these.
#
# Expects all runs to be in ~/data.
# Expects all scripts to be in ~/GitHubs/razzo_project/scripts
#
# Usage (can be from any folder):
#
#   ./create_all_figs.sh
#
#
data_folder=/media/richel/D2B40C93B40C7BEB/
scripts_folder=/home/richel/GitHubs/razzo_project

cd $data_folder

sub_folders=$(find . | egrep "/razzo_project/razzo_project_........$")

script_indices="$(seq 6 19) $(seq 80 89)"

for sub_folder in $sub_folders
do
  cd $data_folder/$sub_folder
  echo "Processing folder: "$(pwd)
  for script_index in $script_indices
  do
    echo "Running script with index: $script_index"
    script=$(find . | egrep $script_index"_.*\.sh" )
    echo "Running script: $script"
    ./$script
  done
done
