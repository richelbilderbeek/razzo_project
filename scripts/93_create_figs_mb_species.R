# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/93_create_figs_mb_species
#
n_mb_species_filenames <- list.files(
  path = "~/data",
  pattern = "n_mb_species.csv",
  full.names = TRUE,
  recursive = TRUE
)
n_mb_species_filenames
dates <- stringr::str_match(
  string = n_mb_species_filenames,
  pattern = "2019...."
)[, 1]
dates

df <- data.frame(date = NULL, n_mb_species = NULL, f_mb_species = NULL)

for (i in seq_along(n_mb_species_filenames)) {
  this_df <- read.csv(n_mb_species_filenames[i])
  this_df$date <- dates[i]
  df <- rbind(df, this_df)
}

head(df)
df
ggplot(df, aes(x = date, y = f_mb_species)) + geom_boxplot() +
  labs(
    title = "Fraction of multiple-born species",
    caption = "93"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_f_mb_species.png", width = 7, height = 7)

ggplot(df, aes(x = date, y = n_mb_species)) + geom_boxplot() +
  labs(
    title = "Number of multiple-born species",
    caption = "93"
  ) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ggsave("~/GitHubs/razzo_project/fig_n_mb_species.png", width = 7, height = 7)
