# Retrieve zoom information in Shiny

Retrieve zoom information in Shiny

## Usage

``` r
set_input_zoom(ax, inputId, session = shiny::getDefaultReactiveDomain())
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- inputId:

  The id that will be used server-side for retrieving zoom.

- session:

  The Shiny session.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

If x-axis is of type datetime, value retrieved is of class `POSIXct`.

## Examples

``` r
if (interactive()) {

  run_demo_input("zoom")

}
```
