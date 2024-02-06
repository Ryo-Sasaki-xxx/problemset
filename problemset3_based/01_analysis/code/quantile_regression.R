install.packages("quantreg")
library("quantreg")

load("./problemset3_based/01_analysis/output/simulation_data.rda")

mean <- lm(simulation_data$z ~ simulation_data$x, data = simulation_data)
median <- quantreg::rq(simulation_data$z ~ simulation_data$x, data = simulation_data, tau = 0.5)
quarter <- quantreg::rq(simulation_data$z ~ simulation_data$x, data = simulation_data, tau = 0.25)
three_quarters <- quantreg::rq(simulation_data$z ~ simulation_data$x, data = simulation_data, tau = 0.75)

summary_mean <- summary(mean)
summary_median <- summary(median)
summary_quarter <- summary(quarter)
summary_three_quarters <- summary(three_quarters)

result_table <- data.frame(
  head = c("mean", "median", "25%", "75%"),
  beta1 = c(
    summary_mean$coefficients[2],
    summary_median$coefficients[2],
    summary_quarter$coefficients[2],
    summary_three_quarters$coefficients[2]
  ),
  beta0 = c(
    summary_mean$coefficients[1],
    summary_median$coefficients[1],
    summary_quarter$coefficients[1],
    summary_three_quarters$coefficients[1]
  )
)


