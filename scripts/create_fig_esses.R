
# Input file
esses_filename <- file.path(getwd(), "results", "esses.csv")
testit::assert(file.exists(esses_filename))

# Output file
fig_esses_filename <- file.path(getwd(), "results", "fig_esses.png")
fig_esses_cumulative_filename <- file.path(getwd(), "results", "fig_cumulative_esses.png")

df <- read.csv(esses_filename)

library(ggplot2)

f_below <- sum(df$ess_likelihood < 200) / nrow(df)

library(plyr)

ggplot(df, aes(ess_likelihood)) +
  geom_histogram(binwidth = 10, alpha = 0.5, position="identity") +
  geom_vline(xintercept = 200, col = "black", lty = "dashed") +
  geom_vline(
    data = ddply(df, NULL, summarize, mean = mean(ess_likelihood)),
    aes(xintercept = mean)
  ) +
#  geom_vline(
#    data = ddply(df, .(tree, best_or_gen), summarize, mean = mean(ess_likelihood)),
#    aes(xintercept = mean, col = tree)
#  ) +
#  geom_vline(
#    data = ddply(df, .(tree, best_or_gen), summarize, median = median(ess_likelihood)),
#    aes(xintercept = median, col = tree), lty = "dashed"
#  ) +
#  ggplot2::facet_grid(. ~ best_or_gen) +
  labs(
    title = "Effective sample sizes of likelihood estimation",
    subtitle = "Absolute values",
    caption = paste0(
      "Dashed black line: recommended ESS. ",
      "Solid line: mean ESS. ",
      "n =  ", nrow(df), ". ",
      "ESSes < 200: ", round(f_below * 100), "%"
    ),
    x = "Effective sample size of likelihood estimation",
    y = "Count"
  ) +
  ggsave(fig_esses_filename, width = 7, height = 7)


# Cumulative histogram


# Percentage below |
#                  |
#                  |
#                  +----------------
#                 ESS

esses <- seq(1, max(df$ess_likelihood))

# count ESSes
esses_cnt <- rep(NA, length(esses))
for (i in seq_along(esses_cnt)) {
  value <- esses[i]
  count <- sum(df$ess_likelihood == value)
  esses_cnt[i] <- count
}

esses_sum_cnt <- esses_cnt
for (i in seq_along(esses_sum_cnt)) {
  if (i == 1) next
  prev_sum <- esses_sum_cnt[i - 1]
  cur_value <- esses_sum_cnt[i]
  esses_sum_cnt[i] <- cur_value + prev_sum
}

df_cumulative <- data.frame(value = esses, count = esses_cnt, cumulative = esses_sum_cnt)

ggplot(df_cumulative, aes(x = value, y = 100.0 * esses_sum_cnt / length(esses))) + geom_line() +
  geom_vline(xintercept = 200, lty = "dashed") +
  labs(
    title = "Effective sample sizes of likelihood estimation",
    subtitle = "Cumulative values",
    y = "proportion < ESS (%)",
    x = "ESS",
    caption = paste0(
      "Dashed black line: recommended value. ",
      "n =  ", nrow(df), ". ",
      "ESSes < 200: ", round(f_below * 100), "%"
    )
  ) +
  ggsave(fig_esses_cumulative_filename, width = 7, height = 7)
