# Retrieve click information in Shiny

According to type of chart, different values are retrieved:

- **bar and column:** retrieve category (x-axis).

- **pie and donut:** retrieve label.

- **time-series:** retrieve x-axis value, you have to display markers
  with size \> 0 and set tooltip's options `intersect = TRUE` and
  `shared = FALSE`.

- **scatter:** retrieve XY coordinates.

## Usage

``` r
set_input_click(
  ax,
  inputId,
  multiple = FALSE,
  effect_type = c("darken", "lighten", "none"),
  effect_value = 0.35,
  session = shiny::getDefaultReactiveDomain()
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- inputId:

  The id that will be used server-side for retrieving click.

- multiple:

  Allow multiple selection: `TRUE` or `FALSE` (default).

- effect_type:

  Type of effect for selected element, default is to use lightly darken
  color.

- effect_value:

  A larger value intensifies the select effect, accept value between 0
  and 1.

- session:

  The Shiny session.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

If x-axis is of type datetime, value retrieved is of class `POSIXct`.

## Examples

``` r
library(apexcharter)

# Not in Shiny but you can still click on bars
data.frame(
  month = month.abb,
  value = sample(1:100, 12)
) %>% 
  apex(aes(month, value)) %>% 
  set_input_click("month_click", multiple = TRUE)

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"value","type":"bar","data":[{"x":"Jan","y":90},{"x":"Feb","y":35},{"x":"Mar","y":95},{"x":"Apr","y":96},{"x":"May","y":33},{"x":"Jun","y":37},{"x":"Jul","y":89},{"x":"Aug","y":20},{"x":"Sep","y":19},{"x":"Oct","y":73},{"x":"Nov","y":65},{"x":"Dec","y":56}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"states":{"active":{"allowMultipleDataPointsSelection":true,"filter":{"type":"darken","value":0.35}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"Apr","max":"Sep"},"type":"column","shinyEvents":{"click":{"inputId":"month_click"}}},"evals":[],"jsHooks":[]}

# Interactive examples:
if (interactive()) {

  run_demo_input("click")

}
```
