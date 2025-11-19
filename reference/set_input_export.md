# Retrieve chart's base64 dataURI.

Retrieve chart's base64 dataURI.

## Usage

``` r
set_input_export(ax, inputId, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- inputId:

  The id that will be used server-side for retrieving data.

- session:

  The Shiny session.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
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
```
