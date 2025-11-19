# Configuration for auto update

Configuration for auto update

## Usage

``` r
config_update(
  series_animate = TRUE,
  update_options = FALSE,
  options_animate = TRUE,
  options_redrawPaths = TRUE,
  update_synced_charts = FALSE
)
```

## Arguments

- series_animate:

  Should the chart animate on re-rendering.

- update_options:

  Update or not global options for chart.

- options_animate:

  Should the chart animate on re-rendering.

- options_redrawPaths:

  When the chart is re-rendered, should it draw from the existing paths
  or completely redraw the chart paths from the beginning. By default,
  the chart is re-rendered from the existing paths.

- update_synced_charts:

  All the charts in a group should also update when one chart in a group
  is updated.
