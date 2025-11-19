# Alternative axis labels

Alternative axis labels

## Usage

``` r
ax_labels(ax, ...)

ax_labels2(ax, labels)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- ...:

  Vector. In Axis Charts (line / column), labels can be set instead of
  setting xaxis categories option. While, in pie/donut charts, each
  label corresponds to value in series array.

- labels:

  A vector to use as labels.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/labels/>

## Examples

``` r
apexchart() %>% 
  ax_chart(type = "pie") %>% 
  ax_series(23, 45, 56) %>% 
  ax_labels("A", "B", "C")

{"x":{"ax_opts":{"chart":{"type":"pie"},"series":[23,45,56],"labels":["A","B","C"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
# same as 
apexchart() %>% 
  ax_chart(type = "pie") %>% 
  ax_series2(c(23, 45, 56)) %>% 
  ax_labels2(c("A", "B", "C"))

{"x":{"ax_opts":{"chart":{"type":"pie"},"series":[23,45,56],"labels":["A","B","C"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
```
