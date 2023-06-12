apexcharter 0.4.1
==================

* Updated ApexCharts.js to 3.41.0 (new charts type: dumbbell chart and funnel chart).
* `apex()` : added support for boxplot.
* New function `ax_forecast_data_points()` to mark points as forecasted values.



apexcharter 0.4.0
==================

* Updated ApexCharts.js to 3.36.3.
* New chart type : range area charts.
* Facets: correctly manage secondary y axis.



apexcharter 0.3.1
==================

* Updated ApexCharts.js to 3.33.1
* Minimal {htmlwidgets} version required >= 1.5.3



apexcharter 0.3.0
==================

* Updated ApexCharts.js to 3.29.0
* Internal: use [{packer}](https://github.com/JohnCoene/packer) to manage JavaScript assets.
* `d3.format` JavaScript functions are now available in browser under `format()` and `formatLocale()`.



apexcharter 0.2.0
==================

* Updated ApexCharts.js to 3.26.2
* New functions `ax_facet_wrap()` and `ax_facet_grid()` to create faceting charts.
* New function `apex_grid()` to combine several charts in a grid.



apexcharter 0.1.8
==================

* Updated ApexCharts.js to 3.22.2

## Bugfixes

* Fixed bad JavaScript namespace
* Fixed bug in groups with scatter chart



apexcharter 0.1.7
==================

* Updated ApexCharts.js to 3.22.0
* New chart type: treemap, see vignette for example.
* New function `ax_colors_manual()` to set color mapping manually.
* `apex()` now accept `polarArea` as type of chart.



apexcharter 0.1.6
==================

* Updated ApexCharts.js to 3.20.1
* New functions `add_line()` and `add_smooth_line()` to add simple or trend line on charts (scatter & bars).
* New Shiny input: export, to retrieve chart's base64 dataURI.



apexcharter 0.1.5
==================

* Updated ApexCharts.js to 3.18.1
* Support for candlestick charts in `apex()`.
* `apex()` has a new argument `synchronize` to easily synchronize charts together.
* `apex()` has new charts type: area-spline, area-step and step.


## New functions

* `spark_box` to create boxes with sparkline, see corresponding vignette for more details.
* `add_shade()`, `add_shade_weekend()`, `add_event()` to add annotations on time-series charts.
* `add_hline()`, `add_vline()`, `add_point()` to add annotations on charts.
* `set_tooltip_fixed()` to fix tooltip in specific position.

## Bugfixes

* Xaxis datetime now display properly with columns and bars.
* Dark mode wasn't activated properly in `ax_theme()`.




apexcharter 0.1.4
==================

* Upgraded ApexCharts.js to 3.17.1
* Fixed a bug in grouped bar charts with different levels in groups.
* New vignette to explain how to sync charts.
* New vignette to show shiny usage.
* Added functions `set_input_click()`, `set_input_zoom()` and `set_input_selection()` to add interaction in Shiny applications.



apexcharter 0.1.3
==================

* Upgraded ApexCharts.js to 3.10.1
* New function `format_num()` to format labels on y-axis or tooltip for example.
* Added localization configs file, see `?ax_chart` for examples.



apexcharter 0.1.2
==================

* Upgraded ApexCharts.js to 3.8.2
* Set parent container height to 0 by default (fix [#2](https://github.com/dreamRs/apexcharter/issues/2)).



apexcharter 0.1.1
==================

* First CRAN release: create interactive chart with the JavaScript 'ApexCharts' library. Types of graphics available : bars, columns, splines, lines, scatter, pie, donuts, heatmap, gauge.

