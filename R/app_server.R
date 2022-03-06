#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  mod_tab_one_server("tab_one_1")
  mod_tab_two_server("tab_two_1")
}
