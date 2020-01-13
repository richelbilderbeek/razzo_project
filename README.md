# razzo_project

Branch   |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---------|--------------------------------------------------------------------------------
`master` |[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)
`richel` |[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=richel)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo` experiment scripts and storage.

The research project uses these GitHub repo's:

 * [razzo](https://github.com/richelbilderbeek/razzo): R code
 * [razzotestresults](https://github.com/richelbilderbeek/razzotestresults): `razzo` results of a test run
 * [razzo_project](https://github.com/richelbilderbeek/razzo_project): bash scripts to run and analyse an experiment
 * [razzo_article (private)](https://github.com/richelbilderbeek/razzo_article): scientific manuscript (private GitHub for now)
 * [razzo_pilot_results (private)](https://github.com/richelbilderbeek/razzo_pilot_results): results of the pilot runs

## Versions

 * [nLTT v1.4.3](https://github.com/thijsjanzen/nLTT/releases/tag/v1.4.3)
 * [beautier v2.3.2](https://cran.r-project.org/package=beautier)
 * [tracerer v2.0.2](https://cran.r-project.org/package=tracerer)
 * [beastier v2.1.1](https://cran.r-project.org/package=beastier)
 * [mauricer v2.0.5](https://cran.r-project.org/package=mauricer)
 * [babette v2.1.1](https://cran.r-project.org/package=babette)
 * [mcbette v1.8](https://github.com/richelbilderbeek/mcbette/releases/tag/v1.8)
 * [pirouette v1.6.2](https://github.com/richelbilderbeek/pirouette/releases/tag/v1.6.2)
 * [nodeSub v0.4.2](https://github.com/thijsjanzen/nodeSub/releases/tag/v0.4.2)
 * [mbd v1.0](https://github.com/Giappo/mbd/releases/tag/v1.0)
 * [mbd.SimTrees v0.1](https://github.com/Giappo/mbd.SimTrees/releases/tag/v0.1)
 * [becosys v1.0.1](https://github.com/richelbilderbeek/becosys/releases/tag/v1.0.1)
 * [peregrine v1.0](https://github.com/richelbilderbeek/peregrine/releases/tag/v1.0)
 * [razzo v0.7.2](https://github.com/richelbilderbeek/razzo/releases/tag/v0.7.2)

Code can be found in the `packages` folder.

## Data

To create the table in [overview.md](overview.md):

```
cd razzo_project
./scripts/90_collect_run_times.sh
```

See [overview.md](overview.md).

 * `20190908` is the favorite starting point
 * The `n_particles` in `20190908` and `20190910` 
   is correct to the actual value of 1, due to a `mcbette` error 

To download the data, 
download `http://richelbilderbeek.nl/razzo_project_[date].zip` where `[date]` is the date, 
for example: [http://richelbilderbeek.nl/razzo_project_20190801.zip](http://richelbilderbeek.nl/razzo_project_20190801.zip)

Our verdicts if a setting is good enough: see [verdict.md](verdict.md).

Note:

 * Bug #350 had its unfluence up until #346. #347 is without that bug

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
