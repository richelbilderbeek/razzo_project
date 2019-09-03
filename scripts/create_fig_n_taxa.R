
# Input file
n_taxa_filename <- file.path(getwd(), "results", "n_taxa.csv")
# n_taxa_filename <- "~/data/razzo_project/results/n_taxa.csv"

# Output file
fig_n_taxa_filename <- file.path(getwd(), "results", "fig_n_taxa.png")
#fig_n_taxa_filename = "~/fig_n_taxa.png"

testit::assert(file.exists(n_taxa_filename))

df <- read.csv(n_taxa_filename)
df

library(ggplot2)

ggplot(df, aes(n_taxa)) +
  geom_histogram(binwidth = 10, fill = "white", col = "black") +
  geom_vline(xintercept = mean(df$n_taxa), col = "red") +
  geom_vline(xintercept = median(df$n_taxa), col = "blue") +
  labs(
    title = "Number of taxa in the full experiment",
    caption = paste0("Red: mean. Blue: median. Number of parameter setting: ", nrow(df)),
    x = "Number of taxa",
    y = "Count"
  ) +
  ggsave(fig_n_taxa_filename, width = 7, height = 7)
