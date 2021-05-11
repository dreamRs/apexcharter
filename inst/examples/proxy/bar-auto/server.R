

library(shiny)
library(apexcharter)
library(dplyr)

data("mpg", package = "ggplot2")

function(input, output, session) {
  
  data_r <- reactive({
    mympg <- mpg %>% 
      filter(cty >= input$cty & year %in% input$year) %>% 
      count(manufacturer, year)
    
    if (input$keepallx) {
      mympg <- left_join(
          x = mpg %>% distinct(manufacturer, year),
          y = mympg,
          by = c("manufacturer", "year")
        )
    }
    
    mympg
  })
  
  
  output$chart <- renderApexchart({
    apex(data = data_r(), type = "bar", mapping = aes(x = manufacturer, y = n, fill = year))
  })
  
}
