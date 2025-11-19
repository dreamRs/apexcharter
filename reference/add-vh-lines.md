# Add horizontal or vertical line

Add horizontal or vertical line

## Usage

``` r
add_hline(ax, value, color = "#000", dash = 0, label = NULL, ...)

add_vline(ax, value, color = "#000", dash = 0, label = NULL, ...)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- value:

  Vector of position for the line(s).

- color:

  Color(s) of the line(s).

- dash:

  Creates dashes in borders of SVG path. A higher number creates more
  space between dashes in the border. Use `0` for plain line.

- label:

  Add a label to the shade, use a `character` or see
  [`label`](https://dreamrs.github.io/apexcharter/reference/label.md)
  for more controls.

- ...:

  Additional arguments, see
  <https://apexcharts.com/docs/options/annotations/> for possible
  options.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
library(apexcharter)

# On a column chart
unhcr_ts %>%
  subset(year == 2017 & population_type == "Asylum-seekers") %>%
  apex(
    aes(continent_origin, n),
    "column"
  ) %>%
  add_hline(value = 5e5)

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"n","type":"bar","data":[{"x":"Africa","y":964124},{"x":"Asia","y":1353541},{"x":"Europe","y":130065},{"x":"North America","y":384104},{"x":"Oceania","y":1315},{"x":"South America","y":210425}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"annotations":{"position":"front","yaxis":[{"y":500000,"borderColor":"#000","strokeDashArray":0}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Africa","max":"South America"},"type":"column"},"evals":[],"jsHooks":[]}

# On a scatter chart
apex(
  data = cars,
  aes(speed, dist),
  "scatter"
) %>%
  add_hline(value = mean(cars$dist)) %>%
  add_vline(value = mean(cars$speed))

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"dist","type":"scatter","data":[{"x":4,"y":2},{"x":4,"y":10},{"x":7,"y":4},{"x":7,"y":22},{"x":8,"y":16},{"x":9,"y":10},{"x":10,"y":18},{"x":10,"y":26},{"x":10,"y":34},{"x":11,"y":17},{"x":11,"y":28},{"x":12,"y":14},{"x":12,"y":20},{"x":12,"y":24},{"x":12,"y":28},{"x":13,"y":26},{"x":13,"y":34},{"x":13,"y":34},{"x":13,"y":46},{"x":14,"y":26},{"x":14,"y":36},{"x":14,"y":60},{"x":14,"y":80},{"x":15,"y":20},{"x":15,"y":26},{"x":15,"y":54},{"x":16,"y":32},{"x":16,"y":40},{"x":17,"y":32},{"x":17,"y":40},{"x":17,"y":50},{"x":18,"y":42},{"x":18,"y":56},{"x":18,"y":76},{"x":18,"y":84},{"x":19,"y":36},{"x":19,"y":46},{"x":19,"y":68},{"x":20,"y":32},{"x":20,"y":48},{"x":20,"y":52},{"x":20,"y":56},{"x":20,"y":64},{"x":22,"y":66},{"x":23,"y":54},{"x":24,"y":70},{"x":24,"y":92},{"x":24,"y":93},{"x":24,"y":120},{"x":25,"y":85}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":0,"max":25,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":0,"max":120,"tickAmount":6,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"annotations":{"position":"front","yaxis":[{"y":42.98,"borderColor":"#000","strokeDashArray":0}],"xaxis":[{"x":15.4,"borderColor":"#000","strokeDashArray":0}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":4,"max":25},"type":"scatter"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
# With labels
apex(
  data = cars,
  aes(speed, dist),
  "scatter"
) %>%
  add_hline(
    value = mean(cars$dist),
    label = "Mean of dist"
  ) %>%
  add_vline(
    value = mean(cars$speed),
    label = label(
      text = "Mean of speed",
      borderColor = "red"
    )
  )

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"dist","type":"scatter","data":[{"x":4,"y":2},{"x":4,"y":10},{"x":7,"y":4},{"x":7,"y":22},{"x":8,"y":16},{"x":9,"y":10},{"x":10,"y":18},{"x":10,"y":26},{"x":10,"y":34},{"x":11,"y":17},{"x":11,"y":28},{"x":12,"y":14},{"x":12,"y":20},{"x":12,"y":24},{"x":12,"y":28},{"x":13,"y":26},{"x":13,"y":34},{"x":13,"y":34},{"x":13,"y":46},{"x":14,"y":26},{"x":14,"y":36},{"x":14,"y":60},{"x":14,"y":80},{"x":15,"y":20},{"x":15,"y":26},{"x":15,"y":54},{"x":16,"y":32},{"x":16,"y":40},{"x":17,"y":32},{"x":17,"y":40},{"x":17,"y":50},{"x":18,"y":42},{"x":18,"y":56},{"x":18,"y":76},{"x":18,"y":84},{"x":19,"y":36},{"x":19,"y":46},{"x":19,"y":68},{"x":20,"y":32},{"x":20,"y":48},{"x":20,"y":52},{"x":20,"y":56},{"x":20,"y":64},{"x":22,"y":66},{"x":23,"y":54},{"x":24,"y":70},{"x":24,"y":92},{"x":24,"y":93},{"x":24,"y":120},{"x":25,"y":85}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":0,"max":25,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":0,"max":120,"tickAmount":6,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"annotations":{"position":"front","yaxis":[{"y":42.98,"borderColor":"#000","strokeDashArray":0,"label":{"text":"Mean of dist"}}],"xaxis":[{"x":15.4,"borderColor":"#000","strokeDashArray":0,"label":{"borderColor":"red","text":"Mean of speed","style":{"padding":{"top":2,"right":5,"bottom":2,"left":5}}}}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":4,"max":25},"type":"scatter"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
```
