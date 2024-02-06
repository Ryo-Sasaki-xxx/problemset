install.packages(dplyr)
library(dplyr)
install.packages(readr)
library(readr)
install.packages(ggplot2)
library(ggplot2)

sem_trend <- read.csv(
    "./problemset2_based/01_data/raw/master.csv",
    fileEncoding = "UTF-8",
    stringsAsFactors=FALSE,
) |> group_by(
    year
) |> summarize(
    mean = mean(semester, na.rm = TRUE)
)

plot <- ggplot(
    sem_trend,
    aes(x = year, y = mean)
) + 
    geom_line() +
    labs(title = "semester adoption rate", x = "year" , y = "semester adoption rate")

ggsave(
    filename = "sem_trend.png",
    plot = plot,
    path = "./problemset2_based/02_analysis/output",
    device = "png",
    width = 15,
    height = 10,
    dpi = 330
)
