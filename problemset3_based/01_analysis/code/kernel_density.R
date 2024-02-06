load("./problemset3_based/01_analysis/output/simulation_data.rda")

kernel_density <- ggplot(
  simulation_data,
  aes(x=x)
) + 
  geom_line(
    stat = "density",
  ) +
  geom_line(
    stat = "density",
    adjust = .2,
    colour = "blue"
  ) +
  geom_line(
    stat = "density",
    adjust = 10,
    colour = "red"
  ) +
  xlab("運動神経") +
  ylab("density") +
  ggtitle("kernel density")

ggsave(
  filename = "kernel_density.png",
  plot = kernel_density,
  path = "./problemset3_based/01_analysis/output/",
  device = "png",
  dpi = 330
)