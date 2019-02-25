# razzo_project

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---|---
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo` experiment scripts and storage.

Has the following folder structure:

 * `scripts`: contains the scripts

Should create the following folder structure:

 * `scripts`: contains the scripts
 * `data`: contains the simulation data
 * `results`: contains the simulation results

## Cluster usage

:warning: must run from the root folder

Regenerate testing data:

 * `sbatch ./scripts/regen_data.sh`

Run the razzo experiment:

 * `sbatch ./scripts/1_install_razzo.sh`
 * `sbatch ./scripts/2_create_parameter_files.sh`

## Local usage

 * `./scripts/1_install_razzo.sh`
 * `./scripts/2_create_parameter_files.sh`
 * `./scripts/3_create_input_files.sh`
 * `./scripts/5_create_nltt_files.sh`
 * `./scripts/6_create_marg_lik_files.sh`
 * `./scripts/7_create_nltt_stats_file.sh`
 * `./scripts/8_create_esses_file.sh`
 * `./scripts/9_create_marg_liks_file.sh`
 * `./scripts/10_create_fig_1_file.sh`

See [.travis.yml](.travis.yml) for the complete usage.

## `mcbette` timeseries

n_taxa|n_nucleotides|run_time
---|---|---
10|1k|0:40 or 40 mins
20|1k|1:23 or 83
40|1k|3:35 or 215 mins
80|1k|more than 10 hours, got cancelled
