# Changelog

## apexcharter 0.4.5

- Updated ApexCharts.js to 5.3.6 (see
  <https://github.com/apexcharts/apexcharts.js/releases>).
- [`format_num()`](https://dreamrs.github.io/apexcharter/reference/format_num.md):
  added `na_label` argument to specify how to represent missing values.

## apexcharter 0.4.4

CRAN release: 2024-09-06

- Updated ApexCharts.js to 3.53.0 (see
  <https://github.com/apexcharts/apexcharts.js/releases>).
- `ax_facet_wrap`: fixed a bug generating CSS grid when using an xaxis
  title.

## apexcharter 0.4.3

CRAN release: 2024-05-15

- Updated ApexCharts.js to 3.49.1 (see
  <https://github.com/apexcharts/apexcharts.js/releases>).
- New chart type : slope charts.

## apexcharter 0.4.2

CRAN release: 2024-02-28

- Updated ApexCharts.js to 3.46.0 (see
  <https://github.com/apexcharts/apexcharts.js/releases>).

## apexcharter 0.4.1

CRAN release: 2023-06-14

- Updated ApexCharts.js to 3.41.0 (new charts type: dumbbell chart and
  funnel chart).
- [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md) :
  added support for boxplot.
- New function
  [`ax_forecast_data_points()`](https://dreamrs.github.io/apexcharter/reference/ax_forecast_data_points.md)
  to mark points as forecasted values.

## apexcharter 0.4.0

CRAN release: 2023-01-08

- Updated ApexCharts.js to 3.36.3.
- New chart type : range area charts.
- Facets: correctly manage secondary y axis.

## apexcharter 0.3.1

CRAN release: 2022-02-27

- Updated ApexCharts.js to 3.33.1
- Minimal {htmlwidgets} version required \>= 1.5.3

## apexcharter 0.3.0

CRAN release: 2021-10-21

- Updated ApexCharts.js to 3.29.0
- Internal: use [{packer}](https://github.com/JohnCoene/packer) to
  manage JavaScript assets.
- `d3.format` JavaScript functions are now available in browser under
  [`format()`](https://rdrr.io/r/base/format.html) and `formatLocale()`.

## apexcharter 0.2.0

CRAN release: 2021-05-11

- Updated ApexCharts.js to 3.26.2
- New functions
  [`ax_facet_wrap()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
  and
  [`ax_facet_grid()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
  to create faceting charts.
- New function
  [`apex_grid()`](https://dreamrs.github.io/apexcharter/reference/apex_grid.md)
  to combine several charts in a grid.

## apexcharter 0.1.8

CRAN release: 2020-11-18

- Updated ApexCharts.js to 3.22.2

### Bugfixes

- Fixed bad JavaScript namespace
- Fixed bug in groups with scatter chart

## apexcharter 0.1.7

CRAN release: 2020-10-16

- Updated ApexCharts.js to 3.22.0
- New chart type: treemap, see vignette for example.
- New function
  [`ax_colors_manual()`](https://dreamrs.github.io/apexcharter/reference/ax_colors_manual.md)
  to set color mapping manually.
- [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md)
  now accept `polarArea` as type of chart.

## apexcharter 0.1.6

CRAN release: 2020-09-09

- Updated ApexCharts.js to 3.20.1
- New functions
  [`add_line()`](https://dreamrs.github.io/apexcharter/reference/add-line.md)
  and
  [`add_smooth_line()`](https://dreamrs.github.io/apexcharter/reference/add-line.md)
  to add simple or trend line on charts (scatter & bars).
- New Shiny input: export, to retrieve chart’s base64 dataURI.

## apexcharter 0.1.5

CRAN release: 2020-06-23

- Updated ApexCharts.js to 3.18.1
- Support for candlestick charts in
  [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md).
- [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md)
  has a new argument `synchronize` to easily synchronize charts
  together.
- [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md)
  has new charts type: area-spline, area-step and step.

### New functions

- `spark_box` to create boxes with sparkline, see corresponding vignette
  for more details.
- [`add_shade()`](https://dreamrs.github.io/apexcharter/reference/add-shade.md),
  [`add_shade_weekend()`](https://dreamrs.github.io/apexcharter/reference/add-shade.md),
  [`add_event()`](https://dreamrs.github.io/apexcharter/reference/add_event.md)
  to add annotations on time-series charts.
- [`add_hline()`](https://dreamrs.github.io/apexcharter/reference/add-vh-lines.md),
  [`add_vline()`](https://dreamrs.github.io/apexcharter/reference/add-vh-lines.md),
  [`add_point()`](https://dreamrs.github.io/apexcharter/reference/add_point.md)
  to add annotations on charts.
- [`set_tooltip_fixed()`](https://dreamrs.github.io/apexcharter/reference/set_tooltip_fixed.md)
  to fix tooltip in specific position.

### Bugfixes

- Xaxis datetime now display properly with columns and bars.
- Dark mode wasn’t activated properly in
  [`ax_theme()`](https://dreamrs.github.io/apexcharter/reference/ax_theme.md).

## apexcharter 0.1.4

CRAN release: 2020-03-31

- Upgraded ApexCharts.js to 3.17.1
- Fixed a bug in grouped bar charts with different levels in groups.
- New vignette to explain how to sync charts.
- New vignette to show shiny usage.
- Added functions
  [`set_input_click()`](https://dreamrs.github.io/apexcharter/reference/set_input_click.md),
  [`set_input_zoom()`](https://dreamrs.github.io/apexcharter/reference/set_input_zoom.md)
  and
  [`set_input_selection()`](https://dreamrs.github.io/apexcharter/reference/set_input_selection.md)
  to add interaction in Shiny applications.

## apexcharter 0.1.3

CRAN release: 2019-11-27

- Upgraded ApexCharts.js to 3.10.1
- New function
  [`format_num()`](https://dreamrs.github.io/apexcharter/reference/format_num.md)
  to format labels on y-axis or tooltip for example.
- Added localization configs file, see
  [`?ax_chart`](https://dreamrs.github.io/apexcharter/reference/ax_chart.md)
  for examples.

## apexcharter 0.1.2

CRAN release: 2019-08-22

- Upgraded ApexCharts.js to 3.8.2
- Set parent container height to 0 by default (fix
  [\#2](https://github.com/dreamRs/apexcharter/issues/2)).

## apexcharter 0.1.1

CRAN release: 2019-07-28

- First CRAN release: create interactive chart with the JavaScript
  ‘ApexCharts’ library. Types of graphics available : bars, columns,
  splines, lines, scatter, pie, donuts, heatmap, gauge.
