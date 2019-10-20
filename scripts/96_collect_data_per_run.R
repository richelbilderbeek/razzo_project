# Collect the unaggregated data
# of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/96_collect_data_per_run
#
library(testthat)

################################################################################
# Create a data frame that maps the log to the parameter file
################################################################################

# Has both razzo and raket filenames
all_log_filenames <- list.files(
  path = "~/data",
  pattern = "run_r_cmd.*\\.log",
  full.names = TRUE,
  recursive = TRUE
)
all_razzo_log_filenames <- as.character(na.omit(stringr::str_match(string = all_log_filenames, pattern = ".*razzo_project.*")[, 1]))
head(all_razzo_log_filenames)

#' Extract the parameter filename belonging to a log file
extract_param_filename <- function(log_filename) {
  testit::assert(file.exists(log_filename))
  lines <- readLines(log_filename)
  relative_name <- as.character(
    na.omit(
      stringr::str_match(
        string = lines,
        pattern = "./data/.*/.*/parameters.RDa"
      )[, 1]
    )
  )
  testit::assert(length(relative_name) == 1)
  full_name <- gsub(
    x = relative_name,
    pattern = "^\\.",
    replacement = dirname(log_filename)
  )
  testit::assert(file.exists(full_name))
  full_name
}
expect_equal(
  extract_param_filename(
    "/home/richel/data/razzo_project_20190808/run_r_cmd_7089623.log"
  ),
  "/home/richel/data/razzo_project_20190808/data/0.2-0-1.5-0.2/37/parameters.RDa"
)

# The data frame
df_log_to_param_file <- data.frame(
  log_filename = all_razzo_log_filenames,
  param_filename = NA,
  stringsAsFactors = FALSE
)
for (i in seq(1, nrow(df_log_to_param_file))) {
  df_log_to_param_file$param_filename[i] <- extract_param_filename(
    df_log_to_param_file$log_filename[i]
  )
}
head(df_log_to_param_file)

################################################################################
# Add status column
################################################################################
extract_status <- function(log_filename) {
  testit::assert(file.exists(log_filename))
  text <- readLines(log_filename)
  status <- as.character(
    na.omit(
      stringr::str_match(
        string = text,
        pattern = ".*State.*: (.*)"
      )[, 2]
    )
  )
  status
}

for (i in seq(1, nrow(df_log_to_param_file))) {
  df_log_to_param_file$status[i] <- extract_status(
    df_log_to_param_file$log_filename[i]
  )
}
head(df_log_to_param_file)

################################################################################
# Add ESS
################################################################################
extract_gen_model_ess <- function(param_filename) {
  testit::assert(file.exists(param_filename))
  marg_lik_filename <- file.path(dirname(param_filename), "mbd_marg_lik.csv")
  if (!file.exists(marg_lik_filename)) {
    return(NA)
  }
  testit::assert(file.exists(marg_lik_filename))
  marg_liks <- read.csv(marg_lik_filename)
  ess <- NA
  if ("ess" %in% names(marg_liks)) {
    gen_model_index <- which(marg_liks$site_model_name == "JC69" &
      marg_liks$clock_model_name == "strict" &
      marg_liks$tree_prior_name == "birth_death")
    ess <- marg_liks$ess[gen_model_index]
  }
  ess
}

for (i in seq(1, nrow(df_log_to_param_file))) {
  df_log_to_param_file$gen_model_ess[i] <- extract_gen_model_ess(
    df_log_to_param_file$param_filename[i]
  )
}
head(df_log_to_param_file)
tail(df_log_to_param_file)

################################################################################
# Add other params
################################################################################
for (i in seq(1, nrow(df_log_to_param_file))) {
  param_filename <- df_log_to_param_file$param_filename[i]
  parameters <- readRDS(param_filename)

  df_log_to_param_file$lambda[i] <- parameters$mbd_params$lambda
  df_log_to_param_file$mu[i] <- parameters$mbd_params$mu
  df_log_to_param_file$nu[i] <- parameters$mbd_params$nu
  df_log_to_param_file$q[i] <- parameters$mbd_params$q
  df_log_to_param_file$crown_age[i] <- parameters$pir_params$experiments[[1]]$inference_model$mrca_prior$mrca_distr$mean$value
}

head(df_log_to_param_file)
tail(df_log_to_param_file)
write.csv(
  x = df_log_to_param_file,
  "~/GitHubs/razzo_project/detailed_overview.csv"
)


################################################################################
# Run times
################################################################################
# Convert time in HH:MM:SS
time_str_to_n_sec <- function(str) {
  x <- stringr::str_match(str, "((.)-)?(..):(..):(..)")
  n_secs <- as.numeric(x[1, 6])
  n_mins <- as.numeric(x[1, 5])
  n_hours <- as.numeric(x[1, 4])
  n_days <- as.numeric(x[1, 3])
  if (is.na(n_days)) n_days <- 0

  n_hours <- n_hours + (n_days * 24)
  n_mins <- n_mins + (n_hours * 60)
  n_secs <- n_secs + (n_mins * 60)
  n_secs
}

library(testthat)
expect_equal(time_str_to_n_sec("00:00:11"), 11)
expect_equal(time_str_to_n_sec("00:33:22"), (33 * 60) + 22)
expect_equal(time_str_to_n_sec("12:55:44"), (12 * 60 * 60) + (55 * 60) + 44)
expect_equal(
  time_str_to_n_sec(str = "4-33:22:11"),
  (4 * 24 * 60 * 60) + (33 * 60 * 60) + (22 * 60) + 11
)

# Convert time in HH:MM:SS
time_strs_to_n_secs <- function(strs) {
  n_secs <- rep(NA, length(strs))
  for (i in seq_along(strs)) {
    n_secs[i] <- time_str_to_n_sec(strs[i])
  }
  n_secs
}
expect_silent(time_strs_to_n_secs(c("00:00:01", "01:02:03", "1-02:03:04")))

extract_run_time_sec <- function(log_filename) {
  testit::assert(file.exists(log_filename))
  text <- readLines(log_filename)
  time <- as.character(
    na.omit(
      stringr::str_match(
        string = text,
        pattern = ".*State.*: (.*)"
      )[, 2]
    )
  )
  status
}

for (i in seq(1, nrow(df_log_to_param_file))) {
  df_log_to_param_file$run_time_sec[i] <- extract_run_time_sec(
    df_log_to_param_file$log_filename[i]
  )
}





head(df_log_to_param_file)
tail(df_log_to_param_file)
