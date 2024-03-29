#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
#'
#'
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    dashboardPage(skin = "black",
                  title = "CompanyFinancials",
      dashboardHeader(title = "S&P500 Financials"
      ),
      dashboardSidebar(sidebarMenu(
        menuItem("Overview", tabName = "tab_one", icon = icon("angle-double-right")),
        menuItem("Regression", tabName = "tab_two", icon = icon("angle-double-right")),
        br(),
        selectInput("variable", "Select your variable:", names(selected_names))
      )),
      dashboardBody(
        tabItems(
          tabItem(tabName = "tab_one",
            mod_tab_one_ui("tab_one_1")
          ),
          tabItem(tabName = "tab_two",
            mod_tab_two_ui("tab_two_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "CompanyFinancialsProject"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
