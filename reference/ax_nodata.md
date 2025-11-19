# Configuration for charts with no data

Configuration for charts with no data

## Usage

``` r
ax_nodata(
  ax,
  text = "No data",
  align = "center",
  verticalAlign = "middle",
  color = NULL,
  fontSize = NULL,
  fontFamily = NULL,
  offsetX = NULL,
  offsetY = NULL
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- text:

  The text to display when no-data is available.

- align:

  Horizontal alignment: `"left"`, `"center"` or `"right"`.

- verticalAlign:

  Vertical alignment: `"top"`, `"middle"` or `"bottom"`.

- color:

  ForeColor of the text.

- fontSize:

  FontSize of the text.

- fontFamily:

  FontFamily of the text.

- offsetX, offsetY:

  Text offset.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
empty <- data.frame(
  var1 = character(0),
  var2 = numeric(0)
)
apex(empty, aes(var1, var2), "column") %>% 
  ax_nodata(
    text = "Sorry no data to visualize",
    fontSize = "30px"
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"var2","type":"bar","data":[]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"noData":{"text":"Sorry no data to visualize","align":"center","verticalAlign":"middle","style":{"fontSize":"30px"}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"type":"column"},"evals":[],"jsHooks":[]}
```
