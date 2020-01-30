# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/90_collect_run_times
#
data_folder <- "/media/richel/D2B40C93B40C7BEB/"
scripts_folder <- "/home/richel/GitHubs/razzo_project"

library(testthat)
library(peregrine)

if (!dir.exists(data_folder)) {
  stop("Data folder '", data_folder,"' not found")
}
if (!dir.exists(scripts_folder)) {
  stop("Scripts folder '", scripts_folder,"' not found")
}

expect_true(dir.exists(data_folder))
expect_true(dir.exists(scripts_folder))

all_parameter_filenames <- list.files(
  path = data_folder,
  pattern = "parameters.RDa",
  full.names = TRUE,
  recursive = TRUE
)
expect_true(length(all_parameter_filenames) > 0)

all_data_folders <- unique(
    stringr::str_match(
    string = all_parameter_filenames,
    pattern = ".*/data"
  )[, 1]
)


parameter_filenames <- all_data_folders
for (i in seq_along(all_data_folders)) {
  first_parameter_filename <- as.character(
    na.omit(
      stringr::str_match(
        string = all_parameter_filenames,
        pattern = paste0(all_data_folders[i], "/.*/parameters.RDa$")
      )[, 1]
    )
  )[1]
  parameter_filenames[i] <- first_parameter_filename
}

expect_true(length(parameter_filenames) > 0)
expect_equal(
  length(parameter_filenames),
  length(all_data_folders)
)

################################################################################
# Collect run-times per run unaggregated
################################################################################
# Dirty filenames, e.g. with
# /data/razzo_project_20191017/results/razzo_project_20191014/run_times.csv
run_times_filenames_dirty <- list.files(
  path = data_folder,
  pattern = "run_times.csv",
  full.names = TRUE,
  recursive = TRUE
)
expect_true(length(run_times_filenames_dirty) > 0)

run_times_filenames <- stringr::str_match(
  string = run_times_filenames_dirty,
  pattern = ".*results/run_times.csv"
)
run_times_filenames <- as.character(na.omit(run_times_filenames[, 1]))
expect_true(length(run_times_filenames) > 0)

df <- data.frame()

for (i in seq_along(run_times_filenames)) {
  run_times_filename <- run_times_filenames[i]
  cpu_times_str <- as.character(read.csv(run_times_filename)$cpu_time)
  state_str <- as.character(read.csv(run_times_filename, na.strings = "")$state)
  cpu_times_n_secs <- time_strs_to_n_secs(cpu_times_str)
  run_date <- stringr::str_match(
    string = run_times_filename,
    "razzo_project_(........)"
  )[1, 2]
  testit::assert(length(cpu_times_n_secs) == length(state_str))
  filenames <- basename(as.character(read.csv(run_times_filename)$filename))
  this_df <- data.frame(
    date = run_date,
    n_sec = cpu_times_n_secs,
    state = state_str,
    filename = filenames
  )
  this_df$i <- seq(1, nrow(this_df))
  df <- rbind(df, this_df)
}

df$filename <- as.character(df$filename)
df$date <- as.factor(df$date)

# All filenames are unique
expect_equal(
  length(unique(df$filename)),
  length(df$filename)
)

expect_true(nrow(df) > 0)

write.csv(x = df, file = "~/GitHubs/razzo_pilot_results/run_times_per_run.csv")
cat(
  knitr::kable(df, format = "markdown"),
  sep = "\n",
  file = "~/GitHubs/razzo_pilot_results/run_times_per_run.md"
)
################################################################################
#
################################################################################

library(ggplot2)
library(plyr)

df$n_hour <- df$n_sec / (60 * 60)

expect_true("n_hour" %in% names(df))
expect_true("date" %in% names(df))
ggplot(
  na.omit(df),
  aes(x = n_hour, fill = date)
  ) +
  geom_density(alpha = 0.5) +
  scale_x_log10() +
  geom_vline(
    data = ddply(na.omit(df), .(date), summarize, mean = mean(n_hour)),
    aes(xintercept = mean, col = date)
  ) + labs(
    title = "Simulation run-times"
  ) + ggsave("~/GitHubs/razzo_pilot_results/fig_run_times.png", width = 7, height = 7)


library(dplyr)

expect_true("date" %in% names(df))
expect_true("state" %in% names(df))
df_state <- df %>%
    group_by(date) %>%
    dplyr::summarize(
      f_ok = mean(state == "COMPLETED"),
      f_fail = mean(state == "NA"),
      f_cancel = mean(state == "CANCELLED")
    )

