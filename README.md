# razzo_project

Branch|[![Travis CI logo](pics/TravisCI.png)](https://travis-ci.org)
---|---
`master`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=master)](https://travis-ci.org/richelbilderbeek/razzo_project)
`develop`|[![Build Status](https://travis-ci.org/richelbilderbeek/razzo_project.svg?branch=develop)](https://travis-ci.org/richelbilderbeek/razzo_project)

`razzo` experiment scripts and storage.

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

## Results

![](fig_esses.png)

![](fig_states.png)

![](fig_f_mb_species.png)

![](fig_mean_esses.png)

![](fig_mean_n_taxa.png)

![](fig_n_mb_species.png)

![](fig_run_times_boxplot.png)

![](fig_run_times_per_crown_age_grouped.png)

![](fig_run_times_per_crown_age.png)

![](fig_run_times.png)

### Figure 1b.

#### 20190801

![](results/razzo_project_20190801/figure_1b.png)

#### 20190808

![](results/razzo_project_20190808/figure_1b.png)

#### 20190815

![](results/razzo_project_20190815/figure_1b.png)

#### 20190829

![](results/razzo_project_20190829/figure_1b.png)

#### 20190903

![](results/razzo_project_20190903/figure_1b.png)

#### 20190904

![](results/razzo_project_20190904/figure_1b.png)

#### 20190905

![](results/razzo_project_20190905/figure_1b.png)

#### 20190906

![](results/razzo_project_20190906/figure_1b.png)

### Marginal likelihoods

#### 20190801

![](results/razzo_project_20190801/fig_marg_liks.png)

#### 20190808

![](results/razzo_project_20190808/fig_marg_liks.png)

#### 20190815

![](results/razzo_project_20190815/fig_marg_liks.png)

#### 20190829

![](results/razzo_project_20190829/fig_marg_liks.png)

#### 20190903

![](results/razzo_project_20190903/fig_marg_liks.png)

#### 20190904

![](results/razzo_project_20190904/fig_marg_liks.png)

#### 20190905

![](results/razzo_project_20190905/fig_marg_liks.png)

#### 20190906

![](results/razzo_project_20190906/fig_marg_liks.png)

#### 20190908

![](results/razzo_project_20190908/fig_marg_liks.png)


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
