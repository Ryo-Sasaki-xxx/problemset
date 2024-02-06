install.packages(dplyr)
library(dplyr)
install.packages(readr)
library(readr)
install.packages(ggplot2)
library(ggplot2)
install.packages(gt)
library(gt)
install.packages(gtsummary)
library(gtsummary)
install.packages(broom)
library(broom)

master_data <- read.csv(
  "./problemset2_based/01_data/raw/master.csv",
  fileEncoding = "UTF-8",
  stringsAsFactors=FALSE,
)

changed_to_sem_unitid <- master_data |> dplyr::distinct(
  unitid,
  semester,
  quarter
) |> dplyr::group_by(
  unitid
) |> dplyr::summarize(
  count_unitid = dplyr::n(),
  .groups = "keep"
) |> dplyr::filter(
  count_unitid == 2
)

yearofsem_unitid <- master_data |> dplyr:: filter(
  semester == 1 & unitid %in% changed_to_sem_unitid$unitid
) |> dplyr::group_by(
  unitid
) |> dplyr::summarize(
  yearofsem = min(year)
)

changed_to_sem_data <- master_data |> dplyr:: filter(
  unitid %in% changed_to_sem_unitid$unitid
) |> dplyr::left_join(
  yearofsem_unitid,
  by = "unitid"
) |> dplyr::mutate(
  yeartosem = year - yearofsem
) |> dplyr::mutate(
  treated = dplyr::if_else(yeartosem < 0 , 0, 1)
)

lm_ans <- lm(gradrate4yr ~ treated, data = changed_to_sem_data)

lm_ans_table <- tidy(lm_ans) |> gtsummary::tbl_summary()

lm_points <- augment(lm_ans)

graph <- ggplot(
  lm_points,
  aes(x = treated)
) +
  geom_point(
    aes(y = gradrate4yr)
  ) +
  geom_line(
    aes(y = .fitted),
    colour = "blue"
  ) +
  labs(
    title = "Linear regression",
    x = "treated",
    y = "grad rate"
  )

gtsave(
  as_gt(lm_ans_table),
  filename = "./problemset2_based/02_analysis/output/lm_ans_table.png"
)

ggsave(
  filename = "lm_graph.png",
  plot = graph,
  path = "./problemset2_based/02_analysis/output",
  device = "png",
  dpi = 330
)
