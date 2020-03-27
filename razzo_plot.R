razzo_plot <- function(
 project_folder_name,
 yaxis = "median_nltt",
 xaxis = "f_mb_species"
) {
 data0 = razzo::collect_all_data(project_folder_name)
 rf <- file.path(project_folder_name, "results")
 # data = data0 #p1
 data = data0[data0$ess_likelihood >= 200, ] #p2
 y = data[[yaxis]]
 x = data[[xaxis]]

 plots <- list()
 for (j in 4:1) {
  ndigits = j
  x2 = DDD::roundn(x, ndigits)
  y2 = y
  for (i in unique(x2)) {
   y2[x2 == i] = mean(y2[x2 == i])
  }

  grob3 = grid::grobTree(grid::textGrob(
   paste0(
    paste("Pearson Correlation: ", round(cor(y, x), 2)),
    "\n", paste("Coarse Grained Correlation: ", round(cor(y2, x2), 2))
   ),
   x = 0.02,
   y = 0.61,
   hjust = 0,
   gp = grid::gpar(
    col = "black",
    fontsize = 12,
    fontface = "plain"
   )
  ))

  df = data.frame(x = x2, y = y2)
  plots[[j]] <- ggplot2::ggplot(df, ggplot2::aes(y = y, x = x)) +
   ggplot2::geom_point() +
   ggplot2::theme_bw() +
   ggplot2::xlab("% multiple births") +
   ggplot2::ylab("nltt error") +
   ggplot2::ggtitle(paste0("Errors vs frequency of mb events - coarse grain level ", j)) +
   ggplot2::annotation_custom(grob3)
 }
 allplots <- gridExtra::grid.arrange(
   plots[[1]],
   plots[[2]],
   plots[[3]],
   plots[[4]],
   ncol = 2,
   nrow = 2
  )
 plotname <- paste0(
  yaxis,
  "_vs_",
  xaxis,
  ".png"
 )
 ggplot2::ggsave(
  allplots,
  filename = file.path(
   rf,
   plotname
  ),
  dpi = 1000,
  width = 10,
  height = 8
 )
 fasta_filename <- system.file(
  "extdata", "test_output_3.fas", package = "pirouette"
 )
 rf2 <- file.path(raztr::get_raztr_path("razzo_project"), "results")
 ggplot2::ggsave(
  allplots,
  filename = file.path(
   rf2,
   plotname
  ),
  dpi = 1000,
  width = 10,
  height = 8
 )
 grid::grid.draw(allplots)
}