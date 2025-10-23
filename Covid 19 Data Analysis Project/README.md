# COVID-19 Data Analysis Project

**Author: Suprise Baloyi**
**Purpose:** Real-life data analysis project demonstrating R-based clinical and epidemiological data analysis skills.

# Project Overview

This R project analyzes COVID-19 case and death trends using real-world data from Kaggle.
The workflow includes data cleaning, exploratory data analysis, summary statistics, visualization, and basic statistical analysis.

# Key highlights:

Analytical thinking and reproducibility

Data cleaning and transformation

Trend analysis using rolling averages

Correlation analysis between cases and deaths

Publication-quality visualizations using ggplot2

# Dataset

**Source:** COVID-19 Dataset by Sudalai Rajkumar on Kaggle

**File used:** covid_19_data.csv

**Columns:** ObservationDate, Country/Region, Province/State, Confirmed, Deaths, Recovered

# Key Skills Demonstrated

R Programming	Data cleaning, transformation, and reproducible coding
Data Analysis	Grouping, summarization, and correlation computations
Visualization	Trend plots, line charts, rolling averages with ggplot2
Statistical Analysis	Rolling averages, correlation analysis
Data Management	Handling real-life datasets and saving clean outputs
Documentation	Clear, commented code for traceable analysis

# Project Structure

COVID_Analysis/
├── covid_19_data.csv        # Original dataset from Kaggle
├── covid_analysis.R         # Main R script
├── covid_cleaned.csv        # Cleaned dataset
├── covid_summary.csv        # Summary statistics by country
├── covid_correlation.csv    # Correlation results
├── daily_cases_plot.png     # Daily cases trend plot
├── daily_deaths_plot.png    # Daily deaths trend plot
├── rolling_avg_cases_plot.png # 7-day rolling average plot
└── README.md                # Project overview and instructions

# Methodology

## Load and inspect dataset

Checked columns and head of the data to understand structure.

## Data cleaning and transformation

Selected relevant columns: ObservationDate, Country/Region, Confirmed, Deaths, Recovered

Renamed columns for consistency: date, location, new_cases, new_deaths, new_recovered

Filtered countries of interest: South Africa, US, India

Converted ObservationDate to Date format

## Summary statistics

Calculated total confirmed cases, deaths, and recovered per country

## Visualization

Daily cases and deaths line plots

7-day rolling average of daily cases

## Correlation analysis

Computed correlation between new cases and new deaths per country

## Save outputs

Saved cleaned dataset, summary statistics, correlation results, and plots

# How to Run

Place covid_19_data.csv in your project folder.

Open R or RStudio and run the script:

source("covid_analysis.R")


Outputs will be saved in the project folder: cleaned dataset, CSV summaries, and PNG plots.

# Key Learnings

Working with real-world epidemiological data

Applying data cleaning, transformation, and summarization techniques in R

Generating publication-quality visualizations

Understanding trends and relationships between COVID-19 cases and deaths

Demonstrating reproducible and traceable workflow, essential in clinical data analysis
