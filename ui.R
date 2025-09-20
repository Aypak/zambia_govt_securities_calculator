library(shiny)
library(shinythemes)
library(shinyBS)

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("💰 Zambia Government Securities Payout Calculator"),

  tabsetPanel(
    tabPanel(
      "Treasury Bill",
      sidebarLayout(
        sidebarPanel(
          numericInput(
            "face_value_tb",
            "Face Value Amount:",
            value = 1000,
            min = 1000,
            max = 400000
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
          h4("📊 Breakdown"),
          wellPanel(uiOutput("results_tb"))
        )
      )
    ),

    tabPanel(
      "Government Bond",
      sidebarLayout(
        sidebarPanel(
          numericInput(
            "maturity_value_gb",
            "Investment Amount:",
            value = 1000,
            min = 1000,
            max = 400000
          ),
          bsTooltip(
            "maturity_value_gb",
            "The amount of money you lend to the government",
            placement = "right",
            trigger = "hover"
          ),

          selectInput(
            "maturity_period_gb",
            "Maturity Period:",
            choices = unique(zm_gb_interest_rates$residual_maturity),
            selected = 1
          ),
          bsTooltip(
            "maturity_period_gb",
            "How long you lend your money to the Government (2 years to 15 years)",
            placement = "right",
            trigger = "hover"
          )
        ),
        mainPanel(
          h4("📊 Breakdown"),
          wellPanel(uiOutput("results_gb"))
        )
      )
    ),
    tabPanel(
      "Disclaimer",
      h3("Disclaimer"),
      p(
        "This application is provided for informational and educational purposes only. The calculations and results presented do not constitute financial advice, investment advice, or tax advice. The developer makes no guarantees regarding the accuracy, completeness, or suitability of the information provided. Users are solely responsible for any financial decisions they make based on this application and assume all risks and consequences arising from those decisions. Always consult a qualified financial professional before making investment or tax-related decisions."
      )
    )
  )
)
