# Shiny bindings for faceting with apexcharter

Output and render functions for using apexcharter faceting within Shiny
applications and interactive Rmd documents.

## Usage

``` r
apexfacetOutput(outputId)

renderApexfacet(expr, env = parent.frame(), quoted = FALSE)
```

## Arguments

- outputId:

  output variable to read from

- expr:

  An expression that generates a apexcharter facet with
  [`ax_facet_wrap()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
  or
  [`ax_facet_grid()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md).

- env:

  The environment in which to evaluate `expr`.

- quoted:

  Is `expr` a quoted expression (with
  [`quote()`](https://rdrr.io/r/base/substitute.html))? This is useful
  if you want to save an expression in a variable.

## Value

An Apexcharts output that can be included in the application UI.

## See also

[`ax_facet_wrap()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md),
[`ax_facet_grid()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)

## Examples

``` r
library(shiny)
library(apexcharter)

data("unhcr_ts")
refugees <- unhcr_ts %>% 
  subset(
    population_type == "Refugees (incl. refugee-like situations)"
  ) %>% 
  transform(date = as.Date(paste0(year, "-01-01")))


ui <- fluidPage(
  
  tags$h2("Apexcharts Facets Example"),
  
  apexfacetOutput("myfacet")
  
)

server <- function(input, output, session) {
  
  output$myfacet <- renderApexfacet({
    apex(refugees, aes(date, n), type = "column") %>% 
      ax_yaxis(tickAmount = 5) %>% 
      ax_facet_wrap(
        vars(continent_origin), 
        scales = "free"
      )
  })
  
}

if (interactive())
  shinyApp(ui, server)
```
