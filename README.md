# `razzo_project`

Branch   |[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---------|--------------------------------------------------------------------------------
`master` |[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)
`richel` |[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=richel)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo_project` contains the bash scripts to run and analyse one full 
`razzo` experiment on the Peregrine computer cluster.

The research project uses these GitHub repo's:

 * [razzo](https://github.com/richelbilderbeek/razzo): R code for the experiment
 * [raztr](https://github.com/richelbilderbeek/raztr): `razzo` results of a test run
 * [razzo_project](https://github.com/richelbilderbeek/razzo_project): bash scripts to run and analyse an experiment
 * [razzo_article (private)](https://github.com/richelbilderbeek/razzo_article): scientific manuscript (private GitHub for now)
 * [razzo_pilot_results (private)](https://github.com/richelbilderbeek/razzo_pilot_results): results of the pilot runs

## Versions

From `scripts/1_install_razzo.sh`:

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

## Folder structure

`razzo_project` has the following folder structure:

 * `scripts`: contains the scripts

The scripts in `scripts` create the following extra folders:

 * `data`: contains the simulation data
 * `results`: contains the simulation results

## Run one full experiment

:warning: must run from the `razzo_project` root folder

Here, we run one full experiment, meaning that there will be one or more
`parameters.RDa` files created. This is done on the Peregrine computer
cluster.

Regenerate testing data:

 * `sbatch ./scripts/regen_data.sh`

Run the razzo experiment:

 * `./scripts/run.sh test` (for test) or `./scripts/run.sh full` (for full run)

For doing the individual steps:

 * `sbatch ./scripts/1_install_razzo.sh`
 * `sbatch ./scripts/2_create_parameter_files.sh test` or `sbatch ./scripts/2_create_parameter_files.sh full`
 * `sbatch ./scripts/3_run_razzo.sh`
 * `sbatch ./scripts/6_create_mbd_file.sh`
 * `sbatch ./scripts/7_create_nltt_stats_file.sh`
 * `sbatch ./scripts/8_create_esses_files.sh`
 * `sbatch ./scripts/9_create_marg_liks_file.sh`
 * `sbatch ./scripts/10_create_n_mb_species_file.sh`
 * `sbatch ./scripts/11_create_n_taxa_file.sh`
 * `sbatch ./scripts/12_create_run_times_file.sh`

Scripts for these individual steps can be run on regular 
computers (i.e. without `sbatch`), as is done in [.travis.yml](.travis.yml).

## Process one full experiment

After running a full experiment, the data is processed. Among others,
the figures are created. This must be done locally, as Peregrine
cannot handle graphics well.

 * `./scripts/process.sh`

## Compare multiple experiments

Do this locally:

 * `./scripts/compare.sh`

