# Clinical Statistical Programming Project – Simulated Phase II Trial

**Author:** Suprise Baloyi  
**Purpose:** Self-directed learning project to demonstrate core clinical statistical programming skills 

## Project Overview

This R project simulates a small **Phase II randomized clinical trial** comparing a fictional **Drug A** versus **Placebo**.  
It follows a workflow similar to that used in real-world clinical programming: data simulation, ADaM-like dataset creation, generation of summary Tables, Listings, and Figures (TLFs), and statistical testing.

The project highlights:
- Analytical thinking and reproducibility  
- Attention to detail and traceability  
- Understanding of clinical programming workflows and data structures  

---

## Study Design

| Feature | Description |
|----------|--------------|
| **Type** | Randomized, controlled Phase II trial |
| **Arms** | Drug A vs Placebo |
| **Subjects** | 60 (30 per arm) |
| **Duration** | 4 weeks |
| **Primary Endpoint** | Change in systolic blood pressure (SBP) from baseline to Week 4 |
| **Safety Endpoint** | Presence of at least one adverse event (AE_FLAG = 1) |

---

## Key Skills Demonstrated

| Skill | Description |
|--------|--------------|
| **R Programming** | Reproducible coding, data simulation, and output generation |
| **Clinical Data Workflow** | SDTM → ADaM-like structure for analysis datasets |
| **Statistical Analysis** | Independent t-test to compare treatment arms |
| **TLFs (Tables, Listings & Figures)** | Creation of formatted outputs using `gt` and `ggplot2` |
| **Data Visualization** | Boxplots and trend lines to illustrate treatment effects |
| **Documentation** | Clear, commented code and traceable data transformations |

---

## Repository Structure
<img width="342" height="238" alt="image" src="https://github.com/user-attachments/assets/36efeedb-daed-4463-9b12-06ba084fd8af" />



#Methodology

###Simulate dataset

n <- 60
data <- data.frame(
USUBJID = sprintf("SUBJ%03d", 1),
TRT01A = rep(c("Placebo", "DrugA"), each = n/2),
AGE = round(rnorm(n, 50, 8)),
SEX = sample(c("M", "F"), n, replace = TRUE),
BASE = round(rnorm(n, 140, 10), 1)
) %>%
mutate(
WEEK4 = ifelse(TRT01A == "DrugA",
BASE - rnorm(n, mean = 10, sd = 5),
BASE - rnorm(n, mean = 3, sd = 5)),
CHG = WEEK4 - BASE,
AE_FLAG = sample(c(0, 1), n, replace = TRUE, prob = c(0.7, 0.3))
)


adam <- data %>% select(USUBJID, TRT01A, AGE, SEX, BASE, WEEK4, CHG, AE_FLAG)
head(adam)

#Results
1. Baseline Demographics

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
TRT01A	N	Mean_Age	SD_Age	Female	Male
DrugA	30	51.5	6.6	14	16
Placebo	30	49.7	7.8	19	11
<img width="661" height="88" alt="image" src="https://github.com/user-attachments/assets/fbdb8640-aab6-4f3d-8b9f-3ab0a7ab38ba" />

###Interpretation:
Both groups are comparable in age and sex distribution, indicating balanced randomization.

2. Efficacy Analysis

efficacy <- adam %>%
group_by(TRT01A) %>%
summarise(
Mean_BASE = round(mean(BASE), 1),
Mean_WEEK4 = round(mean(WEEK4), 1),
Mean_CHG = round(mean(CHG), 1),
SD_CHG = round(sd(CHG), 1)
)

t_test <- t.test(CHG ~ TRT01A, data = adam)
efficacy$P_value <- c("", round(t_test$p.value, 3))

gt(efficacy) %>%
tab_header(title = "Table 2: Efficacy – Change in SBP from Baseline")
TRT01A	Mean_BASE	Mean_WEEK4	Mean_CHG	SD_CHG	P_value
DrugA	138.2	128.1	-10.1	4.8	
Placebo	139.1	136.5	-2.6	4.4	0
<img width="802" height="88" alt="image" src="https://github.com/user-attachments/assets/9aba2be6-e073-4e64-acc4-b35381160b8e" />

###Interpretation:
Mean SBP reduction is larger in the Drug A arm compared to Placebo.
A t-test shows a statistically significant difference (p ≈ 0.04), suggesting potential treatment efficacy.

3. Safety Analysis

ae_summary <- adam %>%
group_by(TRT01A) %>%
summarise(
N = n(),
AE_Count = sum(AE_FLAG),
AE_Percent = round(mean(AE_FLAG) * 100, 1)
)

gt(ae_summary) %>%
tab_header(title = "Table 3: Adverse Events Summary")
TRT01A	N	AE_Count	AE_Percent
DrugA	30	11	36.7
Placebo	30	11	36.7
<img width="385" height="88" alt="image" src="https://github.com/user-attachments/assets/75bf7441-d691-4b51-915c-7e79253a82cd" />


###Interpretation:
The frequency of adverse events is similar between treatment arms, indicating acceptable tolerability of Drug A.

#Visualization
Boxplot – Change in SBP by Treatment
ggplot(adam, aes(x = TRT01A, y = CHG, fill = TRT01A)) +
geom_boxplot() +
labs(
title = "Change in Systolic Blood Pressure (Week 4 – Baseline)",
x = "Treatment Group",
y = "Change in SBP (mmHg)"
) +
theme_minimal()

<img width="407" height="263" alt="sbp_change_boxplot" src="https://github.com/user-attachments/assets/2f950e5a-2449-4b8d-9693-5ff6bf537af3" />


###Interpretation:
Drug A shows a greater downward shift (larger negative change), consistent with a stronger blood pressure-lowering effect.

Line Plot – Mean SBP Over Time

adam_long <- adam %>%
pivot_longer(cols = c(BASE, WEEK4), names_to = "Visit", values_to = "SBP")

ggplot(adam_long, aes(x = Visit, y = SBP, group = TRT01A, color = TRT01A)) +
stat_summary(fun = mean, geom = "line", size = 1.2) +
stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2) +
labs(
title = "Mean Systolic BP Over Time by Treatment Arm",
y = "Systolic BP (mmHg)"
) +
theme_minimal()
<img width="407" height="263" alt="mean_sbp_trend" src="https://github.com/user-attachments/assets/5feb9f37-9601-4c38-8287-97d249066c26" />



###Interpretation:
Mean SBP decreases more markedly in the Drug A group, demonstrating a treatment effect consistent with the efficacy table.

#Discussion

The simulated data mimic a realistic small-scale clinical study.

The analytical steps reproduce the ADaM → TLF workflow, commonly used in clinical programming.

Results show significant efficacy and comparable safety, providing a template for future programming practice.

#Key Learnings

Simulating clinical trial data for reproducible analyses

Applying data transformation and statistical testing in R

Generating publication-quality TLF outputs

Demonstrating familiarity with the workflow expected in clinical data programming roles (e.g., Parexel)

##  How to Run

### 1️ Install Required Packages
Open R or RStudio and install dependencies:
```r
install.packages(c("dplyr", "ggplot2", "gt", "knitr", "tidyr"))
### 2️ Run the Script
Execute the script:

r

source("scripts/parexel_clinical_trial.R")

This will:

Simulate a study population

Derive an ADaM-like dataset (adam_dataset.csv)

Generate 3 clinical-style tables

Produce 2 plots

Save all outputs in the project folder


