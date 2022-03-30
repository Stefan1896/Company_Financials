## code to prepare `company_financials` dataset goes here

#' @importFrom here here
#' @importFrom readr read_csv
#' @importFrom janitor make_clean_names
#' @importFrom dplyr mutate

financials <- read_csv(here("data-raw","company_financials.csv"))

#clean names and get sales variable
names_original <- c(names(financials), "Sales", "Net Profit")
names(financials) <- make_clean_names(names(financials))
financials <- financials %>% mutate(sales = market_cap/price_sales, net_profit = earnings_share * (market_cap/price))
selected_financials <- c("price_earnings", "market_cap", "ebitda", "price_sales","price_book", "sales","net_profit")
indicator <- names(financials) %in%  selected_financials
selected_names <- names(financials)[indicator]
names(selected_names) <- names_original[indicator]

usethis::use_data(selected_names, overwrite = TRUE)
usethis::use_data(financials, overwrite = TRUE)
