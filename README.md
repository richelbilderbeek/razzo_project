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
 * `mkdir data`
 * `cd data`
 * `sbatch ../scripts/create_parameter_files.sh`


## Local usage

 * `sudo ./scripts/install_razzo.sh`
 * `mkdir data`
 * `cd data`
 * `./../scripts/create_parameter_files.sh`

See [.travis.yml](.travis.yml) for the complete usage.