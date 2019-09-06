# Creates a figure that shows the marginal likelihood estimations and their
# errors
library(razzo)
library(dplyr)
library(forcats)

all_marg_liks_filenames <- list.files(
  path = getwd(),
  pattern = "marg_liks.csv",
  recursive = TRUE,
  full.names = TRUE
)
all_marg_liks_filenames

marg_liks_filenames <- purrr::discard(
    stringr::str_match(
    string = all_marg_liks_filenames,
    pattern = ".*/razzo_project_.*"
  )[,1],
  is.na
)
marg_liks_filenames
testit::assert(length(marg_liks_filenames) == 1)

# Extract the dates in ISO format YYYYMMDD
dates <- stringr::str_match(
  string = marg_liks_filenames,
  pattern = "[:digit:]{8}"
)[,1]
dates
testit::assert(length(dates) == 1)


marg_liks_filename <- marg_liks_filenames[1]

df <- read.csv(marg_liks_filename)
df$seed <- stringr::str_match(string = df$folder, pattern = "/([0-9]{1,2})$")[, 2]




names(df)
nrow(df)

testit::assert(is.factor(df$folder))
testit::assert(is.factor(df$tree))
testit::assert(is.factor(df$site_model))
testit::assert(is.factor(df$clock_model))
testit::assert(is.factor(df$tree_prior))

library(ggplot2)

df$inference_model <- fct_cross(fct_cross(df$site_model, df$clock_model), df$tree_prior)

twin_site_model_name <- create_razzo_alignment_params(folder_name = "")$site_model$name
twin_clock_model_name <- create_razzo_alignment_params(folder_name = "")$clock_model$name
twin_tree_prior_name <- create_razzo_twinning_params(folder_name = "")$twin_model
twin_generative_model_name <- paste(
  twin_site_model_name,
  twin_clock_model_name,
  twin_tree_prior_name,
  sep = ", "
)
twin_generative_model_name

ggplot(df, aes(x = tree, y = marg_log_lik, col = inference_model)) +
  geom_point(
    position = position_dodge(0.2),
    size = 0.2
  ) +
  geom_errorbar(
    aes(
      ymin = marg_log_lik - marg_log_lik_sd,
      ymax = marg_log_lik + marg_log_lik_sd
    ),
    width = 0.4,
    position = position_dodge(0.2)
  ) +
  facet_wrap(seed ~ tree, scales = "free", ncol = 12) +
  theme(
    #axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
  ) +
  labs(
    title = "Marginal likelihoods estimates and their standard errors",
    subtitle = paste0("Do twin models really prefer the true model of ", twin_generative_model_name, "?"),
    caption = "Error bars denote standard deviation in estimation",
    y = "Marginal log likelihood (higher means the likelier model)"
  ) +
  ggsave(file.path(getwd(), "results", "fig_marg_liks.png"), width = 10, height = 10)
