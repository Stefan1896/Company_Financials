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
    fluidRow(
      column(5,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:#FF0000">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Movie Ratings - IMDB Scores by Genre</span>'),
            plotOutput(ns("top_n")),
            width = 12
        )
      ),
      column(6,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:#FF0000">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Movie Ratings - IMDB Scores by Genre</span>'),
            plotOutput(ns("distribution")),
            width = 12
        )
      )
    ),
    fluidRow(
      column(5,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:#FF0000">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Movie Ratings - IMDB Scores by Genre</span>'),
            plotOutput(ns("botton_n")),
            width = 12
        )
      ),
      column(6,
        box(title = HTML('<span class="fa-stack fa-lg" style="color:#FF0000">
                            <i class="fa fa-square fa-stack-2x"></i>
                            <i class="fa fa-chart-bar fa-inverse fa-stack-1x"></i>
                            </span> <span style="font-weight:bold;font-size:20px">
                            Movie Ratings - IMDB Scores by Genre</span>'),
            plotOutput(ns("sector")),
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
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    #to-do - ignore missing data for one variable
    output$top_n <- renderPlot({
      financials %>% arrange(desc(!!sym(variableInput()))) %>% head(10) %>%
        ggplot(aes(x=reorder(name, !!sym(variableInput())), y = !!sym(variableInput()))) +
        geom_bar(stat = "identity", fill = "#009966", alpha = 0.2, color = "black") +
        labs(x = "", y = "") +
        ggtitle(paste("Top 10 -", variableInput())) +
        theme_classic() +
        coord_flip()
    })

    output$botton_n <- renderPlot({
      financials %>% arrange(desc(!!sym(variableInput()))) %>% tail(10) %>%
        ggplot(aes(x=reorder(name, !!sym(variableInput())), y = !!sym(variableInput()))) +
        geom_bar(stat = "identity", fill = "indianred", alpha = 0.2, color = "black") +
        labs(x = "", y = "") +
        ggtitle(paste("Botton 10 -", variableInput())) +
        theme_classic() +
        coord_flip()
    })

    output$distribution <- renderPlot({
      ggplot(financials, aes_string(x=variableInput())) +
        geom_histogram(aes(y=..density..), colour="black", fill="white")+
        geom_density(alpha=.2, fill="#009966")+
        labs(x = variableInput(), y = "") +
        theme_classic()
    })

    output$sector <- renderPlot({
      financials %>% filter(sector != "Telecommunication Services") %>%
        ggplot(aes(x=sector, y = (!!sym(variableInput()))^(1/3))) +
        geom_boxplot(outlier.shape = NA) +
        geom_jitter(width=0.1, alpha=0.2, color = "#009966") +
        labs(x = "", y = paste(variableInput(), "- Cube Root transformatted")) +
        theme_classic() +
        coord_flip()
    })


  })
}
