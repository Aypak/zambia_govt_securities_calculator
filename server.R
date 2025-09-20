# ==== server.R ====
library(shiny)
library(tidyverse)

server <- function(input, output, session) {

  # ---- Reactive lookups ----
  selected_tb <- reactive({
    treasury_bill_config %>%
      filter(tenure_string == input$tenure_tb) %>%
      slice(1)
  })

  # selected_B <- reactive({
  #   investment_df %>%
  #     filter(investment_type == "B", period == as.numeric(input$periodB)) %>%
  #     slice(1)
  # })

  # ---- Helper function to render breakdown ----
  # render_breakdown <- function(amount, row) {
  #   rate     <- row$interest_rate
  #   tax_rate <- row$tax_rate

  #   payout_before_tax <- amount * rate
  #   tax_amount        <- payout_before_tax * tax_rate
  #   payout_after_tax  <- payout_before_tax - tax_amount

  #   HTML(paste0(
  #     "<div style='font-size:16px; line-height:1.6;'>",
  #     "<b>Investment Amount:</b> ", amount, "<br/>",
  #     "<b>Period (Years):</b> ", row$period, "<br/>",
  #     "<b>Interest Rate:</b> ", round(rate*100, 2), "%<br/>",
  #     "<b>Tax Rate:</b> ", round(tax_rate*100, 2), "%<br/><br/>",
  #     "<b>Payout Before Tax:</b> ", round(payout_before_tax, 2), "<br/>",
  #     " - Tax Deducted: ", round(tax_amount, 2), "<br/>",
  #     "<hr style='margin:8px 0;'/>",
  #     "<b style='font-size:18px; color:#2E86C1;'>Payout After Tax: ",
  #     round(payout_after_tax, 2), "</b>",
  #     "</div>"
  #   ))
  # }


  render_breakdown_tb <- function(amount, row) {
    interest_rate<- row$interest_rate
    tax_rate <- row$tax_rate
    handling_fee <- row$handling_fee
    anum_frac <- row$anum_frac

    effective_interest_amount <- amount * interest_rate * anum_frac
    discount_price <- amount - effective_interest_amount
    tax_amount <- effective_interest_amount * tax_rate
    handling_amount <- effective_interest_amount * handling_fee
    expected_payout  <- effective_interest_amount - (tax_amount + handling_amount)

    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>",
      "<b>You lend out:</b> ",
      discount_price,
      "<br/>",
      "<b>You get paid back:</b> ",
      amount,
      "<br/>",
      "<b>After Period:</b> ",
      row$tenure_string,
      "<br/>",
      # "<b>Interest Rate:</b> ",
      # round(interest_rate * 100, 2),
      # "%<br/>",
      "<b>Tax: </b> ",
      round(tax_amount, 2),
      "<br/>",
      "<b>Handling Fee:</b> ",
      round(handling_amount, 2),
      "<br/>",
      "<hr style='margin:8px 0;'/>",
      "<b style='font-size:18px; color:#2E86C1;'>Expected Profit: ",
      round(expected_payout, 2),
      "</b>",
      "</div>"
    ))
  }

  # render_breakdown_gb <- function(amount, row) {
  #   rate <- row$interest_rate
  #   tax_rate <- row$tax_rate

  #   payout_before_tax <- amount * rate
  #   tax_amount <- payout_before_tax * tax_rate
  #   payout_after_tax <- payout_before_tax - tax_amount

  #   HTML(paste0(
  #     "<div style='font-size:16px; line-height:1.6;'>",
  #     "<b>Investment Amount:</b> ",
  #     amount,
  #     "<br/>",
  #     "<b>Period (Years):</b> ",
  #     row$period,
  #     "<br/>",
  #     "<b>Interest Rate:</b> ",
  #     round(rate * 100, 2),
  #     "%<br/>",
  #     "<b>Tax Rate:</b> ",
  #     round(tax_rate * 100, 2),
  #     "%<br/><br/>",
  #     "<b>Payout Before Tax:</b> ",
  #     round(payout_before_tax, 2),
  #     "<br/>",
  #     " - Tax Deducted: ",
  #     round(tax_amount, 2),
  #     "<br/>",
  #     "<hr style='margin:8px 0;'/>",
  #     "<b style='font-size:18px; color:#2E86C1;'>Payout After Tax: ",
  #     round(payout_after_tax, 2),
  #     "</b>",
  #     "</div>"
  #   ))
  # }

  # ---- Investment A ----
  output$results_tb <- renderUI({
    row <- selected_tb()
    render_breakdown_tb(input$face_value_tb, row)
  })

  # ---- Investment B ----
  # output$resultsB <- renderUI({
  #   row <- selected_B()
  #   render_breakdown(input$amountB, row)
  # })
}
