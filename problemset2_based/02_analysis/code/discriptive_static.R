install.packages(dplyr)
library(dplyr)
install.packages(readr)
library(readr)
install.packages(gt)
library(gt)
install.packages(gtsummary)
library(gtsummary)


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

intermediate_data <- master_data |> mutate(
  is_changed_to_sem = if_else(
    unitid %in% changed_to_sem_unitid$unitid,
    "changed to semester",
    "still quarter"
    )
)

table <- intermediate_data |> dplyr::select(
  "is_changed_to_sem",
  "totcohortsize", 
  "w_cohortsize", 
  "m_cohortsize", 
  "women_gradrate_4yr", 
  "men_gradrate_4yr", 
  "per_women_cohort", 
  "per_white_cohort",
) |> gtsummary::tbl_summary(
    by = is_changed_to_sem,
    type = list(
      c(
        "totcohortsize",
        "w_cohortsize",
        "m_cohortsize",
        "women_gradrate_4yr",
        "men_gradrate_4yr",
        "per_women_cohort",
        "per_white_cohort"
        ) 
      ~ "continuous"),
    statistic = list(
      c(
        "totcohortsize",
        "w_cohortsize",
        "m_cohortsize",
        "women_gradrate_4yr",
        "men_gradrate_4yr",
        "per_women_cohort",
        "per_white_cohort"
        ) 
      ~ "{mean} ({sd})"),
    label = list(
      totcohortsize ~ "cohort size",
      w_cohortsize ~ "women's cohort size",
      m_cohortsize ~ "men's cohort size",
      men_gradrate_4yr ~ "men's 4yr grad rate",
      women_gradrate_4yr ~ "women's 4yr grad rate",
      per_women_cohort ~ "women's cohort size(%)",
      per_white_cohort ~ "white cohort size(%)"
    )
  ) |> gtsummary::add_overall() |> gtsummary::modify_caption("Table")

gt::gtsave(
  gtsummary::as_gt(table),
  filename =  "./problemset2_based/02_analysis/output/table.png"
)
