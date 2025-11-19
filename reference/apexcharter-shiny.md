# Shiny bindings for apexcharter

Output and render functions for using apexcharter within Shiny
applications and interactive Rmd documents.

## Usage

``` r
apexchartOutput(outputId, width = "100%", height = "400px")

renderApexchart(expr, env = parent.frame(), quoted = FALSE)

sparkBoxOutput(outputId, width = "100%", height = "160px")

renderSparkBox(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- outputId:

  Output variable to read from.

- width, height:

  Must be a valid CSS unit (like `100%`, `400px`, `auto`) or a number,
  which will be coerced to a string and have `px` appended.

- expr:

  An expression that generates a calendar

- env:

  The environment in which to evaluate `expr`.

- quoted:

  Is `expr` a quoted expression (with
  [`quote()`](https://rdrr.io/r/base/substitute.html))? This is useful
  if you want to save an expression in a variable.

## Value

Output element that can be included in UI. Render function to create
output in server.

## Note

To render a chart with facets (using
[`ax_facet_wrap()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
or
[`ax_facet_grid()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md))
in Shiny, see
[`apexfacetOutput()`](https://dreamrs.github.io/apexcharter/reference/apexcharter-shiny-facets.md)
(in UI) and
[`renderApexfacet()`](https://dreamrs.github.io/apexcharter/reference/apexcharter-shiny-facets.md)
(in Server).

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(apexcharter)
  
  ui <- fluidPage(
    fluidRow(
      column(
        width = 8, offset = 2,
        tags$h2("Apexchart in Shiny"),
        actionButton("redraw", "Redraw chart"),
        apexchartOutput("chart")
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
        )
    })
    
  }
  
  shinyApp(ui, server)
}
```
