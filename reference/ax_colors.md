# Colors

Colors

## Usage

``` r
ax_colors(ax, ...)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- ...:

  Colors for the chart's series. When all colors are used, it starts
  from the beginning.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/colors/>

## Examples

``` r
data("diamonds", package = "ggplot2")

# Change default color(s)
apex(
  data = diamonds,
  mapping = aes(x = cut)
) %>%
  ax_colors("#F7D358")

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"Fair","y":1610},{"x":"Good","y":4906},{"x":"Very Good","y":12082},{"x":"Premium","y":13791},{"x":"Ideal","y":21551}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"colors":["#F7D358"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Fair","max":"Very Good"},"type":"column"},"evals":[],"jsHooks":[]}

library(scales)
apex(
  data = diamonds,
  mapping = aes(x = cut, fill = color)
) %>%
  ax_colors(brewer_pal(palette = "Set2")(7))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"D","type":"bar","data":[{"x":"Fair","y":163},{"x":"Good","y":662},{"x":"Very Good","y":1513},{"x":"Premium","y":1603},{"x":"Ideal","y":2834}]},{"name":"E","type":"bar","data":[{"x":"Fair","y":224},{"x":"Good","y":933},{"x":"Very Good","y":2400},{"x":"Premium","y":2337},{"x":"Ideal","y":3903}]},{"name":"F","type":"bar","data":[{"x":"Fair","y":312},{"x":"Good","y":909},{"x":"Very Good","y":2164},{"x":"Premium","y":2331},{"x":"Ideal","y":3826}]},{"name":"G","type":"bar","data":[{"x":"Fair","y":314},{"x":"Good","y":871},{"x":"Very Good","y":2299},{"x":"Premium","y":2924},{"x":"Ideal","y":4884}]},{"name":"H","type":"bar","data":[{"x":"Fair","y":303},{"x":"Good","y":702},{"x":"Very Good","y":1824},{"x":"Premium","y":2360},{"x":"Ideal","y":3115}]},{"name":"I","type":"bar","data":[{"x":"Fair","y":175},{"x":"Good","y":522},{"x":"Very Good","y":1204},{"x":"Premium","y":1428},{"x":"Ideal","y":2093}]},{"name":"J","type":"bar","data":[{"x":"Fair","y":119},{"x":"Good","y":307},{"x":"Very Good","y":678},{"x":"Premium","y":808},{"x":"Ideal","y":896}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"colors":["#66C2A5","#FC8D62","#8DA0CB","#E78AC3","#A6D854","#FFD92F","#E5C494"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Fair","max":"Very Good"},"type":"column"},"evals":[],"jsHooks":[]}
```
