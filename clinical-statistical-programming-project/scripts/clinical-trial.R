# ==============================================
# Clinical Trial Statistical Programming Project
# Simulated Phase II Study – Drug vs Placebo
# Author: Suprise Baloyi
# ==============================================

# ---- Load Packages ----
library(dplyr)
library(ggplot2)
install.packages("gt")
library(gt)
install.packages("knitr")
library(knitr)

set.seed(123)  # Reproducibility

# ---- Simulating Study Population ----
n <- 60
data <- data.frame(
  USUBJID = sprintf("SUBJ%03d", 1:n),
  TRT01A = rep(c("Placebo", "DrugA"), each = n/2),
  AGE = round(rnorm(n, 50, 8)),
  SEX = sample(c("M", "F"), n, replace = TRUE)
)

# ---- Simulating Baseline and Week 4 Blood Pressure ----
data <- data %>%
  mutate(
    BASE = round(rnorm(n, 140, 10), 1),
    WEEK4 = ifelse(TRT01A == "DrugA",
                   BASE - rnorm(n, mean = 10, sd = 5),
                   BASE - rnorm(n, mean = 3, sd = 5)),
    CHG = WEEK4 - BASE,
    AE_FLAG = sample(c(0, 1), n, replace = TRUE, prob = c(0.7, 0.3))
  )

# ---- Deriving ADaM-like Dataset ----
adam <- data %>%
  select(USUBJID, TRT01A, AGE, SEX, BASE, WEEK4, CHG, AE_FLAG)

# ---- Summary Table 1: Baseline Demographics ----
table1 <- adam %>%
  group_by(TRT01A) %>%
  summarise(
    N = n(),
    Mean_Age = round(mean(AGE), 1),
    SD_Age = round(sd(AGE), 1),
    Female = sum(SEX == "F"),
    Male = sum(SEX == "M")
  )

gt(table1) %>%
  tab_header(title = "Table 1: Baseline Demographics")

# ---- Summary Table 2: Efficacy Results ----
efficacy <- adam %>%
  group_by(TRT01A) %>%
  summarise(
    Mean_BASE = round(mean(BASE), 1),
    Mean_WEEK4 = round(mean(WEEK4), 1),
    Mean_CHG = round(mean(CHG), 1),
    SD_CHG = round(sd(CHG), 1)
  )

# Statistical Test
t_test <- t.test(CHG ~ TRT01A, data = adam)
p_value <- round(t_test$p.value, 3)

efficacy$P_value <- c("", p_value)

gt(efficacy) %>%
  tab_header(title = "Table 2: Efficacy – Change in Systolic BP from Baseline")

# ---- Table 3: Adverse Events ----
ae_summary <- adam %>%
  group_by(TRT01A) %>%
  summarise(
    N = n(),
    AE_Count = sum(AE_FLAG),
    AE_Percent = round(mean(AE_FLAG) * 100, 1)
  )

gt(ae_summary) %>%
  tab_header(title = "Table 3: Adverse Events Summary")

# ---- Visualization ----
# Distribution of change by treatment
ggplot(adam, aes(x = TRT01A, y = CHG, fill = TRT01A)) +
  geom_boxplot() +
  labs(
    title = "Change in Systolic Blood Pressure (Week 4 – Baseline)",
    x = "Treatment Group",
    y = "Change in SBP (mmHg)"
  ) +
  theme_minimal()

# Trend line (Baseline vs Week 4)
adam_long <- adam %>%
  tidyr::pivot_longer(cols = c(BASE, WEEK4), names_to = "Visit", values_to = "SBP")

ggplot(adam_long, aes(x = Visit, y = SBP, group = USUBJID, color = TRT01A)) +
  geom_line(alpha = 0.4) +
  stat_summary(fun = mean, geom = "line", size = 1.5, aes(group = TRT01A)) +
  labs(title = "Mean SBP Over Time by Treatment", y = "Systolic BP (mmHg)") +
  theme_minimal()

# ---- Save Outputs ----
write.csv(adam, "adam_dataset.csv", row.names = FALSE)
write.csv(table1, "table1_baseline.csv", row.names = FALSE)
write.csv(efficacy, "table2_efficacy.csv", row.names = FALSE)
write.csv(ae_summary, "table3_ae.csv", row.names = FALSE)
