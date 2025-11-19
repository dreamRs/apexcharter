# Events options

Events options

## Usage

``` r
events_opts(
  click = NULL,
  beforeMount = NULL,
  mounted = NULL,
  updated = NULL,
  legendClick = NULL,
  selection = NULL,
  dataPointSelection = NULL,
  dataPointMouseEnter = NULL,
  dataPointMouseLeave = NULL,
  beforeZoom = NULL,
  zoomed = NULL,
  scrolled = NULL,
  ...
)
```

## Arguments

- click:

  Fires when user clicks on any area of the chart.

- beforeMount:

  Fires before the chart has been drawn on screen.

- mounted:

  Fires after the chart has been drawn on screen.

- updated:

  Fires when the chart has been dynamically updated.

- legendClick:

  Fires when user clicks on legend.

- selection:

  Fires when user selects rect using the selection tool.

- dataPointSelection:

  Fires when user clicks on a datapoint
  (bar/column/marker/bubble/donut-slice).

- dataPointMouseEnter:

  Fires when user's mouse enter on a datapoint
  (bar/column/marker/bubble/donut-slice).

- dataPointMouseLeave:

  MouseLeave event for a datapoint
  (bar/column/marker/bubble/donut-slice).

- beforeZoom:

  This function, if defined, runs just before zooming in/out of the
  chart allowing you to set a custom range for zooming in/out.

- zoomed:

  Fires when user zooms in/out the chart using either the selection
  zooming tool or zoom in/out buttons.

- scrolled:

  Fires when user scrolls using the pan tool.

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_chart`](https://dreamrs.github.io/apexcharter/reference/ax_chart.md).

## Note

All arguments should be JavaScript function defined with
[`htmlwidgets::JS`](https://rdrr.io/pkg/htmlwidgets/man/JS.html).

See <https://apexcharts.com/docs/options/chart/events/>.

## Examples

``` r
if (interactive()) {
  library(shiny)
  
  ui <- fluidPage(
    fluidRow(
      column(
        width = 8, offset = 2,
        tags$h2("Apexchart in Shiny"),
        apexchartOutput("chart"),
        verbatimTextOutput(outputId = "res_click")
      )
    )
  )
  
  server <- function(input, output, session) {
    
    output$chart <- renderApexchart({
      apexchart() %>%
        ax_chart(
          type = "bar",
          events = events_opts(
            dataPointSelection = JS(
              "function(event, chartContext, config) {
               Shiny.setInputValue('click', config.selectedDataPoints)
              }"
            ) 
          )
        ) %>%
        ax_series(
          list(
            name = "Example",
            data = sample(1:100, 5)
          )
        ) %>%
        ax_xaxis(
          categories = LETTERS[1:5]
        )
    })
    
    output$res_click <- renderPrint({
      input$click
    })
  }
  
  shinyApp(ui, server)
}
```
