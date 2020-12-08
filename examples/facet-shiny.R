
library(shiny)
library(htmltools)
library(apexcharter)

data("unhcr_ts")
refugees <- unhcr_ts %>% 
  subset(population_type == "Refugees (incl. refugee-like situations)") %>% 
  transform(date = as.Date(paste0(year, "-01-01")))


ui <- fluidPage(
  
  tags$h2("Apexcharts Facets Example"),
  
  apexfacetOutput("myfacet")
  
)

server <- function(input, output, session) {
  
  output$myfacet <- renderApexfacet({
    apex(refugees, aes(date, n), type = "line") %>% 
      ax_yaxis(tickAmount = 5) %>% 
      ax_facet_wrap(vars(continent_origin))
  })
  
}

if (interactive())
  shinyApp(ui, server)




