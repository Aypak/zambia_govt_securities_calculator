# ==== server.R ====
library(shiny)
library(tidyverse)

server <- function(input, output, session) {

  # ---- Reactive lookups ----
  selected_A <- reactive({
    investment_df %>%
      filter(investment_type == "A", period == as.numeric(input$periodA)) %>%
      slice(1)   # ensures single row
  })

  selected_B <- reactive({
    investment_df %>%
      filter(investment_type == "B", period == as.numeric(input$periodB)) %>%
      slice(1)
  })

  # ---- Helper function to render breakdown ----
  render_breakdown <- function(amount, row) {
    rate     <- row$interest_rate
    tax_rate <- row$tax_rate

    payout_before_tax <- amount * rate
    tax_amount        <- payout_before_tax * tax_rate
    payout_after_tax  <- payout_before_tax - tax_amount

    HTML(paste0(
      "<div style='font-size:16px; line-height:1.6;'>",
      "<b>Investment Amount:</b> ", amount, "<br/>",
      "<b>Period (Years):</b> ", row$period, "<br/>",
      "<b>Interest Rate:</b> ", round(rate*100, 2), "%<br/>",
      "<b>Tax Rate:</b> ", round(tax_rate*100, 2), "%<br/><br/>",
      "<b>Payout Before Tax:</b> ", round(payout_before_tax, 2), "<br/>",
      " - Tax Deducted: ", round(tax_amount, 2), "<br/>",
      "<hr style='margin:8px 0;'/>",
      "<b style='font-size:18px; color:#2E86C1;'>Payout After Tax: ",
      round(payout_after_tax, 2), "</b>",
      "</div>"
    ))
  }

  # ---- Investment A ----
  output$resultsA <- renderUI({
    row <- selected_A()
    render_breakdown(input$amountA, row)
  })

  # ---- Investment B ----
  output$resultsB <- renderUI({
    row <- selected_B()
    render_breakdown(input$amountB, row)
  })
}
