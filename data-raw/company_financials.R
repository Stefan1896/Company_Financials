## code to prepare `company_financials` dataset goes here

#' @importFrom here here
#' @importFrom readr read_csv

financials <- read_csv(here("data-raw","company_financials.csv"))

usethis::use_data(financials, overwrite = TRUE)
