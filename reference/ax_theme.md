# Theme for charts

Theme for charts

## Usage

``` r
ax_theme(ax, mode = c("light", "dark"), palette = NULL, monochrome = NULL, ...)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- mode:

  use light or dark theme.

- palette:

  Character. Available palettes: `"palette1"` to `"palette10"`.

- monochrome:

  A list of parameters.

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/theme/>

## Examples

``` r
data("mpg", package = "ggplot2")
data("diamonds", package = "ggplot2")

# Dark mode
apex(
  data = mpg,
  mapping = aes(x = manufacturer)
) %>% 
  ax_theme(mode = "dark")

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"theme":{"mode":"dark"}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}
# Use predefined palette (1 to 10)
apex(
  data = diamonds,
  mapping = aes(x = color, fill = cut)
) %>% 
  ax_theme(palette = "palette2")

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"Fair","type":"bar","data":[{"x":"D","y":163},{"x":"E","y":224},{"x":"F","y":312},{"x":"G","y":314},{"x":"H","y":303},{"x":"I","y":175},{"x":"J","y":119}]},{"name":"Good","type":"bar","data":[{"x":"D","y":662},{"x":"E","y":933},{"x":"F","y":909},{"x":"G","y":871},{"x":"H","y":702},{"x":"I","y":522},{"x":"J","y":307}]},{"name":"Very Good","type":"bar","data":[{"x":"D","y":1513},{"x":"E","y":2400},{"x":"F","y":2164},{"x":"G","y":2299},{"x":"H","y":1824},{"x":"I","y":1204},{"x":"J","y":678}]},{"name":"Premium","type":"bar","data":[{"x":"D","y":1603},{"x":"E","y":2337},{"x":"F","y":2331},{"x":"G","y":2924},{"x":"H","y":2360},{"x":"I","y":1428},{"x":"J","y":808}]},{"name":"Ideal","type":"bar","data":[{"x":"D","y":2834},{"x":"E","y":3903},{"x":"F","y":3826},{"x":"G","y":4884},{"x":"H","y":3115},{"x":"I","y":2093},{"x":"J","y":896}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"theme":{"mode":"light","palette":"palette2"}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"D","max":"J"},"type":"column"},"evals":[],"jsHooks":[]}
# monochrome palette
apex(
  data = diamonds,
  mapping = aes(x = color, fill = cut)
) %>% 
  ax_theme(monochrome = list(enabled = TRUE, color = "#0B6121"))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"Fair","type":"bar","data":[{"x":"D","y":163},{"x":"E","y":224},{"x":"F","y":312},{"x":"G","y":314},{"x":"H","y":303},{"x":"I","y":175},{"x":"J","y":119}]},{"name":"Good","type":"bar","data":[{"x":"D","y":662},{"x":"E","y":933},{"x":"F","y":909},{"x":"G","y":871},{"x":"H","y":702},{"x":"I","y":522},{"x":"J","y":307}]},{"name":"Very Good","type":"bar","data":[{"x":"D","y":1513},{"x":"E","y":2400},{"x":"F","y":2164},{"x":"G","y":2299},{"x":"H","y":1824},{"x":"I","y":1204},{"x":"J","y":678}]},{"name":"Premium","type":"bar","data":[{"x":"D","y":1603},{"x":"E","y":2337},{"x":"F","y":2331},{"x":"G","y":2924},{"x":"H","y":2360},{"x":"I","y":1428},{"x":"J","y":808}]},{"name":"Ideal","type":"bar","data":[{"x":"D","y":2834},{"x":"E","y":3903},{"x":"F","y":3826},{"x":"G","y":4884},{"x":"H","y":3115},{"x":"I","y":2093},{"x":"J","y":896}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"theme":{"mode":"light","monochrome":{"enabled":true,"color":"#0B6121"}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"D","max":"J"},"type":"column"},"evals":[],"jsHooks":[]}
```
