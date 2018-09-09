
#  ------------------------------------------------------------------------
#
# Title : Update serie
#    By : Victor
#  Date : 2018-09-09
#
#  ------------------------------------------------------------------------



library(shiny)
library(apexcharter)



ui <- fluidPage(
  tags$h2("Radomly update serie"),
  apexchartOutput(outputId = "graph", width = "600px"),
  actionButton(inputId = "update", label = "Update data")
)

server <- function(input, output, session) {
  
  output$graph <- renderApexchart({
    apexchart() %>% 
      ax_chart(type = "line") %>% 
      ax_plotOptions(line = list(curve = "smooth")) %>% 
      ax_dataLabels(enabled = FALSE) %>% 
      ax_series(
        list(
          name = "rnorm",
          data = round(rnorm(20), 3)
        )
      )
  })
  
  observeEvent(input$update, {
    apexchartProxy(shinyId = "graph") %>% 
      ax_proxy_series(newSeries = list(data = round(rnorm(20), 3)))
  })
  
}

shinyApp(ui, server)


