library(shiny)
library(apexcharter)

ui <- fluidPage(
  fluidRow(
    column(
      width = 8, offset = 2,
      tags$h2("Export PNG"),
      actionButton("redraw", "Redraw chart"),
      apexchartOutput("chart"),
      verbatimTextOutput("result"),
      uiOutput(outputId = "image")
    )
  )
)

server <- function(input, output, session) {
  
  output$chart <- renderApexchart({
    input$redraw
    apexchart() %>%
      ax_chart(type = "bar") %>%
      ax_series(
        list(
          name = "Example",
          data = sample(1:100, 5)
        )
      ) %>%
      ax_xaxis(
        categories = LETTERS[1:5]
      ) %>% 
      set_input_export("export")
  })
  
  output$result <- renderPrint({
    input$export
  })

  output$image <- renderUI({
    tags$img(src = input$export)
  })
  
}

if (interactive())
  shinyApp(ui, server)

