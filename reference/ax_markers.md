# Markers properties

Markers properties

## Usage

``` r
ax_markers(
  ax,
  size = NULL,
  colors = NULL,
  strokeColor = NULL,
  strokeWidth = NULL,
  strokeOpacity = NULL,
  fillOpacity = NULL,
  shape = NULL,
  radius = NULL,
  offsetX = NULL,
  offsetY = NULL,
  hover = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- size:

  Numeric. Size of the marker point.

- colors:

  Sets the fill color(s) of the marker point.

- strokeColor:

  Stroke Color of the marker.

- strokeWidth:

  Stroke Size of the marker.

- strokeOpacity:

  Opacity of the border around marker.

- fillOpacity:

  Opacity of the marker fill color.

- shape:

  Shape of the marker. Available Options for shape: `"square"` or
  `"circle"`.

- radius:

  Numeric. Radius of the marker (applies to square shape)

- offsetX:

  Numeric. Sets the left offset of the marker.

- offsetY:

  Numeric. Sets the top offset of the marker.

- hover:

  List with item `size` (Size of the marker when it is active).

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/markers/>

## Examples

``` r
data("economics", package = "ggplot2")

# show points
apex(
  data = tail(economics, 20),
  type = "line", 
  mapping = aes(x = date, y = uempmed)
) %>% 
  ax_markers(size = 6) 

{"x":{"ax_opts":{"chart":{"type":"line"},"series":[{"name":"uempmed","type":"line","data":[[1377993600000,16.5],[1380585600000,16.3],[1383264000000,17.1],[1385856000000,17.3],[1388534400000,15.4],[1391212800000,15.9],[1393632000000,15.8],[1396310400000,15.7],[1398902400000,14.6],[1401580800000,13.8],[1404172800000,13.1],[1406851200000,12.9],[1409529600000,13.4],[1412121600000,13.6],[1414800000000,13],[1417392000000,12.9],[1420070400000,13.2],[1422748800000,12.9],[1425168000000,12],[1427846400000,11.5]]}],"dataLabels":{"enabled":false},"stroke":{"curve":"straight","width":2},"yaxis":{"decimalsInFloat":2,"labels":{"style":{"colors":"#848484"}}},"xaxis":{"type":"datetime","labels":{"style":{"colors":"#848484"}}},"markers":{"size":6}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"2013-09-01","max":"2015-04-01"},"type":"line"},"evals":[],"jsHooks":[]}
```
