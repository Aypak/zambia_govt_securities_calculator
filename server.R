server <- function(input, output, session) {
  # ---- Reactive lookups ----
  selected_tb <- reactive({
    treasury_bill_config %>%
      filter(tenure_string == input$tenure_tb) %>%
      slice(1)
  })

  selected_gb <- reactive({
    zm_gb_interest_rates %>%
      filter(residual_maturity == (input$maturity_period_gb)) %>%
      slice(1)
  })

  render_breakdown_tb <- function(amount, row) {
    interest_rate <- row$interest_rate
    tax_rate <- row$tax_rate
    handling_fee <- row$handling_fee
    anum_frac <- row$anum_frac

    effective_interest_amount <- amount * interest_rate * anum_frac
    discount_price <- amount - effective_interest_amount
    tax_amount <- effective_interest_amount * tax_rate
    handling_amount <- effective_interest_amount * handling_fee
    expected_profit <- effective_interest_amount -
      (tax_amount + handling_amount)

    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>",
      "<b>You lend out:</b> ",
      discount_price,
      "<br/>",
      "<b>At Approx Interest Rate:</b> ",
      round(interest_rate * 100, 2),
      "%<br/>",
      "<b>You get paid back:</b> ",
      amount,
      "<br/>",
      "<b>After Period:</b> ",
      row$tenure_string,
      "<br/>",
      "- Tax: ",
      round(tax_amount, 2),
      "<br/>",
      "- Handling Fee: ",
      round(handling_amount, 2),
      "<br/>",
      "<hr style='margin:8px 0;'/>",
      "<b style='font-size:18px; color:#2E86C1;'>Expected Profit: ",
      round(expected_profit, 2),
      "</b>",
      "</div>"
    ))
  }

  render_breakdown_gb <- function(amount, row) {
    interest_rate <- row$annualized_yield_pct
    tax_rate <- row$tax_rate
    handling_fee <- row$handling_fee
    num_coupon_payments <- row$num_coupon_payments
    maturity_period <- row$residual_maturity

    annual_coupon_amount <- amount * interest_rate
    annual_tax_amount <- annual_coupon_amount * tax_rate
    annual_handling_fee <- annual_coupon_amount * handling_fee
    annual_payout_after_tax <- annual_coupon_amount - (annual_tax_amount + annual_handling_fee)
    single_coupon_amount <- annual_payout_after_tax/2

    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>",
      "<b>You lend out:</b> ",
      amount,
      "<br/>",
      "<b>For period:</b> ",
      row$residual_maturity,
      "<br/>",
      "<b>At approx Interest Rate:</b> ",
      round(interest_rate * 100, 2),
      "%<br/>",
      "<b>Annual Coupon Amount: </b> ",
      round(annual_coupon_amount, 2),
      "<br/>",
      " - Annual Tax Deducted: ",
      round(annual_tax_amount, 2),
      "<br/>",
      " - Annual Handling fee: ",
      round(annual_handling_fee, 2),
      "<br/>",
      "<hr style='margin:8px 0;'/>",
      "<b style='font-size:18px; color:#2E86C1;'>You Receive: ",
      num_coupon_payments, " payments of ",
      round(single_coupon_amount,2),
      " over a period of ",
      maturity_period,
      "</b>",
      "<br/>",
      "<b style='font-size:18px; color:#2E86C1;'>Then you receive your inital investment amount</b>",
      "</div>"
    ))
  }

  # ---- Render breakdown for selected Treasury Bill----
  output$results_tb <- renderUI({
    row <- selected_tb()
    render_breakdown_tb(input$face_value_tb, row)
  })

  # ---- Render breakdown for selected Government Bond ----
  output$results_gb <- renderUI({
    row <- selected_gb()
    render_breakdown_gb(input$maturity_value_gb, row)
  })
}
