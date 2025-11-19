# Create an ApexCharts widget

Create an ApexCharts widget

## Usage

``` r
apexchart(
  ax_opts = list(),
  auto_update = TRUE,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- ax_opts:

  A `list` in JSON format with chart parameters.

- auto_update:

  In Shiny application, update existing chart rather than generating new
  one. Can be `TRUE`/`FALSE` or use
  [`config_update()`](https://dreamrs.github.io/apexcharter/reference/config_update.md)
  for more control.

- width, height:

  A numeric input in pixels.

- elementId:

  Use an explicit element ID for the widget.

## Value

An `apexchart()` `htmlwidget` object.

## See also

For quickly create a chart, see
[`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md).

## Examples

``` r
library(apexcharter)

# Use raw API by passing a list of
# parameters to the function

apexchart(ax_opts = list(
  chart = list(
    type = "bar"
  ),
  series = list(list(
    name = "Example",
    data = sample(1:100, 5)
  )),
  xaxis = list(
    categories = LETTERS[1:5]
  )
))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"Example","data":[85,44,61,34,70]}],"xaxis":{"categories":["A","B","C","D","E"]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}

# Or use apexchart() to initialize the chart
# before passing parameters

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

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"Example","data":[63,4,34,35,89]}],"xaxis":{"categories":["A","B","C","D","E"]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
```
