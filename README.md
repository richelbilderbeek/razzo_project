# razzo_project

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---|---
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo` experiment scripts and storage.

## Data


|date                                                          | mean_runtime_hours| crown_age| n_candidates| mcmc_chain_length| n_replicates| mean_n_taxa| mean_ess|
|:-------------------------------------------------------------|------------------:|---------:|------------:|-----------------:|------------:|-----------:|--------:|
|[20190801](http://richelbilderbeek.nl/razzo_project_20190801) |          0.6439931|         6|            3|           1111000|            2|    26.81250| 552.0521|
|[20190808](http://richelbilderbeek.nl/razzo_project_20190808) |          0.6791088|         6|            3|           1111000|            2|    26.81250| 541.2969|
|[20190815](http://richelbilderbeek.nl/razzo_project_20190815) |          1.6287905|         7|            3|           1111000|            2|    56.75000| 463.0667|
|[20190829](http://richelbilderbeek.nl/razzo_project_20190829) |          3.3101975|         6|           40|           1000000|            2|    26.81250| 421.7337|
|[20190903](http://richelbilderbeek.nl/razzo_project_20190903) |          4.1418981|         6|           40|           1000000|            2|    26.81250| 429.4056|
|[20190904](http://richelbilderbeek.nl/razzo_project_20190904) |          0.6348322|         6|            4|           1000000|            2|    26.81250| 478.9740|
|[20190905](http://richelbilderbeek.nl/razzo_project_20190905) |          0.6264041|         6|            4|           1000000|           10|    28.33333| 502.4483|

## Results

![](pics/20190905_figure_1a.png)
![](pics/20190905_figure_1b.png)

### 20190828

![](pics/20190829_figure_1a.png)
![](pics/20190829_figure_1b.png)

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
