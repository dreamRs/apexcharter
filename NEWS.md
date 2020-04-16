apexcharter 0.1.5
==================

* Updated ApexCharts.js to 3.18.1
* `apex()` has a new argument `synchronize` to easily synchronize charts together.


## New functions

* `add_shade()`, `add_shade_weekend()`, `add_event()` to add annotations on timeries charts.
* `add_hline()`, `add_vline()`, `add_point()` to add annotations on charts.
* `set_tooltip_fixed()` to fix tooltip in specific position.

## Bugfixes

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

