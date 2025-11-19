# Add an annotation point

Add an annotation point

## Usage

``` r
add_point(
  ax,
  x,
  y,
  size = 5,
  color = "#000",
  fill = "#FFF",
  width = 2,
  shape = "circle",
  radius = 2,
  label = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- x:

  Coordinate(s) on the x-axis.

- y:

  Coordinate(s) on the y-axis.

- size:

  Size of the marker.

- color:

  Stroke Color of the marker point.

- fill:

  Fill Color of the marker point.

- width:

  Stroke Size of the marker point.

- shape:

  Shape of the marker: `"circle"` or `"square"`.

- radius:

  Radius of the marker (applies to square shape).

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

## See also

[`add_event_marker`](https://dreamrs.github.io/apexcharter/reference/add_event_marker.md)
to add a point when x-axis is a datetime.

## Examples

``` r
library(apexcharter)

# On scatter chart
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) %>% 
  add_point(
    x = mean(iris$Sepal.Length),
    y = mean(iris$Sepal.Width)
  )

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"Sepal.Width","type":"scatter","data":[{"x":5.1,"y":3.5},{"x":4.9,"y":3},{"x":4.7,"y":3.2},{"x":4.6,"y":3.1},{"x":5,"y":3.6},{"x":5.4,"y":3.9},{"x":4.6,"y":3.4},{"x":5,"y":3.4},{"x":4.4,"y":2.9},{"x":4.9,"y":3.1},{"x":5.4,"y":3.7},{"x":4.8,"y":3.4},{"x":4.8,"y":3},{"x":4.3,"y":3},{"x":5.8,"y":4},{"x":5.7,"y":4.4},{"x":5.4,"y":3.9},{"x":5.1,"y":3.5},{"x":5.7,"y":3.8},{"x":5.1,"y":3.8},{"x":5.4,"y":3.4},{"x":5.1,"y":3.7},{"x":4.6,"y":3.6},{"x":5.1,"y":3.3},{"x":4.8,"y":3.4},{"x":5,"y":3},{"x":5,"y":3.4},{"x":5.2,"y":3.5},{"x":5.2,"y":3.4},{"x":4.7,"y":3.2},{"x":4.8,"y":3.1},{"x":5.4,"y":3.4},{"x":5.2,"y":4.1},{"x":5.5,"y":4.2},{"x":4.9,"y":3.1},{"x":5,"y":3.2},{"x":5.5,"y":3.5},{"x":4.9,"y":3.6},{"x":4.4,"y":3},{"x":5.1,"y":3.4},{"x":5,"y":3.5},{"x":4.5,"y":2.3},{"x":4.4,"y":3.2},{"x":5,"y":3.5},{"x":5.1,"y":3.8},{"x":4.8,"y":3},{"x":5.1,"y":3.8},{"x":4.6,"y":3.2},{"x":5.3,"y":3.7},{"x":5,"y":3.3},{"x":7,"y":3.2},{"x":6.4,"y":3.2},{"x":6.9,"y":3.1},{"x":5.5,"y":2.3},{"x":6.5,"y":2.8},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":4.9,"y":2.4},{"x":6.6,"y":2.9},{"x":5.2,"y":2.7},{"x":5,"y":2},{"x":5.9,"y":3},{"x":6,"y":2.2},{"x":6.1,"y":2.9},{"x":5.6,"y":2.9},{"x":6.7,"y":3.1},{"x":5.6,"y":3},{"x":5.8,"y":2.7},{"x":6.2,"y":2.2},{"x":5.6,"y":2.5},{"x":5.9,"y":3.2},{"x":6.1,"y":2.8},{"x":6.3,"y":2.5},{"x":6.1,"y":2.8},{"x":6.4,"y":2.9},{"x":6.6,"y":3},{"x":6.8,"y":2.8},{"x":6.7,"y":3},{"x":6,"y":2.9},{"x":5.7,"y":2.6},{"x":5.5,"y":2.4},{"x":5.5,"y":2.4},{"x":5.8,"y":2.7},{"x":6,"y":2.7},{"x":5.4,"y":3},{"x":6,"y":3.4},{"x":6.7,"y":3.1},{"x":6.3,"y":2.3},{"x":5.6,"y":3},{"x":5.5,"y":2.5},{"x":5.5,"y":2.6},{"x":6.1,"y":3},{"x":5.8,"y":2.6},{"x":5,"y":2.3},{"x":5.6,"y":2.7},{"x":5.7,"y":3},{"x":5.7,"y":2.9},{"x":6.2,"y":2.9},{"x":5.1,"y":2.5},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":5.8,"y":2.7},{"x":7.1,"y":3},{"x":6.3,"y":2.9},{"x":6.5,"y":3},{"x":7.6,"y":3},{"x":4.9,"y":2.5},{"x":7.3,"y":2.9},{"x":6.7,"y":2.5},{"x":7.2,"y":3.6},{"x":6.5,"y":3.2},{"x":6.4,"y":2.7},{"x":6.8,"y":3},{"x":5.7,"y":2.5},{"x":5.8,"y":2.8},{"x":6.4,"y":3.2},{"x":6.5,"y":3},{"x":7.7,"y":3.8},{"x":7.7,"y":2.6},{"x":6,"y":2.2},{"x":6.9,"y":3.2},{"x":5.6,"y":2.8},{"x":7.7,"y":2.8},{"x":6.3,"y":2.7},{"x":6.7,"y":3.3},{"x":7.2,"y":3.2},{"x":6.2,"y":2.8},{"x":6.1,"y":3},{"x":6.4,"y":2.8},{"x":7.2,"y":3},{"x":7.4,"y":2.8},{"x":7.9,"y":3.8},{"x":6.4,"y":2.8},{"x":6.3,"y":2.8},{"x":6.1,"y":2.6},{"x":7.7,"y":3},{"x":6.3,"y":3.4},{"x":6.4,"y":3.1},{"x":6,"y":3},{"x":6.9,"y":3.1},{"x":6.7,"y":3.1},{"x":6.9,"y":3.1},{"x":5.8,"y":2.7},{"x":6.8,"y":3.2},{"x":6.7,"y":3.3},{"x":6.7,"y":3},{"x":6.3,"y":2.5},{"x":6.5,"y":3},{"x":6.2,"y":3.4},{"x":5.9,"y":3}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":4,"max":8,"tickAmount":4,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":2,"max":4.5,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"annotations":{"position":"front","points":[{"x":5.843333333333334,"y":3.057333333333333,"marker":{"size":5,"fillColor":"#FFF","strokeColor":"#000","strokeWidth":2,"shape":"circle","radius":2}}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":4.3,"max":7.9},"type":"scatter"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
# Some options
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) %>% 
  add_point(
    x = mean(iris$Sepal.Length),
    y = mean(iris$Sepal.Width), 
    fill = "firebrick",
    color = "firebrick",
    size = 8,
    label = label(text = "Mean", offsetY = 0)
  )

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"Sepal.Width","type":"scatter","data":[{"x":5.1,"y":3.5},{"x":4.9,"y":3},{"x":4.7,"y":3.2},{"x":4.6,"y":3.1},{"x":5,"y":3.6},{"x":5.4,"y":3.9},{"x":4.6,"y":3.4},{"x":5,"y":3.4},{"x":4.4,"y":2.9},{"x":4.9,"y":3.1},{"x":5.4,"y":3.7},{"x":4.8,"y":3.4},{"x":4.8,"y":3},{"x":4.3,"y":3},{"x":5.8,"y":4},{"x":5.7,"y":4.4},{"x":5.4,"y":3.9},{"x":5.1,"y":3.5},{"x":5.7,"y":3.8},{"x":5.1,"y":3.8},{"x":5.4,"y":3.4},{"x":5.1,"y":3.7},{"x":4.6,"y":3.6},{"x":5.1,"y":3.3},{"x":4.8,"y":3.4},{"x":5,"y":3},{"x":5,"y":3.4},{"x":5.2,"y":3.5},{"x":5.2,"y":3.4},{"x":4.7,"y":3.2},{"x":4.8,"y":3.1},{"x":5.4,"y":3.4},{"x":5.2,"y":4.1},{"x":5.5,"y":4.2},{"x":4.9,"y":3.1},{"x":5,"y":3.2},{"x":5.5,"y":3.5},{"x":4.9,"y":3.6},{"x":4.4,"y":3},{"x":5.1,"y":3.4},{"x":5,"y":3.5},{"x":4.5,"y":2.3},{"x":4.4,"y":3.2},{"x":5,"y":3.5},{"x":5.1,"y":3.8},{"x":4.8,"y":3},{"x":5.1,"y":3.8},{"x":4.6,"y":3.2},{"x":5.3,"y":3.7},{"x":5,"y":3.3},{"x":7,"y":3.2},{"x":6.4,"y":3.2},{"x":6.9,"y":3.1},{"x":5.5,"y":2.3},{"x":6.5,"y":2.8},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":4.9,"y":2.4},{"x":6.6,"y":2.9},{"x":5.2,"y":2.7},{"x":5,"y":2},{"x":5.9,"y":3},{"x":6,"y":2.2},{"x":6.1,"y":2.9},{"x":5.6,"y":2.9},{"x":6.7,"y":3.1},{"x":5.6,"y":3},{"x":5.8,"y":2.7},{"x":6.2,"y":2.2},{"x":5.6,"y":2.5},{"x":5.9,"y":3.2},{"x":6.1,"y":2.8},{"x":6.3,"y":2.5},{"x":6.1,"y":2.8},{"x":6.4,"y":2.9},{"x":6.6,"y":3},{"x":6.8,"y":2.8},{"x":6.7,"y":3},{"x":6,"y":2.9},{"x":5.7,"y":2.6},{"x":5.5,"y":2.4},{"x":5.5,"y":2.4},{"x":5.8,"y":2.7},{"x":6,"y":2.7},{"x":5.4,"y":3},{"x":6,"y":3.4},{"x":6.7,"y":3.1},{"x":6.3,"y":2.3},{"x":5.6,"y":3},{"x":5.5,"y":2.5},{"x":5.5,"y":2.6},{"x":6.1,"y":3},{"x":5.8,"y":2.6},{"x":5,"y":2.3},{"x":5.6,"y":2.7},{"x":5.7,"y":3},{"x":5.7,"y":2.9},{"x":6.2,"y":2.9},{"x":5.1,"y":2.5},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":5.8,"y":2.7},{"x":7.1,"y":3},{"x":6.3,"y":2.9},{"x":6.5,"y":3},{"x":7.6,"y":3},{"x":4.9,"y":2.5},{"x":7.3,"y":2.9},{"x":6.7,"y":2.5},{"x":7.2,"y":3.6},{"x":6.5,"y":3.2},{"x":6.4,"y":2.7},{"x":6.8,"y":3},{"x":5.7,"y":2.5},{"x":5.8,"y":2.8},{"x":6.4,"y":3.2},{"x":6.5,"y":3},{"x":7.7,"y":3.8},{"x":7.7,"y":2.6},{"x":6,"y":2.2},{"x":6.9,"y":3.2},{"x":5.6,"y":2.8},{"x":7.7,"y":2.8},{"x":6.3,"y":2.7},{"x":6.7,"y":3.3},{"x":7.2,"y":3.2},{"x":6.2,"y":2.8},{"x":6.1,"y":3},{"x":6.4,"y":2.8},{"x":7.2,"y":3},{"x":7.4,"y":2.8},{"x":7.9,"y":3.8},{"x":6.4,"y":2.8},{"x":6.3,"y":2.8},{"x":6.1,"y":2.6},{"x":7.7,"y":3},{"x":6.3,"y":3.4},{"x":6.4,"y":3.1},{"x":6,"y":3},{"x":6.9,"y":3.1},{"x":6.7,"y":3.1},{"x":6.9,"y":3.1},{"x":5.8,"y":2.7},{"x":6.8,"y":3.2},{"x":6.7,"y":3.3},{"x":6.7,"y":3},{"x":6.3,"y":2.5},{"x":6.5,"y":3},{"x":6.2,"y":3.4},{"x":5.9,"y":3}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":4,"max":8,"tickAmount":4,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":2,"max":4.5,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"annotations":{"position":"front","points":[{"x":5.843333333333334,"y":3.057333333333333,"marker":{"size":8,"fillColor":"firebrick","strokeColor":"firebrick","strokeWidth":2,"shape":"circle","radius":2},"label":{"text":"Mean","offsetY":0,"style":{"padding":{"top":2,"right":5,"bottom":2,"left":5}}}}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":4.3,"max":7.9},"type":"scatter"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}

# Several points
clusters <- kmeans(iris[, 1:2], 3)
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) %>% 
  add_point(
    x = clusters$centers[, 1],
    y = clusters$centers[, 2]
  )

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"Sepal.Width","type":"scatter","data":[{"x":5.1,"y":3.5},{"x":4.9,"y":3},{"x":4.7,"y":3.2},{"x":4.6,"y":3.1},{"x":5,"y":3.6},{"x":5.4,"y":3.9},{"x":4.6,"y":3.4},{"x":5,"y":3.4},{"x":4.4,"y":2.9},{"x":4.9,"y":3.1},{"x":5.4,"y":3.7},{"x":4.8,"y":3.4},{"x":4.8,"y":3},{"x":4.3,"y":3},{"x":5.8,"y":4},{"x":5.7,"y":4.4},{"x":5.4,"y":3.9},{"x":5.1,"y":3.5},{"x":5.7,"y":3.8},{"x":5.1,"y":3.8},{"x":5.4,"y":3.4},{"x":5.1,"y":3.7},{"x":4.6,"y":3.6},{"x":5.1,"y":3.3},{"x":4.8,"y":3.4},{"x":5,"y":3},{"x":5,"y":3.4},{"x":5.2,"y":3.5},{"x":5.2,"y":3.4},{"x":4.7,"y":3.2},{"x":4.8,"y":3.1},{"x":5.4,"y":3.4},{"x":5.2,"y":4.1},{"x":5.5,"y":4.2},{"x":4.9,"y":3.1},{"x":5,"y":3.2},{"x":5.5,"y":3.5},{"x":4.9,"y":3.6},{"x":4.4,"y":3},{"x":5.1,"y":3.4},{"x":5,"y":3.5},{"x":4.5,"y":2.3},{"x":4.4,"y":3.2},{"x":5,"y":3.5},{"x":5.1,"y":3.8},{"x":4.8,"y":3},{"x":5.1,"y":3.8},{"x":4.6,"y":3.2},{"x":5.3,"y":3.7},{"x":5,"y":3.3},{"x":7,"y":3.2},{"x":6.4,"y":3.2},{"x":6.9,"y":3.1},{"x":5.5,"y":2.3},{"x":6.5,"y":2.8},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":4.9,"y":2.4},{"x":6.6,"y":2.9},{"x":5.2,"y":2.7},{"x":5,"y":2},{"x":5.9,"y":3},{"x":6,"y":2.2},{"x":6.1,"y":2.9},{"x":5.6,"y":2.9},{"x":6.7,"y":3.1},{"x":5.6,"y":3},{"x":5.8,"y":2.7},{"x":6.2,"y":2.2},{"x":5.6,"y":2.5},{"x":5.9,"y":3.2},{"x":6.1,"y":2.8},{"x":6.3,"y":2.5},{"x":6.1,"y":2.8},{"x":6.4,"y":2.9},{"x":6.6,"y":3},{"x":6.8,"y":2.8},{"x":6.7,"y":3},{"x":6,"y":2.9},{"x":5.7,"y":2.6},{"x":5.5,"y":2.4},{"x":5.5,"y":2.4},{"x":5.8,"y":2.7},{"x":6,"y":2.7},{"x":5.4,"y":3},{"x":6,"y":3.4},{"x":6.7,"y":3.1},{"x":6.3,"y":2.3},{"x":5.6,"y":3},{"x":5.5,"y":2.5},{"x":5.5,"y":2.6},{"x":6.1,"y":3},{"x":5.8,"y":2.6},{"x":5,"y":2.3},{"x":5.6,"y":2.7},{"x":5.7,"y":3},{"x":5.7,"y":2.9},{"x":6.2,"y":2.9},{"x":5.1,"y":2.5},{"x":5.7,"y":2.8},{"x":6.3,"y":3.3},{"x":5.8,"y":2.7},{"x":7.1,"y":3},{"x":6.3,"y":2.9},{"x":6.5,"y":3},{"x":7.6,"y":3},{"x":4.9,"y":2.5},{"x":7.3,"y":2.9},{"x":6.7,"y":2.5},{"x":7.2,"y":3.6},{"x":6.5,"y":3.2},{"x":6.4,"y":2.7},{"x":6.8,"y":3},{"x":5.7,"y":2.5},{"x":5.8,"y":2.8},{"x":6.4,"y":3.2},{"x":6.5,"y":3},{"x":7.7,"y":3.8},{"x":7.7,"y":2.6},{"x":6,"y":2.2},{"x":6.9,"y":3.2},{"x":5.6,"y":2.8},{"x":7.7,"y":2.8},{"x":6.3,"y":2.7},{"x":6.7,"y":3.3},{"x":7.2,"y":3.2},{"x":6.2,"y":2.8},{"x":6.1,"y":3},{"x":6.4,"y":2.8},{"x":7.2,"y":3},{"x":7.4,"y":2.8},{"x":7.9,"y":3.8},{"x":6.4,"y":2.8},{"x":6.3,"y":2.8},{"x":6.1,"y":2.6},{"x":7.7,"y":3},{"x":6.3,"y":3.4},{"x":6.4,"y":3.1},{"x":6,"y":3},{"x":6.9,"y":3.1},{"x":6.7,"y":3.1},{"x":6.9,"y":3.1},{"x":5.8,"y":2.7},{"x":6.8,"y":3.2},{"x":6.7,"y":3.3},{"x":6.7,"y":3},{"x":6.3,"y":2.5},{"x":6.5,"y":3},{"x":6.2,"y":3.4},{"x":5.9,"y":3}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":4,"max":8,"tickAmount":4,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":2,"max":4.5,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"annotations":{"position":"front","points":[{"x":5.005999999999999,"y":3.428000000000001,"marker":{"size":5,"fillColor":"#FFF","strokeColor":"#000","strokeWidth":2,"shape":"circle","radius":2}},{"x":5.773584905660377,"y":2.692452830188679,"marker":{"size":5,"fillColor":"#FFF","strokeColor":"#000","strokeWidth":2,"shape":"circle","radius":2}},{"x":6.812765957446806,"y":3.074468085106382,"marker":{"size":5,"fillColor":"#FFF","strokeColor":"#000","strokeWidth":2,"shape":"circle","radius":2}}]}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":4.3,"max":7.9},"type":"scatter"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
```
