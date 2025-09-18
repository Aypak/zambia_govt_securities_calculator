library(tidyverse)
library(httr)
library(jsonlite)
library(dplyr)
library(rebus)
source("helpers.R")


# Quarterly periods: 3 months (0.25 years) up to 20 years
periods <- seq(0.25, 20, by = 0.25)

# Create tidy data frame with interest and tax rates
investment_df <- tibble(
  period = rep(periods, 2),
  investment_type = rep(c("A", "B"), each = length(periods)),
  interest_rate = c(
    seq(0.02, 0.08, length.out = length(periods)),  # Type A: 2% to 8%
    seq(0.03, 0.10, length.out = length(periods))   # Type B: 3% to 10%
  ),
  tax_rate = c(
    rep(0.25, length(periods)),  # Type A tax = 25%
    rep(0.30, length(periods))   # Type B tax = 30%
  )
)
