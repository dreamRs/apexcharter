
library(shiny)
library(apexcharter)
data("economics", package = "ggplot2")


ui <- fluidPage(
  tags$h3("Synchronize tooltip, zoom and panning between several charts"),
  fluidRow(
    column(
      width = 6,
      apexchartOutput("a1"),
      apexchartOutput("a3")
    ),
    column(
      width = 6,
      apexchartOutput("a2")
    )
  )
)

server <- function(input, output, session) {
  
  output$a1 <- renderApexchart({
    apex(
      data = tail(economics, 350), 
      mapping = aes(x = date, y = uempmed),
      type = "line", 
      synchronize = "economics"
    ) %>% 
      ax_labs(
        title = "Median duration of unemployment", 
        y = "In weeks"
      )
  })
  
  output$a2 <- renderApexchart({
    apex(
      data = tail(economics, 350), 
      mapping = aes(x = date, y = psavert),
      type = "line", 
      synchronize = "economics"
    ) %>% 
      ax_labs(
        title = "Personal savings rate", 
        y = "Percentage"
      )
  })
  
  output$a3 <- renderApexchart({
    apex(
      data = tail(economics, 350), 
      mapping = aes(x = date, y = pce),
      type = "line", 
      synchronize = "economics"
    ) %>% 
      ax_labs(
        title = "Personal consumption expenditures",
        y = "In billions of dollars"
      )
  })
  
}

shinyApp(ui, server)