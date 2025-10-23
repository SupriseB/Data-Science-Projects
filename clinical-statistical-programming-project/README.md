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
clinical-statistical-programming-project/
│
├── scripts/
│ └── clinical_trial.R # Main script (run this file)
│
├── data/
│ ├── adam_dataset.csv # Derived ADaM-like dataset
│ ├── table1_baseline.csv # Baseline demographics
│ ├── table2_efficacy.csv # Efficacy summary
│ └── table3_ae.csv # Adverse events summary
│
├── output/
│ ├── sbp_change_boxplot.png # Change in SBP visualization
│ └── mean_sbp_trend.png # Mean SBP trend over time
│
└── README.md # Project overview and instructions

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


