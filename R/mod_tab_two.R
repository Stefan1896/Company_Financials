#' tab_two UI Function
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
#' @importFrom gridExtra grid.arrange

mod_tab_two_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      box(title = HTML('<span class="fa-stack fa-lg" style="color:black">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Relationship Financials </span>'),
          plotOutput(ns("regressions")),
          width = 12
      )
    )
  )
}

#' tab_two Server Functions
#'
#' @noRd
mod_tab_two_server <- function(id, variableInput){
  stopifnot(is.reactive(variableInput))

  moduleServer( id, function(input, output, session){
    ns <- session$ns
    variables_without_selection <- reactive(selected_names[selected_names != variableInput()])
    indicator <- reactive(variableInput() == selected_names)


    output$regressions <- renderPlot({

      #loop through selected financial variable names without sales to plot each numeric variable cube root transformated with selected variable
      ps <- list()
      j = 1
      for(i in variables_without_selection()){
        ps[[j]] <- financials %>%
          ggplot(aes(x=(!!sym(variableInput()))^(1/3), y = (!!sym(i))^(1/3))) +
          geom_point(col = "black", alpha = 0.2) +
          geom_smooth(method='lm', formula= y~x, se = FALSE, color = "indianred") +
          labs(x = "", y = "") +
          ggtitle(paste(names(selected_names)[indicator()], "vs", names(variables_without_selection()[j]))) +
          theme_classic()
        j = j+1
      }
      do.call(
        grid.arrange,c(ps, ncol=3))
    })
  })
}
