# Radial bar options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
radialBar_opts(
  size = NULL,
  inverseOrder = NULL,
  startAngle = NULL,
  endAngle = NULL,
  offsetX = NULL,
  offsetY = NULL,
  hollow = NULL,
  track = NULL,
  dataLabels = NULL,
  ...
)
```

## Arguments

- size:

  Numeric. Manual size of the radialBars instead of calculating
  automatically from default height / width.

- inverseOrder:

  Logical. Whether to make the first value of series innermost or
  outermost.

- startAngle:

  Numeric. Angle from which the radialBars should start.

- endAngle:

  Numeric. Angle to which the radialBars should end. The sum of the
  startAngle and endAngle should not exceed 360.

- offsetX:

  Numeric. Sets the left offset for radialBars.

- offsetY:

  Numeric. Sets the top offset for radialBars.

- hollow:

  List.

- track:

  List.

- dataLabels:

  List.

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/radialbar/>.

## Examples

``` r
apexchart() %>% 
  ax_chart(type = "radialBar") %>% 
  ax_plotOptions(
    radialBar = radialBar_opts(
      startAngle = -135,
      endAngle = 135,
      dataLabels = list(
        name = list(
          fontSize = "16px",
          # color = undefined,
          offsetY = 120
        ),
        value = list(
          offsetY = 76,
          fontSize = "22px",
          # color = undefined,
          formatter = htmlwidgets::JS("function (val) {return val + '%';}")
        )
      )
    )
  ) %>% 
  ax_stroke(dashArray = 4) %>% 
  ax_series(70) %>% 
  ax_labels("Indicator")

{"x":{"ax_opts":{"chart":{"type":"radialBar"},"plotOptions":{"radialBar":{"startAngle":-135,"endAngle":135,"dataLabels":{"name":{"fontSize":"16px","offsetY":120},"value":{"offsetY":76,"fontSize":"22px","formatter":"function (val) {return val + '%';}"}}}},"stroke":{"dashArray":4},"series":[70],"labels":["Indicator"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":["ax_opts.plotOptions.radialBar.dataLabels.value.formatter"],"jsHooks":[]}
```
