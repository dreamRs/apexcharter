
library(shiny)
library(apexcharter)

data("economics_long", package = "ggplot2")


ui <- fluidPage(
  
  tags$h2("Apexcharts Facets Example"),
  
  apexfacetOutput("myfacet")
  
)

server <- function(input, output, session) {
  
  output$myfacet <- renderApexfacet({
    apex(economics_long, aes(date, value), type = "line") %>% 
      ax_yaxis(tickAmount = 5) %>% 
      ax_facet_grid(vars(variable), scales = "free", chart_height = "200px")
  })
  
}

if (interactive())
  shinyApp(ui, server)
