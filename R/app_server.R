#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFROM janitor make_clean_names
#' @noRd
app_server <- function(input, output, session) {
  selected_variable <- reactive(input$variable)
  mod_tab_one_server("tab_one_1", selected_variable)
  mod_tab_two_server("tab_two_1")
}
