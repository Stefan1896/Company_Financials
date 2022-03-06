#' tab_two UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_tab_two_ui <- function(id){
  ns <- NS(id)
  tagList(
    h1("Module 2")
  )
}

#' tab_two Server Functions
#'
#' @noRd
mod_tab_two_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_tab_two_ui("tab_two_1")

## To be copied in the server
# mod_tab_two_server("tab_two_1")
