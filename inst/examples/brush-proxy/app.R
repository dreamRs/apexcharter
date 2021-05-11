
#  ------------------------------------------------------------------------
#
# Title : apexcharts brush example (alternative)
#    By : Victor
#  Date : 2020-07-24
#
#  ------------------------------------------------------------------------


library(shiny)
library(apexcharter)
data("economics", package = "ggplot2")

ui <- fluidPage(
  fluidRow(
    column(
      width = 8, offset = 2,
      tags$h2("Apexchart brush example (alternative) in Shiny", class = "text-center"),
      apexchartOutput("brush_1"),
      apexchartOutput("brush_2", height = "130px")
    )
  )
)

server <- function(input, output, session) {
  
  output$brush_1 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = psavert),
      type = "line"
    ) %>%
      ax_chart(
        toolbar = list(
          autoSelected = "pan",
          show = FALSE
        )
      )
  })
  
  output$brush_2 <- renderApexchart({
    apex(
      data = economics,
      mapping = aes(x = date, y = psavert),
      type = "line"
    ) %>%
      ax_chart(
        brush = list(
          enabled = TRUE
        ),
        offsetY = -20,
        selection = list(
          enabled = TRUE
        )
      ) %>%
      ax_xaxis(labels = list(show = FALSE)) %>%
      ax_yaxis(labels = list(show = FALSE)) %>% 
      set_input_selection(
        inputId = "brush", 
        xmin = format_date(economics$date[1]),
        xmax = format_date(economics$date[100])
      )
  })
  
  observeEvent(input$brush, {
    apexchartProxy("brush_1") %>% 
      ax_proxy_options(list(
        xaxis = list(
          min = as.numeric(input$brush$x$min) * 1000,
          max = as.numeric(input$brush$x$max) * 1000
        )
      ))
  })
  
}


shinyApp(ui, server)

