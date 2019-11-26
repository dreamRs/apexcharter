if (interactive()) {
  library(shiny)
  library(apexcharter)
  
  ui <- fluidPage(
    fluidRow(
      column(
        width = 8, offset = 2,
        tags$h2("Apexchart in Shiny"),
        actionButton("redraw", "Redraw chart"),
        apexchartOutput("chart")
      )
    )
  )
  
  server <- function(input, output, session) {
    
    output$chart <- renderApexchart({
      input$redraw
      apexchart() %>%
        ax_chart(type = "bar") %>%
        ax_series(
          list(
            name = "Example",
            data = sample(1:100, 5)
          )
        ) %>%
        ax_xaxis(
          categories = LETTERS[1:5]
        )
    })
    
  }
  
  shinyApp(ui, server)
}
