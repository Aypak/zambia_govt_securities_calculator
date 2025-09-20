# Prepare zm bond interest data
zm_gb_interest_rates <- zm_bonds_scrape()

zm_gb_interest_rates <- zm_gb_interest_rates %>%
  # Get only rows that have maturity period greater than a year
  filter(str_detect(residual_maturity, "years")) %>%
  mutate(
    # Get the number of years from residual maturity string
    maturity_years = str_extract(residual_maturity, one_or_more(DIGIT)) %>%
      as.numeric(),
    annualized_yield_pct = annualized_yield/100,
    # Get number of coupon payments : 2 per year
    num_coupon_payments = maturity_years * 2,
    tax_rate = rep(0.15),
    handling_fee = rep(0.01)
  )
