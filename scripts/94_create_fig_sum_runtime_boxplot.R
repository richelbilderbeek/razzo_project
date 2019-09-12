# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/91_create_summary_figures
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

for (i in seq_along(parameter_filenames)) {
  razzo_params <- readRDS(parameter_filenames[i])
  df$crown_age[i] <- razzo_params$mbd_params$crown_age
  df$n_candidates[i] <- length(razzo_params$pir_params$experiments)
}
names(df)

ggplot(
  na.omit(df),
  aes(x = date, y = n_hour)
  ) +
  geom_boxplot() +
  scale_y_log10() +
  facet_grid(. ~ crown_age, scale = "free_x") +
  labs(
    title = "Simulation run-times per crown age"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_run_times_per_crown_age.png", width = 7, height = 7)

ggplot(
  na.omit(df),
  aes(x = crown_age, y = n_hour)
  ) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x + I(x^2), fullrange = TRUE) +
  scale_y_log10() +
  scale_x_continuous(limits = c(5, 8)) +
  facet_grid(. ~ n_candidates) +
  labs(
    title = "Simulation run-times per crown age (grouped) per candidate model set",
    caption = "94"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_run_times_per_crown_age_grouped.png", width = 7, height = 7)

