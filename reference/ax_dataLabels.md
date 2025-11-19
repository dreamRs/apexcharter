# Labels on data

Labels on data

## Usage

``` r
ax_dataLabels(
  ax,
  enabled = NULL,
  textAnchor = NULL,
  offsetX = NULL,
  offsetY = NULL,
  style = NULL,
  dropShadow = NULL,
  formatter = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- enabled:

  To determine whether to show dataLabels or not.

- textAnchor:

  The alignment of text relative to dataLabel's drawing position.
  Accepted values `"start"`, `"middle"` or `"end"`.

- offsetX:

  Sets the left offset for dataLabels.

- offsetY:

  Sets the top offset for dataLabels.

- style:

  A list of parameters.

- dropShadow:

  A list of parameters.

- formatter:

  The formatter function takes in a single value and allows you to
  format the value before displaying

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/datalabels/>

## Examples

``` r
data("diamonds", package = "ggplot2")

# Add data labels
apex(
  data = diamonds,
  mapping = aes(x = cut)
) %>%
  ax_dataLabels(enabled = TRUE)

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"Fair","y":1610},{"x":"Good","y":4906},{"x":"Very Good","y":12082},{"x":"Premium","y":13791},{"x":"Ideal","y":21551}]}],"dataLabels":{"enabled":true},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Fair","max":"Very Good"},"type":"column"},"evals":[],"jsHooks":[]}
```
