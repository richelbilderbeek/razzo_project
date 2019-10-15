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
# Add MBD params
################################################################################
extract_ess <- function(param_filename) {
  testit::assert(file.exists(param_filename))

}

