# Create a box with a sparkline

Create a box with a sparkline

## Usage

``` r
spark_box(
  data,
  title = NULL,
  subtitle = NULL,
  color = "#2E93fA",
  background = "#FFF",
  type = c("area", "line", "spline", "column"),
  synchronize = NULL,
  title_style = NULL,
  subtitle_style = NULL,
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- data:

  A `data.frame`-like object with at least two columns, first is mapped
  to x-axis, second to y-axis.

- title:

  Title to display in the box.

- subtitle:

  Subtitle to display in the box.

- color:

  Color of the chart.

- background:

  Background color of the box.

- type:

  Type of chart, currently type supported are : `"area"` (default),
  `"line"`, `"spline"`, `"column"`.

- synchronize:

  Give a common id to charts to synchronize them (tooltip and zoom).

- title_style, subtitle_style:

  A `list` of named attributes to style the title / subtitle, possible
  values are `fontSize`, `fontWeight`, `fontFamily`, `color`.

- width, height:

  A numeric input in pixels.

- elementId:

  Use an explicit element ID for the widget.

## Value

An `apexcharts` `htmlwidget` object.

## Note

In Shiny use `sparkBoxOutput` / `renderSparkBox` to render boxes, see
example. Boxes have CSS class `"apexcharter-spark-box"` if you need more
styling.

## Examples

``` r
library(apexcharter)

spark_data <- data.frame(
  date = Sys.Date() + 1:20,
  var1 = round(rnorm(20, 50, 10)),
  var2 = round(rnorm(20, 50, 10)),
  var3 = round(rnorm(20, 50, 10))
)

spark_box(
  data = spark_data,
  title = mean(spark_data$var1), 
  subtitle = "Variable 1"
)

{"x":{"ax_opts":{"chart":{"type":"area","sparkline":{"enabled":true}},"series":[{"name":"var1","type":"area","data":[[1786060800000,44],[1786147200000,51],[1786233600000,54],[1786320000000,44],[1786406400000,60],[1786492800000,47],[1786579200000,64],[1786665600000,41],[1786752000000,28],[1786838400000,47],[1786924800000,54],[1787011200000,60],[1787097600000,53],[1787184000000,62],[1787270400000,47],[1787356800000,43],[1787443200000,35],[1787529600000,75],[1787616000000,56],[1787702400000,39]]}],"dataLabels":{"enabled":false},"stroke":{"curve":"straight","width":2},"yaxis":{"decimalsInFloat":2,"labels":{"style":{"colors":"#848484"}},"show":false},"xaxis":{"type":"datetime","labels":{"style":{"colors":"#848484"}}},"colors":["#2E93fA"],"title":{"text":50.2,"style":{"fontSize":"24px"}},"subtitle":{"text":"Variable 1","style":{"fontSize":"14px"}}},"auto_update":{"series_animate":true,"update_options":true,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":{"color":"#2E93fA","background":"#FFF"},"xaxis":{"min":"2026-08-07","max":"2026-08-26"},"type":"area"},"evals":[],"jsHooks":[]}

# In Shiny
if (interactive()) {
  run_sparkbox_demo()
}
```
