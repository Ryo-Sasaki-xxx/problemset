install.packages(dplyr)
library(dplyr)
install.packages(readr)
library(readr)
install.packages(gridExtra)
library(gridExtra)
install.packages(ggplot2)
library(ggplot2)

intermediate_data <- read.csv(
    "./problemset2_based/01_data/raw/master.csv",
    fileEncoding = "UTF-8",
    stringsAsFactors=FALSE,
) |>  group_by(
    unitid
) |>summarize(
    mean_gradrate_4yr = mean(gradrate4yr, na.rm = TRUE),
    mean_men_ratio_in_4yrgrads = mean(m_4yrgrads / tot4yrgrads, na.rm = TRUE),
    mean_women_ratio_in_4yrgrads = mean(w_4yrgrads / tot4yrgrads, na.rm = TRUE),
    mean_white_cohort_rate = mean(per_white_cohort, na.rm = TRUE),
    mean_costs = mean(costs, na.rm = TRUE),
    mean_instatetuition = mean(instatetuition, na.rm = TRUE),
)  

plot <- function(data, x, y, title, x_label, y_label) {
    enq_x = rlang::enquo(x)
    enq_y = rlang::enquo(y)
  
    ggplot2::ggplot(
        data,
        aes(x = !!enq_x, y = !!enq_y)
    ) +
        geom_point() +
        labs(title = title, x = x_label, y = y_label) 
}

plot_men_ratio <- plot(
    intermediate_data, 
    mean_men_ratio_in_4yrgrads, 
    mean_gradrate_4yr,
    "4年卒業率と男子学生比率",
    "men ratio in 4yr grads",
    "grad rate 4 year"
)

plot_women_ratio <- plot(
    intermediate_data, 
    mean_women_ratio_in_4yrgrads, 
    mean_gradrate_4yr,
    "4年卒業率と女子学生比率",
    "women ratio in 4yr grads",
    "grad rate 4 year"
)

plot_white_cohort_rate <- plot(
    intermediate_data, 
    mean_white_cohort_rate, 
    mean_gradrate_4yr,
    "4年卒業率と白人学生割合",
    "white cohort rate",
    "grad rate 4 year"
)

plot_costs <- plot(
    intermediate_data, 
    mean_costs, 
    mean_gradrate_4yr,
    "4年卒業率と年間運営コスト",
    "grad rate 4 year",
    "men ratio in 4yr grads"
)

plot_instatetution <- plot(
    intermediate_data, 
    mean_instatetuition, 
    mean_gradrate_4yr,
    "4年卒業率と学費",
    "instatetution",
    "grad rate 4 year"
)

scatter_plots <- gridExtra::grid.arrange(
    plot_men_ratio,
    plot_women_ratio,
    plot_white_cohort_rate,
    plot_costs,
    plot_instatetution
)

ggsave(
    filename = "scatter_plots.png",
    plot = scatter_plots,
    path = "./problemset2_based/02_analysis/output",
    device = "png",
    width = 10,
    height = 18,
    dpi = 330
)
