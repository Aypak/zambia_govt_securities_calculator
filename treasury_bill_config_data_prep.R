treasury_bill_tenures_days <- c(91, 182, 273, 364)
treasury_bill_approx_interest_rates <- c(0.11, 0.12, 0.13, 0.14)

treasury_bill_config <- data.frame(
  tenure = treasury_bill_tenures_days,
  investment_type = rep("Treasury Bill"),
  interest_rate = treasury_bill_approx_interest_rates,
  tax_rate = rep(0.15),
  handling_fee = rep(0.01)
) %>%
  mutate(
    tenure_string = paste(tenure, "days"),
    tenures_quarters = floor(tenure / 90),
    anum_frac = tenures_quarters / 4
  )
