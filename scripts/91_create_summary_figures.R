# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/91_create_summary_figures
#

all_parameter_filenames <- list.files(
  path = "~/data",
  pattern = "parameters.RDa",
  full.names = TRUE,
  recursive = TRUE
)
parameter_filenames <- as.character(
  na.omit(
    stringr::str_match(
      string = all_parameter_filenames,
      pattern = ".*razzo_project.*/1/parameters.RDa"
    )[,1]
  )
)
parameter_filenames

run_times_filenames <- list.files(
  path = "~/data",
  pattern = "run_times.csv",
  full.names = TRUE,
  recursive = TRUE
)
run_times_filenames

df <- data.frame()

for (i in seq_along(run_times_filenames)) {
  run_times_filename <- run_times_filenames[i]
  cpu_times_str <- as.character(read.csv(run_times_filename)$cpu_time)
  cpu_times_n_secs <- time_strs_to_n_secs(cpu_times_str)
  cpu_times_n_secs
  run_date <- stringr::str_match(
    string = run_times_filename,
    "razzo_project_(........)"
  )[1, 2]
  run_date

  this_df <- data.frame(date = run_date,  n_sec = cpu_times_n_secs)
  this_df$i <- seq(1, nrow(this_df))
  df <- rbind(df, this_df)
}

df$date <- as.factor(df$date)

library(ggplot2)
library(plyr)

df$n_hour <- df$n_sec / (60 * 60)

ggplot(
  na.omit(df),
  aes(x = date, y = n_hour)
  ) +
  geom_boxplot() +
  scale_y_log10() +
  labs(
    title = "Simulation run-times"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_run_times_boxplot.png", width = 7, height = 7)


# As table
df_means <- ddply(na.omit(df), .(date), summarize, mean_runtime_hours = mean(n_hour))

df_means$crown_age <- NA
df_means$n_candidates <- NA
df_means$mcmc_chain_length <- NA
df_means$n_particles <- NA
df_means$n_replicates <- NA
df_means$mean_n_taxa <- NA
df_means$mean_ess <- NA
df_means$perc_low_ess <- NA
df_means$dna_length <- NA

for (i in seq_along(parameter_filenames)) {
  razzo_params <- readRDS(parameter_filenames[i])
  df_means$crown_age[i] <- razzo_params$mbd_params$crown_age
  df_means$n_candidates[i] <- length(razzo_params$pir_params$experiments)
  df_means$mcmc_chain_length[i] <- razzo_params$pir_params$experiments[[1]]$inference_model$mcmc$chain_length
  df_means$n_particles[i] <- razzo_params$pir_params$experiments[[1]]$est_evidence_mcmc$particle_count
  n_replicates <- length(list.dirs(dirname(dirname(parameter_filenames[i]))[1])) - 1
  df_means$n_replicates[i] <- n_replicates

  # Mean number of taxa
  n_taxa_filename <- file.path(dirname(dirname(dirname(dirname(parameter_filenames[i])))), "results", "n_taxa.csv")
  testit::assert(file.exists(n_taxa_filename))
  df_n_taxa <- read.csv(n_taxa_filename)
  mean_n_taxa <- mean(df_n_taxa$n_taxa)
  df_means$mean_n_taxa[i] <- mean_n_taxa

  # Mean ESS
  esses_filename <- file.path(dirname(dirname(dirname(dirname(parameter_filenames[i])))), "results", "esses.csv")
  #if (!file.exists(esses_filename)) next
  testit::assert(file.exists(esses_filename))
  df_esses <- read.csv(esses_filename)
  mean_ess <- mean(df_esses$ess_likelihood)

  df_means$mean_ess[i] <- mean_ess
  df_means$perc_low_ess[i] <- 100.0 * sum(df_esses$ess_likelihood < 200) /
    length(df_esses$ess_likelihood)

  df_means$dna_length[i] <- nchar(readRDS(parameter_filenames[i])$pir_params$alignment_params$root_sequence)
}
# Correct for bug:
# although the parameters said to use 10 particles,
# in practice only one was used.
# Bug is fixed since 2019-09-11
df_means$n_particles[ which(df_means$date == "20190908") ] <- 1
df_means$n_particles[ which(df_means$date == "20190910") ] <- 1

knitr::kable(df_means)


# Mean number of taxa
ggplot(
  na.omit(df_means),
  aes(x = date, y = mean_n_taxa)
  ) +
  ggplot2::geom_col() +
  facet_grid(. ~ crown_age, scales = "free_x") +
  labs(
    title = "Mean number of taxa"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_mean_n_taxa.png", width = 7, height = 7)


# Mean ESS
ggplot(
  na.omit(df_means),
  aes(x = date, y = mean_ess)
  ) +
  ggplot2::geom_col() +
  facet_grid(. ~ crown_age, scales = "free_x") +
  labs(
    title = "Mean ESS"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_mean_esses.png", width = 7, height = 7)
