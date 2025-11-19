# Specific options for chart

Specific options for chart

## Usage

``` r
ax_plotOptions(
  ax,
  bar = NULL,
  heatmap = NULL,
  radialBar = NULL,
  pie = NULL,
  bubble = NULL,
  boxPlot = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- bar:

  See
  [`bar_opts()`](https://dreamrs.github.io/apexcharter/reference/bar_opts.md).

- heatmap:

  See
  [`heatmap_opts()`](https://dreamrs.github.io/apexcharter/reference/heatmap_opts.md).

- radialBar:

  See
  [`radialBar_opts()`](https://dreamrs.github.io/apexcharter/reference/radialBar_opts.md).

- pie:

  See
  [`pie_opts()`](https://dreamrs.github.io/apexcharter/reference/pie_opts.md).

- bubble:

  See
  [`bubble_opts()`](https://dreamrs.github.io/apexcharter/reference/bubble_opts.md).

- boxPlot:

  See
  [`boxplot_opts()`](https://dreamrs.github.io/apexcharter/reference/boxplot_opts.md).

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
data("diamonds", package = "ggplot2")

# Stack bar type
apex(
  data = diamonds,
  mapping = aes(x = cut)
) %>%
  ax_plotOptions(
    bar = bar_opts(endingShape = "rounded", columnWidth = "10%")
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"Fair","y":1610},{"x":"Good","y":4906},{"x":"Very Good","y":12082},{"x":"Premium","y":13791},{"x":"Ideal","y":21551}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false,"endingShape":"rounded","columnWidth":"10%"}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Fair","max":"Very Good"},"type":"column"},"evals":[],"jsHooks":[]}
# Pie
apex(
  data = diamonds,
  mapping = aes(x = cut), 
  type = "pie"
) %>%
  ax_plotOptions(
    pie = pie_opts(customScale = 0.5)
  )

{"x":{"ax_opts":{"chart":{"type":"pie"},"series":[1610,4906,12082,13791,21551],"labels":["Fair","Good","Very Good","Premium","Ideal"],"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"plotOptions":{"pie":{"customScale":0.5}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Fair","max":"Very Good"},"type":"pie"},"evals":[],"jsHooks":[]}

# Radial
apexchart() %>% 
  ax_chart(type = "radialBar") %>% 
  ax_plotOptions(
    radialBar = radialBar_opts(
      hollow = list(size = "70%")
    )
  ) %>% 
  ax_series(70) %>% 
  ax_labels("Indicator")

{"x":{"ax_opts":{"chart":{"type":"radialBar"},"plotOptions":{"radialBar":{"hollow":{"size":"70%"}}},"series":[70],"labels":["Indicator"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
```
