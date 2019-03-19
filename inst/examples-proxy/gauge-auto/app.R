
#  ------------------------------------------------------------------------
#
# Title : Gauge auto-proxy
#    By : Victor
#  Date : 2019-03-13
#
#  ------------------------------------------------------------------------



library(apexcharter)
library(shiny)


ui <- fluidPage(
  tags$h2("Gauge auto-proxy example"),
  fluidRow(
    column(
      width = 4,
      apexchartOutput(outputId = "gauge1")
    ),
    column(
      width = 4,
      apexchartOutput(outputId = "gauge2")
    ),
    column(
      width = 4,
      apexchartOutput(outputId = "gauge3")
    )
  ),
  actionButton(inputId = "update", label = "Update values !")
)

server <- function(input, output, session) {
  
  output$gauge1 <- renderApexchart({
    input$update
    val <- sample.int(100, 1)
    apex(data = NULL, type = "radialBar", mapping = aes(x = "My value", y = val))
  })
  
  output$gauge2 <- renderApexchart({
    input$update
    val <- sample.int(100, 1)
    apex(data = NULL, type = "radialBar", mapping = aes(x = "My value", y = val))
  })
  
  output$gauge3 <- renderApexchart({
    input$update
    val <- sample.int(100, 1)
    apex(data = NULL, type = "radialBar", mapping = aes(x = "My value", y = val))
  })
  
}

shinyApp(ui, server)
