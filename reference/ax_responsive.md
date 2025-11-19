# Responsive options

Responsive options

## Usage

``` r
ax_responsive(ax, ...)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/responsive/>

## Examples

``` r
data("mpg", package = "ggplot2")

# Open in browser and resize window
apex(
  data = mpg,
  mapping = aes(x = manufacturer, fill = year),
  type = "bar"
) %>% 
  ax_legend(position = "right") %>% 
  ax_responsive(
    list(
      breakpoint = 1000,
      options = list(
        plotOptions = list(
          bar = list(
            horizontal = FALSE
          )
        ),
        legend = list(
          position = "bottom"
        )
      )
    )
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"1999","data":[{"x":"audi","y":9},{"x":"chevrolet","y":7},{"x":"dodge","y":16},{"x":"ford","y":15},{"x":"honda","y":5},{"x":"hyundai","y":6},{"x":"jeep","y":2},{"x":"land rover","y":2},{"x":"lincoln","y":2},{"x":"mercury","y":2},{"x":"nissan","y":6},{"x":"pontiac","y":3},{"x":"subaru","y":6},{"x":"toyota","y":20},{"x":"volkswagen","y":16}]},{"name":"2008","data":[{"x":"audi","y":9},{"x":"chevrolet","y":12},{"x":"dodge","y":21},{"x":"ford","y":10},{"x":"honda","y":4},{"x":"hyundai","y":8},{"x":"jeep","y":6},{"x":"land rover","y":2},{"x":"lincoln","y":1},{"x":"mercury","y":2},{"x":"nissan","y":7},{"x":"pontiac","y":2},{"x":"subaru","y":8},{"x":"toyota","y":14},{"x":"volkswagen","y":11}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":true,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":false}},"xaxis":{"lines":{"show":true}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"legend":{"position":"right"},"responsive":[{"breakpoint":1000,"options":{"plotOptions":{"bar":{"horizontal":false}},"legend":{"position":"bottom"}}}]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"bar"},"evals":[],"jsHooks":[]}
```
