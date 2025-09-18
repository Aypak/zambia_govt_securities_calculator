parse_html_table <- function(html_string) {
  # Read HTML
  html <- read_html(html_string)

  # Extract table
  table_node <- html %>% html_node("table")

  # Convert to dataframe
  df <- table_node %>% html_table(fill = TRUE)

  return(df)
}


extract_numeric_value_from_string <- Vectorize(
  function(string_val){
    str_extract(
      string_val,
      one_or_more(rebus::DIGIT) %R% DOT %R% one_or_more(rebus::DIGIT)
    ) %>%
      as.numeric()
  }
)
