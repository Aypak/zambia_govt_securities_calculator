# ==== ui.R ====
library(shiny)
library(shinythemes)
library(shinyBS)

ui <- fluidPage(
  theme = shinytheme("cosmo"),
  titlePanel("💰 Investment Payout Calculator"),

  tabsetPanel(
    tabPanel("Investment Type A",
             sidebarLayout(
               sidebarPanel(
                 numericInput("amountA", "Investment Amount:", value = 1000, min = 0),
                 bsTooltip("amountA", "Enter the amount you plan to invest (non-negative number).",
                           placement = "right", trigger = "hover"),

                 selectInput("periodA", "Investment Period (Years):",
                             choices = unique(investment_df$period), selected = 1),
                 bsTooltip("periodA", "Select how long you will invest, from 3 months up to 20 years.",
                           placement = "right", trigger = "hover")
               ),
               mainPanel(
                 h4("📊 Results for Investment A"),
                 wellPanel(uiOutput("resultsA"))
               )
             )),

    tabPanel("Investment Type B",
             sidebarLayout(
               sidebarPanel(
                 numericInput("amountB", "Investment Amount:", value = 1000, min = 0),
                 bsTooltip("amountB", "Enter the amount you plan to invest (non-negative number).",
                           placement = "right", trigger = "hover"),

                 selectInput("periodB", "Investment Period (Years):",
                             choices = unique(investment_df$period), selected = 1),
                 bsTooltip("periodB", "Select how long you will invest, from 3 months up to 20 years.",
                           placement = "right", trigger = "hover")
               ),
               mainPanel(
                 h4("📊 Results for Investment B"),
                 wellPanel(uiOutput("resultsB"))
               )
             ))
  )
)
