
library(shiny)
library(apexcharter)
data("economics", package = "ggplot2")

ui <- fluidPage(
  tags$h2("Retrieve selection information"),
  fluidRow(
    column(
      width = 8,
      tags$b("Datetime"),
      apexchartOutput("chart1")
    ),
    column(
      width = 4,
      verbatimTextOutput("result1")
    )
  ),
  fluidRow(
    column(
      width = 8,
      tags$b("Scatter"),
      apexchartOutput("chart2")
    ),
    column(
      width = 4,
      verbatimTextOutput("result2")
    )
  )
)

server <- function(input, output, session) {
  
  output$chart1 <- renderApexchart({
    apex(economics, aes(date, psavert), type = "line") %>% 
      set_input_selection("selection_ts")
  })
  output$result1 <- renderPrint({
    input$selection_ts
  })
  
  output$chart2 <- renderApexchart({
    apex(iris, aes(Sepal.Length, Sepal.Width), type = "scatter") %>% 
      set_input_selection("selection_scatter", type = "xy")
  })
  output$result2 <- renderPrint({
    input$selection_scatter
  })
  
}

shinyApp(ui, server)
