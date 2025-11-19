# Legend properties

Legend properties

## Usage

``` r
ax_legend(
  ax,
  show = NULL,
  position = NULL,
  showForSingleSeries = NULL,
  showForNullSeries = NULL,
  showForZeroSeries = NULL,
  horizontalAlign = NULL,
  fontSize = NULL,
  textAnchor = NULL,
  offsetY = NULL,
  offsetX = NULL,
  formatter = NULL,
  labels = NULL,
  markers = NULL,
  itemMargin = NULL,
  containerMargin = NULL,
  onItemClick = NULL,
  onItemHover = NULL,
  floating = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- show:

  Logical. Whether to show or hide the legend container.

- position:

  Available position options for legend: `"top"`, `"right"`, `"bottom"`,
  `"left"`.

- showForSingleSeries:

  Show legend even if there is just 1 series.

- showForNullSeries:

  Allows you to hide a particular legend if it's series contains all
  null values.

- showForZeroSeries:

  Allows you to hide a particular legend if it's series contains all 0
  values.

- horizontalAlign:

  Available options for horizontal alignment: `"right"`, `"center"`,
  `"left"`.

- fontSize:

  Sets the fontSize of legend text elements

- textAnchor:

  The alignment of text relative to legend's drawing position

- offsetY:

  Sets the top offset for legend container.

- offsetX:

  Sets the left offset for legend container.

- formatter:

  JS function. A custom formatter function to append additional text to
  the legend series names.

- labels:

  List with two items `"foreColor"` (Custom text color for legend
  labels) and `"useSeriesColors"` (Logical, whether to use primary
  colors or not)

- markers:

  List.

- itemMargin:

  List with two items `"horizontal"` (Horizontal margin for individual
  legend item) and `"vertical"` (Vertical margin for individual legend
  item).

- containerMargin:

  List with two items `"top"` (Top margin for the whole legend
  container) and `"left"` (Left margin for the whole legend container).

- onItemClick:

  List with item `"toggleDataSeries"`, logical, when clicked on legend
  item, it will toggle the visibility of the series in chart.

- onItemHover:

  List with item `"highlightDataSeries"`, logical, when hovered on
  legend item, it will highlight the paths of the hovered series in
  chart.

- floating:

  Logical. The floating option will take out the legend from the chart
  area and make it float above the chart.

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/legend/>

## Examples

``` r
data("mpg", package = "ggplot2")

# Legend position
apex(
  data = mpg,
  mapping = aes(x = manufacturer, fill = year)
) %>% 
  ax_legend(position = "right")

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"1999","type":"bar","data":[{"x":"audi","y":9},{"x":"chevrolet","y":7},{"x":"dodge","y":16},{"x":"ford","y":15},{"x":"honda","y":5},{"x":"hyundai","y":6},{"x":"jeep","y":2},{"x":"land rover","y":2},{"x":"lincoln","y":2},{"x":"mercury","y":2},{"x":"nissan","y":6},{"x":"pontiac","y":3},{"x":"subaru","y":6},{"x":"toyota","y":20},{"x":"volkswagen","y":16}]},{"name":"2008","type":"bar","data":[{"x":"audi","y":9},{"x":"chevrolet","y":12},{"x":"dodge","y":21},{"x":"ford","y":10},{"x":"honda","y":4},{"x":"hyundai","y":8},{"x":"jeep","y":6},{"x":"land rover","y":2},{"x":"lincoln","y":1},{"x":"mercury","y":2},{"x":"nissan","y":7},{"x":"pontiac","y":2},{"x":"subaru","y":8},{"x":"toyota","y":14},{"x":"volkswagen","y":11}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"legend":{"position":"right"}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}
# hide legend
apex(
  data = mpg,
  mapping = aes(x = manufacturer, fill = year)
) %>% 
  ax_legend(show = FALSE)

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"1999","type":"bar","data":[{"x":"audi","y":9},{"x":"chevrolet","y":7},{"x":"dodge","y":16},{"x":"ford","y":15},{"x":"honda","y":5},{"x":"hyundai","y":6},{"x":"jeep","y":2},{"x":"land rover","y":2},{"x":"lincoln","y":2},{"x":"mercury","y":2},{"x":"nissan","y":6},{"x":"pontiac","y":3},{"x":"subaru","y":6},{"x":"toyota","y":20},{"x":"volkswagen","y":16}]},{"name":"2008","type":"bar","data":[{"x":"audi","y":9},{"x":"chevrolet","y":12},{"x":"dodge","y":21},{"x":"ford","y":10},{"x":"honda","y":4},{"x":"hyundai","y":8},{"x":"jeep","y":6},{"x":"land rover","y":2},{"x":"lincoln","y":1},{"x":"mercury","y":2},{"x":"nissan","y":7},{"x":"pontiac","y":2},{"x":"subaru","y":8},{"x":"toyota","y":14},{"x":"volkswagen","y":11}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"legend":{"show":false}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}
```
