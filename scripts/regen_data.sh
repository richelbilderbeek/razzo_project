#!/bin/bash
./scripts/1_install_razzo.sh
./scripts/2_create_parameter_files.sh
./scripts/3_create_input_files.sh
./scripts/4_create_posterior_files.sh
./scripts/5_create_nltt_files.sh
./scripts/6_create_marg_lik_files.sh