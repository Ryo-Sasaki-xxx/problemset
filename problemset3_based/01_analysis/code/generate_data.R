set.seed(1)
x <- rnorm(500, mean = 3, sqrt(2))

set.seed(2)
y <- ifelse(
  x + rnorm(500, mean = 0, sd = 1) >= 4,
  1,
  0
)

set.seed(3)
speed <- x + rnorm(500, mean = 0, sd = 1)

set.seed(4)
shoot <-x + rnorm(500, mean = 0, sd = 1)

set.seed(5)
height <-x + rnorm(500, mean = 0, sd = 1)

set.seed(6)
age <-x + rnorm(500, mean = 0, sd = 1)

set.seed(7)
team_work <-x + rnorm(500, mean = 0, sd = 1)

set.seed(8)
z <- team_work + 0.5 * shoot + 0.5 * speed + rnorm(500, mean = 0, sd = 1)

simulation_data <- data.frame(x, y, speed, shoot, height, age, team_work, z)

save(
  simulation_data,
  file = "./problemset3_based/01_analysis/output/simulation_data.rda"
)