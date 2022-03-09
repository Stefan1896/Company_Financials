#' tab_one UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import dplyr
#' @import ggplot2
mod_tab_one_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("plot"))
  )
}

#' tab_one Server Functions
#'
#' @noRd
mod_tab_one_server <- function(id, variableInput){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$plot <- renderPlot(
      financials %>% arrange(desc(!!sym(variableInput()))) %>% head(10) %>%
        ggplot(aes(x=reorder(name, !!sym(variableInput())), y = !!sym(variableInput()))) +
        geom_bar(stat = "identity", fill = "#009966", alpha = 0.2, color = "black") +
        labs(x = "", y = "") +
        ggtitle(paste("Top 10 -")) +
        theme_classic() +
        coord_flip()
    )
  })
}

## To be copied in the UI
# mod_tab_one_ui("tab_one_1")

## To be copied in the server
# mod_tab_one_server("tab_one_1")
