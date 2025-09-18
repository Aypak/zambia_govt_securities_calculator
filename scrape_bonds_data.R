# World govt bonds url
url <- "https://www.worldgovernmentbonds.com/wp-json/country/v1/main"

# Payload for Zambia (as JSON)
payload <- list(
  GLOBALVAR = list(
    JS_VARIABLE = "jsGlobalVars",
    FUNCTION = "Country",
    DOMESTIC = TRUE,
    ENDPOINT = "https://www.worldgovernmentbonds.com/wp-json/country/v1/historical",
    DATE_RIF = "2099-12-31",
    OBJ = NULL,
    COUNTRY1 = list(
      SYMBOL = "73",
      PAESE = "Zambia",
      PAESE_UPPERCASE = "ZAMBIA",
      BANDIERA = "zm",
      URL_PAGE = "zambia"
    ),
    COUNTRY2 = NULL,
    OBJ1 = NULL,
    OBJ2 = NULL
  )
)

# Convert payload to JSON string
payload_json <- toJSON(payload, auto_unbox = TRUE)

# Custom headers
headers <- c(
  "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0",
  "Accept" = "*/*",
  "Accept-Language" = "en-US,en;q=0.5",
  "Accept-Encoding" = "gzip, deflate, br, zstd",
  "Referer" = "https://www.worldgovernmentbonds.com/country/egypt/",
  "Content-Type" = "application/json; charset=UTF-8",
  "Origin" = "https://www.worldgovernmentbonds.com",
  "DNT" = "1",
  "Connection" = "keep-alive"
)

# Send POST request
response <- POST(url, body = payload_json, add_headers(.headers = headers))

# Check if request was successful
if (http_error(response)) {
  stop("Request failed: ", status_code(response))
}

# Parse response JSON
data <- content(response, as = "text", encoding = "UTF-8")
data_json <- fromJSON(data, flatten = TRUE) %>% as.data.frame()

# Parse current yield html
current_yield <- parse_html_table(data_json$mainTable[1])

# Parse yield history html
yield_history <- parse_html_table(data_json$historyTable[1])

# Extract main indicators
main_indicators_vars <- c(
  "lastTimeValDesc",
  "lastRatingValue",
  "bond10y",
  "mainSpreadValue",
  "cbRateNumber",
  "lastCds"
)

main_indicators <- data_json %>%
  select(
    all_of(main_indicators_vars)
  )

# Extract current bond yield rates
current_yield_clean <- current_yield %>%
  clean_names() %>%
  slice(-1) %>%
  remove_empty() %>%
  # Extract numeric values from all columns except maturity and last_updated
  mutate(
    across(-c(residual_maturity,last_update),
    extract_numeric_value_from_string)
  )
