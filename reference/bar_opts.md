# Bar options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
bar_opts(
  horizontal = NULL,
  endingShape = NULL,
  columnWidth = NULL,
  barHeight = NULL,
  distributed = NULL,
  colors = NULL,
  dataLabels = NULL,
  ...
)
```

## Arguments

- horizontal:

  Logical. This option will turn a column chart into a horizontal bar
  chart.

- endingShape:

  Available Options: `"flat"` or `"rounded"`.

- columnWidth:

  In column charts, columnWidth is the percentage of the available width
  in the grid-rect.

- barHeight:

  In horizontal bar charts, barHeight is the percentage of the available
  height in the grid-rect.

- distributed:

  Logical. Turn this option to make the bars discrete. Each value
  indicates one bar per series.

- colors:

  A list of parameters.

- dataLabels:

  List with fields `position` (available options: `"top"`, `"center"` or
  `"bottom"`)

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/bar/>.

## Examples

``` r
data("mpg", package = "ggplot2")

apex(mpg, aes(manufacturer)) %>% 
  ax_plotOptions(
    bar = bar_opts(
      endingShape = "rounded",
      columnWidth = 100,
      distributed = TRUE
    )
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false,"endingShape":"rounded","columnWidth":100,"distributed":true}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}  
```
