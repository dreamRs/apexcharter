# Bubble options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
bubble_opts(minBubbleRadius, maxBubbleRadius, ...)
```

## Arguments

- minBubbleRadius:

  Minimum radius size of a bubble. If a bubble value is too small to be
  displayed, this size will be used.

- maxBubbleRadius:

  Maximum radius size of a bubble. If a bubble value is too large to
  cover the chart, this size will be used.

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/bubble/>.

## Examples

``` r
apex(
  data = mtcars, 
  type = "scatter", 
  mapping = aes(x = wt, y = mpg, z = qsec)
) %>% 
  ax_plotOptions(
    bubble = bubble_opts(
      minBubbleRadius = 1,
      maxBubbleRadius = 20
    )
  )

{"x":{"ax_opts":{"chart":{"type":"bubble"},"series":[{"name":"mpg","type":"bubble","data":[{"x":2.62,"y":21,"z":16.46},{"x":2.875,"y":21,"z":17.02},{"x":2.32,"y":22.8,"z":18.61},{"x":3.215,"y":21.4,"z":19.44},{"x":3.44,"y":18.7,"z":17.02},{"x":3.46,"y":18.1,"z":20.22},{"x":3.57,"y":14.3,"z":15.84},{"x":3.19,"y":24.4,"z":20},{"x":3.15,"y":22.8,"z":22.9},{"x":3.44,"y":19.2,"z":18.3},{"x":3.44,"y":17.8,"z":18.9},{"x":4.07,"y":16.4,"z":17.4},{"x":3.73,"y":17.3,"z":17.6},{"x":3.78,"y":15.2,"z":18},{"x":5.25,"y":10.4,"z":17.98},{"x":5.424,"y":10.4,"z":17.82},{"x":5.345,"y":14.7,"z":17.42},{"x":2.2,"y":32.4,"z":19.47},{"x":1.615,"y":30.4,"z":18.52},{"x":1.835,"y":33.9,"z":19.9},{"x":2.465,"y":21.5,"z":20.01},{"x":3.52,"y":15.5,"z":16.87},{"x":3.435,"y":15.2,"z":17.3},{"x":3.84,"y":13.3,"z":15.41},{"x":3.845,"y":19.2,"z":17.05},{"x":1.935,"y":27.3,"z":18.9},{"x":2.14,"y":26,"z":16.7},{"x":1.513,"y":30.4,"z":16.9},{"x":3.17,"y":15.8,"z":14.5},{"x":2.77,"y":19.7,"z":15.5},{"x":3.57,"y":15,"z":14.6},{"x":2.78,"y":21.4,"z":18.6}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":1,"max":6,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":10,"max":35,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"plotOptions":{"bubble":{"minBubbleRadius":1,"maxBubbleRadius":20}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":1.513,"max":5.424},"type":"bubble"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
```
