# Proxy for `apexchart`

Allow to update a chart in Shiny application.

## Usage

``` r
apexchartProxy(shinyId, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- shinyId:

  single-element character vector indicating the output ID of the chart
  to modify (if invoked from a Shiny module, the namespace will be added
  automatically)

- session:

  the Shiny session object to which the chart belongs; usually the
  default value will suffice
