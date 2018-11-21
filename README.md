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

 * `sbatch ./scripts/install_razzo.sh`
 * `sbatch ./scripts/create_parameter_files.sh`

## Local usage

 * `./scripts/1_install_razzo.sh`
 * `./scripts/2_create_parameter_files.sh`
 * `./scripts/3_create_input_files.sh`
 * `./scripts/4_create_posterior_files.sh`
 * `./scripts/5_create_nltt_files.sh`
 * `./scripts/6_create_marg_lik_files.sh`
 * `./scripts/7_create_nltt_stats_file.sh`
 * `./scripts/8_create_esses_file.sh`
 * `./scripts/9_create_marg_liks_file.sh`
 * `./scripts/10_create_fig_1_file.sh`

See [.travis.yml](.travis.yml) for the complete usage.