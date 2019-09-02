# razzo_project

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---|---
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo` experiment scripts and storage.

## Data

 * [20190620_2](http://richelbilderbeek.nl/razzo_project_20190620_2.zip)
   1 replicates, crown age = 6, MCMC = 3k
 * [20190620_3](http://richelbilderbeek.nl/razzo_project_20190620_3.zip)
   2 replicates, crown age = 6, MCMC = 3k
 * [20190621](http://richelbilderbeek.nl/razzo_project_20190621.zip): 
   2 replicates, crown age = 6, MCMC = 100k
 * [20190717](http://richelbilderbeek.nl/razzo_project_20190717.zip): 
   2 replicates, crown age = 6, MCMC = 111k
 * [20190719 (FAILED RUN)](http://richelbilderbeek.nl/razzo_project_20190719.zip): 
   2 replicates, crown age = 6, MCMC = 111k
 * [20190801](http://richelbilderbeek.nl/razzo_project_20190801.zip): 
   2 replicates, crown age = 6, MCMC = 111k, twin alignment has equal amount of mutations,
   bug as described in pirouette Issue #309
 * [20190808](http://richelbilderbeek.nl/razzo_project_20190808.zip): 
   2 replicates, crown age = 6, MCMC = 111k, twin alignment has equal amount of mutations
 * [20190815](http://richelbilderbeek.nl/razzo_project_20190815.zip): 
   2 replicates, crown age = 7, MCMC = 111k, twin alignment has equal amount of mutations
 * [20190827](http://richelbilderbeek.nl/razzo_project_20190827.zip): 
   2 replicates, crown age = 7, MCMC = ?100k, twin alignment has equal amount of mutations
 * [20190829](http://richelbilderbeek.nl/razzo_project_20190829_unfinished.zip)
   and [results](http://richelbilderbeek.nl/razzo_project_20190829_results.zip):
   2 replicates, crown age = 6, MCMC = ?100k, twin alignment has equal amount of mutations,
   all 39 candidate models. 

## Results

![](results/figure_1.png)

## Folder structure

`razzo_project` has the following folder structure:

 * `scripts`: contains the scripts

The scripts in `scripts` create the following extra folders:

 * `data`: contains the simulation data
 * `results`: contains the simulation results

## Cluster usage

:warning: must run from the root folder

Regenerate testing data:

 * `sbatch ./scripts/regen_data.sh`

Run the razzo experiment:

 * `sbatch ./scripts/1_install_razzo.sh`
 * `sbatch ./scripts/2_create_parameter_files.sh test` or `sbatch ./scripts/2_create_parameter_files.sh ful`
 * `sbatch ./scripts/3_run_razzo.sh`
 * `sbatch ./scripts/7_create_nltt_stats_file.sh`
 * `sbatch ./scripts/8_create_esses_files.sh`
 * `sbatch ./scripts/9_create_marg_liks_file.sh`
 * `sbatch ./scripts/10_create_fig_1_file.sh`
 * `sbatch ./scripts/11_create_n_taxa_file.sh`

## Local usage

Same, but without `sbatch`.

See [.travis.yml](.travis.yml) for the complete usage.

## `mcbette` timeseries

n_taxa|n_nucleotides|run_time
---|---|---
10|1k|0:40 or 40 mins
20|1k|1:23 or 83
40|1k|3:35 or 215 mins
80|1k|more than 10 hours, got cancelled
