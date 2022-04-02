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
#' @importFrom tidyr drop_na

mod_tab_one_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(5,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:black">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Distribution </span>'),
            plotOutput(ns("distribution")),
            width = 12
        )
      ),
      column(6,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:black">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Sector Analysis </span>'),
            plotOutput(ns("sector")),
            width = 12
        )
      )
    ),
    fluidRow(
      column(5,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:black">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Top 10 </span>'),
            plotOutput(ns("top_n")),
            width = 12
        )
      ),
      column(6,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:black">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Botton 10 </span>'),
            plotOutput(ns("botton_n")),
            width = 12
        )
      )
    )
  )
}

#' tab_one Server Functions
#'
#' @noRd
mod_tab_one_server <- function(id, variableInput){
  stopifnot(is.reactive(variableInput))

  moduleServer( id, function(input, output, session){
    ns <- session$ns
    indicator <- reactive(variableInput() == selected_names)

    financials_no_missing <- reactive(financials %>%
                                        arrange(desc(!!sym(variableInput()))) %>%
                                        drop_na(!!sym(variableInput())))

    #to-do - ignore missing data for one variable
    output$top_n <- renderPlot({
      financials_no_missing() %>% head(10) %>%
        ggplot(aes(x=reorder(name, !!sym(variableInput())), y = !!sym(variableInput()))) +
        geom_bar(stat = "identity", fill = "#009966", alpha = 0.2, color = "black") +
        labs(x = "", y = names(selected_names)[indicator()]) +
        theme_classic() +
        coord_flip()
    })

    output$botton_n <- renderPlot({
      financials_no_missing() %>% tail(10) %>%
        ggplot(aes(x=reorder(name, !!sym(variableInput())), y = !!sym(variableInput()))) +
        geom_bar(stat = "identity", fill = "indianred", alpha = 0.2, color = "black") +
        labs(x = "", y = names(selected_names)[indicator()]) +
        theme_classic() +
        coord_flip()
    })

    output$distribution <- renderPlot({
      financials_no_missing() %>%
      ggplot(aes_string(x=variableInput())) +
        geom_histogram(aes(y=..density..), colour="black", fill="white")+
        geom_density(alpha=.2, fill="black")+
        labs(x = names(selected_names)[indicator()], y = "") +
        theme_classic()
    })

    output$sector <- renderPlot({
      financials_no_missing() %>% filter(sector != "Telecommunication Services") %>%
        ggplot(aes(x=sector, y = cube_root((!!sym(variableInput()))))) +
        geom_boxplot(outlier.shape = NA) +
        geom_jitter(width=0.1, alpha=0.2, color = "black") +
        labs(x = "", y = paste(names(selected_names)[indicator()], "- Cube Root transformatted")) +
        theme_classic() +
        coord_flip()
    })

  })
}
