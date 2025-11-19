# Boxplot options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
boxplot_opts(color.upper, color.lower, ...)
```

## Arguments

- color.upper:

  Color for the upper quartile (Q3 to median) of the box plot.

- color.lower:

  Color for the lower quartile (median to Q1) of the box plot.

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/boxplot/>.

## Examples

``` r
data("mpg", package = "ggplot2")
apex(mpg, aes(class, hwy), "boxplot") %>% 
  ax_plotOptions(
    boxPlot = boxplot_opts(color.upper = "#848484", color.lower = "#848484" )
  )

{"x":{"ax_opts":{"chart":{"type":"boxPlot"},"series":[{"type":"boxPlot","data":[{"x":"2seater","y":[23,24,25,26,26]},{"x":"compact","y":[23,26,27,29,33]},{"x":"midsize","y":[23,26,27,29,32]},{"x":"minivan","y":[21,22,23,24,24]},{"x":"pickup","y":[15,16,17,18,20]},{"x":"subcompact","y":[20,24.5,26,30.5,36]},{"x":"suv","y":[14,17,17.5,19,22]}]}],"plotOptions":{"bar":{"horizontal":false},"boxPlot":{"colors":{"upper":"#848484","lower":"#848484"}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"2seater","max":"suv"},"type":"boxplot"},"evals":[],"jsHooks":[]}
```
