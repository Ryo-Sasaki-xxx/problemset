load("./problemset3_based/01_analysis/output/simulation_data.rda")

plot <- function(data, x, binwidth, title) {
  enq_x <- enquo(x)
  ggplot(
    data,
    aes(x = !! enq_x)
  ) +
    geom_histogram(
      binwidth = binwidth,
    ) +
    labs(
      title = title,
      x = "x",
      y = "y"
    ) 
}

histgram1 <-plot(simulation_data, x, 0.3, "0.3 bins")
histgram2 <-plot(simulation_data, x, 0.1, "0.1 bins")
histgram3 <-plot(simulation_data, x, 15, "15 bins")

histgram <- gridExtra::grid.arrange(
  histgram1,
  histgram2,
  histgram3
)

ggsave(
  filename = "hist.png",
  plot = histgram,
  path = "./problemset3_based/01_analysis/output/",
  device = "png",
  width = 15,
  height = 10,
  dpi = 330
)