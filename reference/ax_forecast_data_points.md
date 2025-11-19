# Forecast data points

Forecast data points

## Usage

``` r
ax_forecast_data_points(
  ax,
  count = NULL,
  fillOpacity = NULL,
  strokeWidth = NULL,
  dashArray = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- count:

  Number of ending data-points you want to indicate as a forecast or
  prediction values. The ending line/bar will result into a dashed
  border with a distinct look to differentiate from the rest of the
  data-points.

- fillOpacity:

  Opacity of the fill attribute.

- strokeWidth:

  Sets the width of the points.

- dashArray:

  Creates dashes in borders of svg path. Higher number creates more
  space between dashes in the border.

- ...:

  Additional arguments (not used).

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
# add 5 predictions to data then plot it
data.frame(
  time = seq_len(53),
  lh = c(
    as.vector(lh),
    as.vector(predict(arima(lh, order = c(1,0,1)), 5)$pred)
  )
) %>% 
  apex(aes(time, lh), type = "line") %>% 
  ax_xaxis(type = "numeric") %>% 
  ax_forecast_data_points(count = 5)

{"x":{"ax_opts":{"chart":{"type":"line"},"series":[{"name":"lh","type":"line","data":[{"x":1,"y":2.4},{"x":2,"y":2.4},{"x":3,"y":2.4},{"x":4,"y":2.2},{"x":5,"y":2.1},{"x":6,"y":1.5},{"x":7,"y":2.3},{"x":8,"y":2.3},{"x":9,"y":2.5},{"x":10,"y":2},{"x":11,"y":1.9},{"x":12,"y":1.7},{"x":13,"y":2.2},{"x":14,"y":1.8},{"x":15,"y":3.2},{"x":16,"y":3.2},{"x":17,"y":2.7},{"x":18,"y":2.2},{"x":19,"y":2.2},{"x":20,"y":1.9},{"x":21,"y":1.9},{"x":22,"y":1.8},{"x":23,"y":2.7},{"x":24,"y":3},{"x":25,"y":2.3},{"x":26,"y":2},{"x":27,"y":2},{"x":28,"y":2.9},{"x":29,"y":2.9},{"x":30,"y":2.7},{"x":31,"y":2.7},{"x":32,"y":2.3},{"x":33,"y":2.6},{"x":34,"y":2.4},{"x":35,"y":1.8},{"x":36,"y":1.7},{"x":37,"y":1.5},{"x":38,"y":1.4},{"x":39,"y":2.1},{"x":40,"y":3.3},{"x":41,"y":3.5},{"x":42,"y":3.5},{"x":43,"y":3.1},{"x":44,"y":2.6},{"x":45,"y":2.1},{"x":46,"y":3.4},{"x":47,"y":3},{"x":48,"y":2.9},{"x":49,"y":2.679610920066185},{"x":50,"y":2.531951257704051},{"x":51,"y":2.465179259819658},{"x":52,"y":2.434984827364984},{"x":53,"y":2.421330843956574}]}],"dataLabels":{"enabled":false},"stroke":{"curve":"straight","width":2},"yaxis":{"decimalsInFloat":2,"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}},"type":"numeric"},"forecastDataPoints":{"count":5}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":1,"max":53},"type":"line"},"evals":[],"jsHooks":[]}
```
