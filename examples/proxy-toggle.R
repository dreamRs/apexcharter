
library(shiny)
library(apexcharter)


# data 
data("economics_long", package = "ggplot2")


ui <- fluidPage(
  tags$h2("Toggle series"),
  fluidRow(
    column(
      width = 3,
      actionButton("toggle", "Show/hide pop serie")
    ),
    column(
      width = 9,
      apexchartOutput(outputId = "chart")
    )
  )
)

server <- function(input, output, session) {
  
  output$chart <- renderApexchart({
    apex(
      data = economics_long, 
      type = "line", 
      mapping = aes(x = date, y = value01, group = variable), 
      auto_update = FALSE
    ) %>% 
      ax_yaxis(decimalsInFloat = 2)
  })
  
  observeEvent(input$toggle, {
    apexchartProxy("chart") %>% 
      ax_proxy_toggle_series(series_name = "pop")
  })
  
}

shinyApp(ui, server)