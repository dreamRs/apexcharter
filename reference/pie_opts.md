# Pie options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
pie_opts(
  size = NULL,
  donut = NULL,
  customScale = NULL,
  offsetX = NULL,
  offsetY = NULL,
  dataLabels = NULL,
  ...
)
```

## Arguments

- size:

  Numeric. Custom size of the pie which will override the default size
  calculations.

- donut:

  List with two fields `size` (Donut / ring size in percentage relative
  to the total pie area.) and `background` (The background color of the
  pie).

- customScale:

  Numeric. Transform the scale of whole pie/donut overriding the default
  calculations.

- offsetX:

  Numeric. Sets the left offset of the whole pie area.

- offsetY:

  Numeric. Sets the top offset of the whole pie area.

- dataLabels:

  List with field `offset` (Numeric, Offset by which labels will move
  outside / inside of the donut area)

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/pie/>.

## Examples

``` r
data("mpg", package = "ggplot2")

apex(mpg, aes(cyl), type = "donut") %>%
  ax_plotOptions(
    pie = pie_opts(
      donut = list(size = "90%", background = "#BABABA")
    )
  )

{"x":{"ax_opts":{"chart":{"type":"donut"},"series":[81,4,79,70],"labels":["4","5","6","8"],"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"plotOptions":{"pie":{"donut":{"size":"90%","background":"#BABABA"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"4","max":"8"},"type":"donut"},"evals":[],"jsHooks":[]}
```
