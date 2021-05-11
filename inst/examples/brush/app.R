
#  ------------------------------------------------------------------------
#
# Title : apexcharts brush example
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
      tags$h2("Apexchart brush example in Shiny", class = "text-center"),
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
        id = "target-chart",
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
          target = "target-chart", # <-- use target id here
          enabled = TRUE
        ),
        offsetY = -20,
        selection = list(
          enabled = TRUE, # <-- enable selection and define starting range
          xaxis = list(
            min = format_date(economics$date[1]),
            max = format_date(economics$date[100])
          )
        )
      ) %>%
      ax_xaxis(labels = list(show = FALSE)) %>%
      ax_yaxis(labels = list(show = FALSE))
  })
  
}

shinyApp(ui, server)

