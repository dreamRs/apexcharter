# Charts' states

Charts' states

## Usage

``` r
ax_states(ax, normal = NULL, hover = NULL, active = NULL, ...)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- normal:

  A list of parameters.

- hover:

  A list of parameters.

- active:

  A list of parameters.

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/states/>

## Examples

``` r
data("mpg", package = "ggplot2")

# Inverse effect on hover
apex(
  data = mpg,
  mapping = aes(x = manufacturer),
  type = "bar"
) %>% 
  ax_states(
    hover = list(
      filter = list(
        type = "darken"
      )
    )
  )

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":true,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":false}},"xaxis":{"lines":{"show":true}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"states":{"hover":{"filter":{"type":"darken"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"bar"},"evals":[],"jsHooks":[]}
```
