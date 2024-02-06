install.packages(dplyr)
library(dplyr)
install.packages(readr)
library(readr)
install.packages(tibble)
library(tibble)
install.packages(ggplot2)
library(ggplot2)

data <- read.csv(
    "./problemset2_based/01_data/raw/master.csv",
    fileEncoding = "UTF-8",
    stringsAsFactors=FALSE,
)

grad_trend <- tibble(
    years = data$year,
    grad_rate_4yr = data$gradrate4yr
) |> group_by(
    years
) |> summarize(
    mean = mean(grad_rate_4yr,na.rm = TRUE),
    sd = sd(grad_rate_4yr, na.rm = TRUE)
)

plot <- ggplot(
    grad_trend,
    aes(x = years, y = mean)
) + 
    geom_line() +
    labs(title = "4yr grad rate", x = "year" , y = "4yr grad rate")

ggsave(
    filename = "4yr_grad_trend.png",
    plot = plot,
    path = "./problemset2_based/02_analysis/output",
    device = "png",
    width = 15,
    height = 10,
    dpi = 330
)
