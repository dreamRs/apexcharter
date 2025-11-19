# Create grid of charts

``` r
library(apexcharter)
```

Create grid of charts with ApexCharts, currently it’s possible to:

- create grids according to one or more variables
- define number of columns and rows
- define type of scale for x-axis and y-axis (fixed or free)
- synchronize charts within the grid

Current limitations are :

- need specific render and output function in Shiny
  ([`apexfacetOutput()`](https://dreamrs.github.io/apexcharter/reference/apexcharter-shiny-facets.md)
  and
  [`renderApexfacet()`](https://dreamrs.github.io/apexcharter/reference/apexcharter-shiny-facets.md))
- x-axis always appear for scatter and line charts
- x-axis labels can differ between charts even with fixed scale
  depending on the width of the chart and the formatter applied to
  labels
- when scale on an axis is fixed, the chart with the axis don’t have the
  exact same size than the other since the axis take space in the
  plotting area
- if legend is needed, it will appear on each charts

## Facet wrap

Create a grid of charts according to a variable of the data with
[`ax_facet_wrap()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
:

``` r
library(apexcharter)
data("mpg", package = "ggplot2")

apex(mpg, aes(displ, cty), type = "scatter") %>%
  ax_xaxis(labels = list(formatter = format_num(".0f"))) %>% 
  ax_labs(
    title = "Facet wrap example",
    subtitle = "mpg data from ggplot2",
    x = "engine displacement, in litres",
    y = "city miles per gallon"
  ) %>% 
  ax_facet_wrap(vars(drv), ncol = 2)
```

Facet wrap example

mpg data from ggplot2

engine displacement, in litres

city miles per gallon

Synchronized line charts with free y-axis :

``` r
library(apexcharter)
data("economics_long", package = "ggplot2")

apex(economics_long, aes(date, value), type = "line", synchronize = "sync-it") %>% 
  ax_yaxis(
    decimalsInFloat = 0,
    labels = list(
      formatter = format_num("~s"),
      minWidth = 40
    )
  ) %>%
  ax_tooltip(x = list(format = "yyyy")) %>% 
  ax_facet_wrap(vars(variable), scales = "free_y")
```

Don’t forget to set a `minWidth` for y axis labels when synchronizing
charts, otherwise unexpected results can occurs.

## Facet grid

Create a matrix of charts defined by row and column faceting variables
with
[`ax_facet_grid()`](https://dreamrs.github.io/apexcharter/reference/apex-facets.md)
:

``` r
library(apexcharter)
data("mpg", package = "ggplot2")

apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_xaxis(labels = list(formatter = format_num(".0f"))) %>% 
  ax_labs(
    title = "Facet grid example",
    subtitle = "mpg data from ggplot2",
    x = "engine displacement, in litres",
    y = "city miles per gallon"
  ) %>% 
  ax_facet_grid(rows = vars(drv), cols = vars(year))
```

Facet grid example

mpg data from ggplot2

1999

2008

4

f

r

engine displacement, in litres

city miles per gallon

## Grid

You can construct a grid of (unrelated) charts with
[`apex_grid()`](https://dreamrs.github.io/apexcharter/reference/apex_grid.md),
construct your charts independently then assemble them in the grid:

``` r
library(apexcharter)
data("mpg", package = "ggplot2")

# Construct 3 charts
a1 <- apex(mpg, aes(manufacturer), type = "bar")
a2 <- apex(mpg, aes(trans), type = "column")
a3 <- apex(mpg, aes(drv), type = "pie")

# Assemble them in a grid
apex_grid(
  a1, a2, a3, 
  grid_area = c("1 / 1 / 3 / 2", "1 / 2 / 2 / 4", "2 / 2 / 3 / 4"),
  ncol = 3, 
  nrow = 2,
  height = "600px"
)
```

`grid_area` argument allow to specify space occupied by each chart, you
can generate interactively your grid template
[here](https://cssgrid-generator.netlify.app/).
