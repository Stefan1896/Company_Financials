#' tab_one UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab_one_ui <- function(id){
  ns <- NS(id)
  tagList(
 
  )
}
    
#' tab_one Server Functions
#'
#' @noRd 
mod_tab_one_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab_one_ui("tab_one_1")
    
## To be copied in the server
# mod_tab_one_server("tab_one_1")
