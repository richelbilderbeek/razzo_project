# scripts

These are the most important scripts.

Assumes all packages are installed, see 'Installation' below.

Goal                          |Environment|Call
------------------------------|-----------|-----------------------------------
Run one full experiment (test)|Peregrine  |`sbatch scripts/run.sh test`
Run one full experiment (full)|Peregrine  |`sbatch scripts/run.sh full`
Process one full experiment   |Local      |`./scripts/process.sh`
Compare multiple experiments  |Local      |`./scripts/compare.sh`

## Installation

Installation scripts are at 
[https://github.com/richelbilderbeek/peregrine](https://github.com/richelbilderbeek/peregrine).

To install `razzo`:

```
cd peregrine/scripts
sbatch install_razzo.sh
```

