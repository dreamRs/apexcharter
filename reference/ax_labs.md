# Modify axis, legend, and chart labels

Modify axis, legend, and chart labels

## Usage

``` r
ax_labs(ax, title = NULL, subtitle = NULL, x = NULL, y = NULL)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- title:

  Text for the title.

- subtitle:

  Text for the subtitle.

- x:

  Text for the x-axis label.

- y:

  Text for the y-axis label.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
meteo_paris <- data.frame(
  month = month.name,
  tmax = c(7, 8, 12, 15, 19, 23, 25, 25, 21, 16, 11, 8),
  tmin = c(3, 3, 5, 7, 11, 14, 16, 16, 13, 10, 6, 3)
)

apex(meteo_paris, type = "column", aes(x = month, y = tmin)) %>%
  ax_labs(
    title = "Average minimal temperature in Paris",
    subtitle = "Data from NOAA",
    x = "Month",
    y = "Temperature (\u00b0C)"
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"tmin","type":"bar","data":[{"x":"January","y":3},{"x":"February","y":3},{"x":"March","y":5},{"x":"April","y":7},{"x":"May","y":11},{"x":"June","y":14},{"x":"July","y":16},{"x":"August","y":16},{"x":"September","y":13},{"x":"October","y":10},{"x":"November","y":6},{"x":"December","y":3}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}},"title":{"text":"Temperature (°C)","style":{"fontWeight":400,"fontSize":"14px"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}},"title":{"text":"Month","style":{"fontWeight":400,"fontSize":"14px"}}},"title":{"text":"Average minimal temperature in Paris","style":{"fontWeight":700,"fontSize":"16px"}},"subtitle":{"text":"Data from NOAA","style":{"fontWeight":400,"fontSize":"14px"}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"April","max":"September"},"type":"column"},"evals":[],"jsHooks":[]}
```
