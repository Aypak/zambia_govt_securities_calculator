library(shiny)
library(shinythemes)
library(shinyBS)

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("💰 Investment Payout Calculator"),

  tabsetPanel(
    tabPanel(
      "Treasury Bill",
      sidebarLayout(
        sidebarPanel(
          numericInput(
            "face_value_tb",
            "Face Value Amount:",
            value = 1000,
            min = 0
          ),
          bsTooltip(
            "face_value_tb",
            "The amount that Government promises to pay you at the end of your investment's maturity period",
            placement = "right",
            trigger = "hover"
          ),

          selectInput(
            "tenure_tb",
            "Maturity Period:",
            choices = unique(treasury_bill_config$tenure_string),
            selected = 1
          ),
          bsTooltip(
            "tenure_tb",
            "How long you lend your money to the Government (31 days to 364 days)",
            placement = "right",
            trigger = "hover"
          )
        ),
        mainPanel(
          h4("📊 Expected Payout"),
          wellPanel(uiOutput("results_tb"))
        )
      )
    ),

    # tabPanel(
    #   "Government Bond",
    #   sidebarLayout(
    #     sidebarPanel(
    #       numericInput(
    #         "maturity_value_gb",
    #         "Investment Amount:",
    #         value = 1000,
    #         min = 0
    #       ),
    #       bsTooltip(
    #         "maturity_value_gb",
    #         "The amount of money you lend to the government",
    #         placement = "right",
    #         trigger = "hover"
    #       ),

    #       selectInput(
    #         "maturity_period_gb",
    #         "Maturity Period:",
    #         choices = unique(investment_df$period),
    #         selected = 1
    #       ),
    #       bsTooltip(
    #         "maturity_period_gb",
    #         "How long you lend your money to the Government (2 years to 15 years)",
    #         placement = "right",
    #         trigger = "hover"
    #       )
    #     ),
    #     mainPanel(
    #       h4("📊 Expected Payout"),
    #       wellPanel(uiOutput("results_gb"))
    #     )
    #   )
    # )
  )
)
