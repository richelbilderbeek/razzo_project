# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/95_create_fig_runtime_per_n_taxa
#

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

n_taxa_filenames <- list.files(
  path = "~/data",
  pattern = "n_taxa.csv",
  full.names = TRUE,
  recursive = TRUE
)
n_taxa_filenames


#' returns e.g.
#' data/0.2-0-1.5-0.2/37
extract_folder_name_from_log_filename <- function(log_filename) {
  as.character(
    na.omit(
      stringr::str_match(
        string = readLines(log_filename),
        pattern = "(data/.*/.*)/parameters.RDa"
      )[, 2]
    )
  )
}

extract_folder_names_from_log_filenames <- function(log_filenames) {
  folder_names <- rep(NA, length(log_filenames))
  for (i in seq_along(log_filenames)) {
    folder_names[i] <- extract_folder_name_from_log_filename(log_filenames[i])
  }
  folder_names
}

df <- data.frame()

for (i in seq_along(run_times_filenames)) {
  run_times_filename <- run_times_filenames[i]
  cpu_times_str <- as.character(read.csv(run_times_filename)$cpu_time)
  log_filenames <- as.character(read.csv(run_times_filename)$filename)
  folder_names <- extract_folder_names_from_log_filenames(log_filenames)
  cpu_times_n_secs <- time_strs_to_n_secs(cpu_times_str)
  cpu_times_n_secs
  run_date <- stringr::str_match(
    string = run_times_filename,
    "razzo_project_(........)"
  )[1, 2]
  run_date

  this_df <- data.frame(
    date = run_date,
    n_sec = cpu_times_n_secs,
    folder_name = folder_names)
  #this_df$i <- seq(1, nrow(this_df))
  df <- rbind(df, this_df)
}
df$date <- as.factor(df$date)
head(df)

df_n_taxa <- data.frame()
for (i in seq_along(n_taxa_filenames)) {
  n_taxa_filename <- n_taxa_filenames[i]
  date <- stringr::str_match(
    string = n_taxa_filename,
    pattern = "razzo_project_(........)"
  )[1, 2]
  this_df_n_taxa <- read.csv(n_taxa_filename)
  this_df_n_taxa$date <- date
  this_df_n_taxa$folder_name <- this_df_n_taxa$folder
  df_n_taxa <- rbind(df_n_taxa, this_df_n_taxa)
}
df_n_taxa

head(df_n_taxa)

df_runtime_per_n_taxa <- merge(x = df, y = df_n_taxa, by = "folder_name")
head(df_runtime_per_n_taxa)

library(ggplot2)

