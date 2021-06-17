# Collect the run-times of all razzo_project experiments in ~/data
#
# Usage:
#
# ./scripts/92_create_fig_esses
#
all_esses_filenames <- list.files(
  path = "~/data",
  pattern = "esses.csv",
  full.names = TRUE,
  recursive = TRUE
)
esses_filenames <- as.character(
  na.omit(
    stringr::str_match(
      string = all_esses_filenames,
      pattern = ".*razzo_project.*"
    )[,1]
  )
)
esses_filenames


dates <- stringr::str_match(
  string = esses_filenames,
  pattern = "2019(....)"
)[, 2]
dates

df <- data.frame(date = NULL, folder = NULL, ess_likelihood = NULL, tree = NULL, best_or_gen = NULL)

for (i in seq_along(esses_filenames)) {
  this_df <- read.csv(esses_filenames[i])
  this_df$date <- dates[i]
  df <- rbind(df, this_df)
}
names(this_df)

ggplot(df, aes(x = date, y = ess_likelihood)) + geom_boxplot() +
  labs(
    title = "ESSes",
    caption = "92"
  ) +
  facet_grid(tree ~ best_or_gen) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)); ggsave("~/GitHubs/razzo_project/fig_esses.png", width = 7, height = 7)