ggplot(df_state, aes(x = date, y = f_ok, fill = date)) +
  geom_col() +
  geom_text(aes(label = f_ok), position = position_stack(vjust = .5)) +
  ggplot2::scale_y_continuous(limits = c(0.0, 1.00), oob = scales::squish) +
  geom_hline(yintercept = 0.95, lty = "dashed") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(
    title = "Runs that finish with OK"
  ) +
  ggsave("~/GitHubs/razzo_pilot_results/fig_states.png", width = 7, height = 7)




# As table
df_means <- ddply(na.omit(df), .(date), summarize, mean_runtime_hours = mean(n_hour))
names(df_state)

df_means <- merge(x = df_means, df_state)

df_means$crown_age <- NA
df_means$n_candidates <- NA
df_means$mutation_rate <- NA
df_means$mcmc_chain_length <- NA
df_means$n_particles <- NA
df_means$n_replicates <- NA
df_means$mean_n_taxa <- NA
df_means$mean_ess <- NA
df_means$perc_low_ess <- NA
df_means$dna_length <- NA
df_means$nus <- NA


for (i in seq_along(parameter_filenames)) {
  df_means$crown_age[i] <- readRDS(parameter_filenames[i])$mbd_params$crown_age
  df_means$n_candidates[i] <- length(readRDS(parameter_filenames[i])$pir_params$experiments)
  df_means$mutation_rate <- readRDS(parameter_filenames[i])$pir_params$alignment_params$mutation_rate
  df_means$mcmc_chain_length[i] <- readRDS(parameter_filenames[i])$pir_params$experiments[[1]]$inference_model$mcmc$chain_length
  df_means$n_particles[i] <- readRDS(parameter_filenames[i])$pir_params$experiments[[1]]$est_evidence_mcmc$particle_count
  n_replicates <- length(list.dirs(dirname(dirname(parameter_filenames[i]))[1])) - 1
  df_means$n_replicates[i] <- n_replicates

  # nus
  mbd_params_filename <- file.path(dirname(dirname(dirname(dirname(parameter_filenames[i])))), "results", "mbd_params.csv")
  testit::assert(file.exists(mbd_params_filename))
  df_mbd_param <- read.csv(mbd_params_filename)
  nus <- sort(unique(df_mbd_param$nu))
  df_means$nus[i] <- paste(as.character(nus), collapse = ",")

  # Mean number of taxa
  n_taxa_filename <- file.path(dirname(dirname(dirname(dirname(parameter_filenames[i])))), "results", "n_taxa.csv")
  if (!file.exists(n_taxa_filename)) {
    print(n_taxa_filename)
  }
  testit::assert(file.exists(n_taxa_filename))
  df_n_taxa <- read.csv(n_taxa_filename)
  mean_n_taxa <- mean(df_n_taxa$n_taxa)
  df_means$mean_n_taxa[i] <- mean_n_taxa

  # Mean ESS
  esses_filename <- file.path(
    dirname(dirname(dirname(dirname(parameter_filenames[i])))),
    "results", "esses.csv"
  )
  if (!file.exists(esses_filename)) {
    print(esses_filename)
  }
  testit::assert(file.exists(esses_filename))
  df_esses <- read.csv(esses_filename)
  mean_ess <- mean(df_esses$ess_likelihood)

  df_means$mean_ess[i] <- mean_ess
  df_means$perc_low_ess[i] <- 100.0 * sum(df_esses$ess_likelihood < 200) /
    length(df_esses$ess_likelihood)

  testit::assert(file.exists(parameter_filenames[i]))
  df_means$dna_length[i] <- nchar(
    readRDS(parameter_filenames[i])$pir_params$alignment_params$root_sequence
  )

}


# Correct for bug:
# although the parameters said to use 10 particles,
# in practice only one was used.
# Bug is fixed since 2019-09-11
df_means$n_particles[ which(df_means$date == "20190908") ] <- 1
df_means$n_particles[ which(df_means$date == "20190910") ] <- 1

knitr::kable(df_means, format = "markdown")

cat(
  knitr::kable(df_means, format = "markdown"),
  sep = "\n",
  file = "~/GitHubs/razzo_pilot_results/overview.md"
)
utils::write.csv(
  df_means,
  file = "~/GitHubs/razzo_pilot_results/overview.csv"
)
names(df_means)
df_verdict <- data.frame(date = df_means$date)
df_verdict$most_runs_pass <- df_means$f_fail < 0.05
df_verdict$most_ess_good <- df_means$perc_low_ess < 0.05

knitr::kable(df_verdict, format = "markdown")

cat(
  knitr::kable(df_verdict, format = "markdown"),
  sep = "\n",
  file = "~/GitHubs/razzo_pilot_results/verdict.md"
)
utils::write.csv(
  x = df_verdict,
  file = "~/GitHubs/razzo_pilot_results/verdict.csv"
)

