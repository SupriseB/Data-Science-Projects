# ==============================================
# Real-Life Clinical Data Analysis Project
# COVID-19 Vaccination and Case Trends
# Author: Suprise Baloyi
# ==============================================

# ---- Load Packages ----
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(lubridate)
library(zoo)

# ---- Load local CSV ----
covid <- read_csv("covid_19_data.csv")  # Make sure the file is in your project folder

# ---- Inspect dataset ----
head(covid)
names(covid)

# ---- Clean & Filter Dataset ----
covid_clean <- covid %>%
  select(ObservationDate, `Country/Region`, Confirmed, Deaths, Recovered) %>%
  rename(
    date = ObservationDate,
    location = `Country/Region`,
    new_cases = Confirmed,
    new_deaths = Deaths,
    new_recovered = Recovered
  ) %>%
  filter(location %in% c("South Africa", "US", "India")) %>%
  mutate(date = as.Date(date, format = "%m/%d/%Y"))

# ---- Summary Statistics ----
summary_stats <- covid_clean %>%
  group_by(location) %>%
  summarise(
    total_cases = sum(new_cases, na.rm = TRUE),
    total_deaths = sum(new_deaths, na.rm = TRUE),
    total_recovered = sum(new_recovered, na.rm = TRUE)
  )

print(summary_stats)
write.csv(summary_stats, "covid_summary.csv", row.names = FALSE)

# ---- Visualization 1: Daily Cases Trend ----
cases_plot <- ggplot(covid_clean, aes(x = date, y = new_cases, color = location)) +
  geom_line() +
  labs(title = "Daily COVID-19 Cases", x = "Date", y = "Confirmed Cases") +
  theme_minimal()

ggsave("daily_cases_plot.png", plot = cases_plot, width = 8, height = 5)

# ---- Visualization 2: Daily Deaths Trend ----
deaths_plot <- ggplot(covid_clean, aes(x = date, y = new_deaths, color = location)) +
  geom_line() +
  labs(title = "Daily COVID-19 Deaths", x = "Date", y = "Deaths") +
  theme_minimal()

ggsave("daily_deaths_plot.png", plot = deaths_plot, width = 8, height = 5)

# ---- Rolling 7-day Average ----
covid_clean <- covid_clean %>%
  group_by(location) %>%
  arrange(date) %>%
  mutate(new_cases_7davg = rollmean(new_cases, 7, fill = NA, align = "right"))

rolling_plot <- ggplot(covid_clean, aes(x = date, y = new_cases_7davg, color = location)) +
  geom_line(size = 1.2) +
  labs(title = "7-Day Rolling Average of COVID-19 Cases", x = "Date", y = "New Cases (7-day avg)") +
  theme_minimal()

ggsave("rolling_avg_cases_plot.png", plot = rolling_plot, width = 8, height = 5)

# ---- Correlation Analysis ----
correlation_stats <- covid_clean %>%
  group_by(location) %>%
  summarise(correlation = cor(new_cases, new_deaths, use = "complete.obs"))

print(correlation_stats)
write.csv(correlation_stats, "covid_correlation.csv", row.names = FALSE)

# ---- Save Cleaned Dataset ----
write.csv(covid_clean, "covid_cleaned.csv", row.names = FALSE)

