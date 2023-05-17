
# ApexCharts API ----------------------------------------------------------


#' Annotations properties
#'
#' @template ax-default
#' @param position Whether to put the annotations behind the charts or in front of it. Available Options: \code{"front"} or \code{"back"}.
#' @param yaxis List of lists.
#' @param xaxis List of lists.
#' @param points List of lists.
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/annotations/}.
#'
#' @export
#' 
#' @examples 
#' data("economics", package = "ggplot2")
#' 
#' # Horizontal line
#' apex(
#'   data = tail(economics, 200),
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>% 
#'   ax_annotations(
#'     yaxis = list(list(
#'       y = 11.897,
#'       borderColor = "firebrick", 
#'       opacity = 1,
#'       label = list(
#'         text = "Mean uempmed",
#'         position = "left", 
#'         textAnchor = "start"
#'       )
#'     ))
#'   )
#' 
#' 
#' # Vertical line
#' apex(
#'   data = tail(economics, 200),
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>% 
#'   ax_annotations(
#'     xaxis = list(list(
#'       x = htmlwidgets::JS("new Date('1 Mar 2007').getTime()"),
#'       strokeDashArray = 0, 
#'       borderColor = "#775DD0",
#'       label = list(
#'         text = "A label",
#'         borderColor = "#775DD0", 
#'         style = list(
#'           color = "#fff",
#'           background = "#775DD0"
#'         )
#'       )
#'     ))
#'   )
#' 
#' 
#' # Vertical range
#' apex(
#'   data = tail(economics, 200),
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>% 
#'   ax_annotations(
#'     xaxis = list(list(
#'       x = htmlwidgets::JS("new Date('1 Jan 2009').getTime()"),
#'       x2 = htmlwidgets::JS("new Date('1 Feb 2010').getTime()"),
#'       fillColor = "#B3F7CA",
#'       opacity = 0.4,
#'       label = list(
#'         text = "A label",
#'         borderColor = "#B3F7CA", 
#'         style = list(
#'           color = "#fff",
#'           background = "#B3F7CA"
#'         )
#'       )
#'     ))
#'   )
#' 
#' 
#' # Point annotation
#' apex(
#'   data = tail(economics, 200),
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>% 
#'   ax_annotations(
#'     points = list(list(
#'       x = htmlwidgets::JS("new Date('1 Jun 2010').getTime()"),
#'       y = 25.2,
#'       marker = list(
#'         size = 8,
#'         fillColor = "#fff",
#'         strokeColor = "red",
#'         radius = 2
#'       ),
#'       label = list(
#'         text = "Highest",
#'         offsetY = 0,
#'         borderColor = "#FF4560", 
#'         style = list(
#'           color = "#fff",
#'           background = "#FF4560"
#'         )
#'       )
#'     ))
#'   )
ax_annotations <- function(ax,
                           position = NULL,
                           yaxis = NULL,
                           xaxis = NULL,
                           points = NULL,
                           ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "annotations", l = dropNulls(params))
}


#' Chart parameters
#'
#' @template ax-default
#' @param type Specify the chart type. Available Options: \code{"bar"}, \code{"column"}, \code{"line"},
#'  \code{"pie"}, \code{"donut"}, \code{"radialBar"}, \code{"scatter"}, \code{"bubble"}, \code{"heatmap"}.
#' @param stacked Logical. Enables stacked option for axis charts. 
#' @param stackType When stacked, should the stacking be percentage based or normal stacking.
#'  Available options: \code{"normal"} or \code{"100\%"}.
#' @param defaultLocale Locale to use : \code{"ca"}, \code{"cs"}, \code{"de"},
#'  \code{"el"}, \code{"en"}, \code{"es"}, \code{"fi"}, \code{"fr"}, \code{"he"}, 
#'  \code{"hi"}, \code{"hr"}, \code{"hy"}, \code{"id"}, \code{"it"}, \code{"ko"}, 
#'  \code{"lt"}, \code{"nb"}, \code{"nl"}, \code{"pl"}, \code{"pt-br"}, \code{"pt"}, 
#'  \code{"ru"}, \code{"se"}, \code{"sk"}, \code{"sl"}, \code{"th"}, \code{"tr"}, 
#'  \code{"ua"}.
#' @param locales Array of custom locales parameters.
#' @param animations A list of parameters.
#' @param background Background color for the chart area. If you want to set background with css, use \code{.apexcharts-canvas} to set it.
#' @param foreColor Sets the text color for the chart. Defaults to \code{#373d3f}.
#' @param dropShadow A list of parameters. See \url{https://apexcharts.com/docs/options/chart/dropshadow/}.
#' @param events See \code{\link{events_opts}}.
#' @param offsetX Sets the left offset for chart.
#' @param offsetY Sets the top offset for chart.
#' @param selection A list of parameters.
#' @param sparkline List. Sparkline hides all the elements of the charts other than the primary paths. Helps to visualize data in small areas. .
#' @param toolbar A list of parameters. See \url{https://apexcharts.com/docs/options/chart/toolbar/}.
#' @param zoom A list of parameters. See \url{https://apexcharts.com/docs/options/chart/zoom/}.
#' @param width Width of the chart. 
#' @param height Height of the chart. 
#' @param ... Additional parameters. 
#'
#' @export
#' 
#' @example examples/ax_chart.R
#' @example examples/localization.R
ax_chart <- function(ax,
                     type = NULL,
                     stacked = NULL,
                     stackType = NULL,
                     defaultLocale = NULL,
                     locales = NULL,
                     animations = NULL,
                     background = NULL,
                     foreColor = NULL,
                     dropShadow = NULL,
                     events = NULL,
                     offsetX = NULL,
                     offsetY = NULL,
                     selection = NULL,
                     sparkline = NULL,
                     toolbar = NULL,
                     zoom = NULL,
                     width = NULL,
                     height = NULL,
                     ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "chart", l = dropNulls(params))
}


#' Specific options for chart
#'
#' @template ax-default 
#' @param bar See [bar_opts()].
#' @param heatmap See [heatmap_opts()].
#' @param radialBar See [radialBar_opts()].
#' @param pie See [pie_opts()].
#' @param bubble See [bubble_opts()].
#' @param boxPlot See [boxplot_opts()].
#' @param ... Additional parameters.
#'
#' 
#' @export
#' 
#' @examples 
#' data("diamonds", package = "ggplot2")
#' 
#' # Stack bar type
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = cut)
#' ) %>%
#'   ax_plotOptions(
#'     bar = bar_opts(endingShape = "rounded", columnWidth = "10%")
#'   )
#' 
#' # Pie
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = cut), 
#'   type = "pie"
#' ) %>%
#'   ax_plotOptions(
#'     pie = pie_opts(customScale = 0.5)
#'   )
#' 
#' 
#' # Radial
#' apexchart() %>% 
#'   ax_chart(type = "radialBar") %>% 
#'   ax_plotOptions(
#'     radialBar = radialBar_opts(
#'       hollow = list(size = "70%")
#'     )
#'   ) %>% 
#'   ax_series(70) %>% 
#'   ax_labels("Indicator")
ax_plotOptions <- function(ax,
                           bar = NULL,
                           heatmap = NULL,
                           radialBar = NULL,
                           pie = NULL,
                           bubble = NULL,
                           boxPlot = NULL,
                           ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "plotOptions", l = dropNulls(params))
}


#' Colors
#'
#' @template ax-default 
#' @param ... Colors for the chart's series. When all colors are used, it starts from the beginning.
#'
#' 
#' @export
#' 
#' @note See \url{https://apexcharts.com/docs/options/colors/}
#' 
#' @examples 
#' data("diamonds", package = "ggplot2")
#' 
#' # Change default color(s)
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = cut)
#' ) %>%
#'   ax_colors("#F7D358")
#' 
#' 
#' library(scales)
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = cut, fill = color)
#' ) %>%
#'   ax_colors(brewer_pal(palette = "Set2")(7))
ax_colors <- function(ax, ...) {
  args <- list(...)
  if (length(args) == 1) {
    args <- as.list(args[[1]])
  }
  .ax_opt2(ax, "colors", l = args)
}


#' Labels on data
#'
#' @template ax-default 
#' @param enabled To determine whether to show dataLabels or not.
#' @param textAnchor The alignment of text relative to dataLabel's drawing position.
#'  Accepted values \code{"start"}, \code{"middle"} or \code{"end"}.
#' @param offsetX Sets the left offset for dataLabels.
#' @param offsetY Sets the top offset for dataLabels.
#' @param style A list of parameters.
#' @param dropShadow A list of parameters.
#' @param formatter The formatter function takes in a single value and allows you to format the value before displaying
#' @param ... Additional parameters.
#'
#' 
#' @export
#' 
#' @note See \url{https://apexcharts.com/docs/options/datalabels/}
#' 
#' @examples 
#' data("diamonds", package = "ggplot2")
#' 
#' # Add data labels
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = cut)
#' ) %>%
#'   ax_dataLabels(enabled = TRUE)
ax_dataLabels <- function(ax,
                          enabled = NULL,
                          textAnchor = NULL,
                          offsetX = NULL,
                          offsetY = NULL,
                          style = NULL,
                          dropShadow = NULL,
                          formatter = NULL,
                          ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "dataLabels", l = dropNulls(params))
}


#' Fill property
#'
#' @template ax-default 
#' @param type Whether to fill the paths with solid colors or gradient.
#'  Available options: \code{"solid"}, \code{"gradient"}, \code{"pattern"} or \code{"image"}.
#' @param colors Colors to fill the svg paths..
#' @param opacity Opacity of the fill attribute.
#' @param gradient A list of parameters.
#' @param image A list of parameters.
#' @param pattern A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#' 
#' @note See \url{https://apexcharts.com/docs/options/fill/}
#' 
#' @examples 
#' data("diamonds", package = "ggplot2")
#' 
#' # Use a pattern to fill bars
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = color, fill = cut)
#' ) %>% 
#'   ax_fill(
#'     type = "pattern", 
#'     opacity = 1, 
#'     pattern = list(
#'       style = c("circles", "slantedLines", "verticalLines", "horizontalLines", "squares")
#'     )
#'   )
#' 
#' 
#' data("economics", package = "ggplot2")
#' 
#' # Customise gradient
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = psavert),
#'   type = "area"
#' ) %>%
#'   ax_fill(gradient = list(
#'     enabled = TRUE,
#'     shadeIntensity = 1,
#'     inverseColors = FALSE,
#'     opacityFrom = 0,
#'     opacityTo = 1,
#'     stops = c(0, 2000)
#'   ))
ax_fill <- function(ax,
                    type = NULL,
                    colors = NULL,
                    opacity = NULL,
                    gradient = NULL,
                    image = NULL,
                    pattern = NULL,
                    ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "fill", l = dropNulls(params))
}


#' Add grids on chart
#'
#' @template ax-default 
#' @param show Logical. To show or hide grid area (including xaxis / yaxis)
#' @param borderColor Colors of grid borders / lines.
#' @param strokeDashArray Creates dashes in borders of svg path. Higher number creates more space between dashes in the border.
#' @param position Whether to place grid behind chart paths of in front. Available options for position: \code{"front"} or \code{"back"}
#' @param xaxis A list of parameters.
#' @param yaxis A list of parameters.
#' @param row A list of parameters.
#' @param column A list of parameters.
#' @param padding A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/grid/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # Hide Y-axis and gridelines
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_grid(show = FALSE)
#' 
#' # just grid lines
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_grid(yaxis = list(lines = list(show = FALSE)))
#' 
#' 
#' # both x & y
#' data("economics", package = "ggplot2")
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = psavert),
#'   type = "line"
#' ) %>% 
#'   ax_grid(
#'     yaxis = list(lines = list(show = TRUE)),
#'     xaxis = list(lines = list(show = TRUE))
#'   )
ax_grid <- function(ax,
                    show = NULL,
                    borderColor = NULL,
                    strokeDashArray = NULL,
                    position = NULL,
                    xaxis = NULL,
                    yaxis = NULL,
                    row = NULL,
                    column = NULL,
                    padding = NULL,
                    ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "grid", l = dropNulls(params))
}


#' Alternative axis labels
#'
#' @template ax-default 
#' @param labels A vector to use as labels.
#' @param ... Vector. In Axis Charts (line / column), labels can be set instead of setting xaxis categories
#'  option. While, in pie/donut charts, each label corresponds to value in series array.
#'
#' 
#' @export
#' 
#' @name ax_labels
#'
#' @note See \url{https://apexcharts.com/docs/options/labels/}
#' 
#' @examples
#' apexchart() %>% 
#'   ax_chart(type = "pie") %>% 
#'   ax_series(23, 45, 56) %>% 
#'   ax_labels("A", "B", "C")
#' 
#' # same as 
#' apexchart() %>% 
#'   ax_chart(type = "pie") %>% 
#'   ax_series2(c(23, 45, 56)) %>% 
#'   ax_labels2(c("A", "B", "C"))
ax_labels <- function(ax, ...) {
  .ax_opt(ax, "labels", ...)
}
#' @rdname ax_labels
#' @export
ax_labels2 <- function(ax, labels) {
  .ax_opt2(ax, "labels", l = labels)
}



#' Legend properties
#'
#' @template ax-default 
#' @param show Logical. Whether to show or hide the legend container.
#' @param position Available position options for legend: \code{"top"}, \code{"right"}, \code{"bottom"}, \code{"left"}.
#' @param showForSingleSeries Show legend even if there is just 1 series.
#' @param showForNullSeries Allows you to hide a particular legend if it's series contains all null values.
#' @param showForZeroSeries Allows you to hide a particular legend if it's series contains all 0 values.
#' @param horizontalAlign Available options for horizontal alignment: \code{"right"}, \code{"center"}, \code{"left"}.
#' @param fontSize Sets the fontSize of legend text elements
#' @param textAnchor The alignment of text relative to legend's drawing position
#' @param offsetY Sets the top offset for legend container.
#' @param offsetX Sets the left offset for legend container.
#' @param formatter JS function. A custom formatter function to append additional text to the legend series names.
#' @param labels List with two items \code{"foreColor"} (Custom text color for legend labels)
#'  and \code{"useSeriesColors"} (Logical, whether to use primary colors or not)
#' @param markers List.
#' @param itemMargin List with two items \code{"horizontal"} (Horizontal margin for individual legend item)
#'  and \code{"vertical"} (Vertical margin for individual legend item).
#' @param containerMargin List with two items \code{"top"} (Top margin for the whole legend container)
#'  and \code{"left"} (Left margin for the whole legend container).
#' @param onItemClick List with item \code{"toggleDataSeries"}, logical,
#'  when clicked on legend item, it will toggle the visibility of the series in chart.
#' @param onItemHover List with item \code{"highlightDataSeries"}, logical,
#'  when hovered on legend item, it will highlight the paths of the hovered series in chart.
#' @param floating Logical. The floating option will take out the legend from the chart area and make it float above the chart.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/legend/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # Legend position
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer, fill = year)
#' ) %>% 
#'   ax_legend(position = "right")
#' 
#' # hide legend
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer, fill = year)
#' ) %>% 
#'   ax_legend(show = FALSE)
ax_legend <- function(ax,
                      show = NULL,
                      position = NULL,
                      showForSingleSeries = NULL,
                      showForNullSeries= NULL,
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
                      ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "legend", l = dropNulls(params))
}


#' Markers properties
#'
#' @template ax-default 
#' @param size Numeric. Size of the marker point.
#' @param colors Sets the fill color(s) of the marker point.
#' @param strokeColor Stroke Color of the marker.
#' @param strokeWidth Stroke Size of the marker.
#' @param strokeOpacity Opacity of the border around marker.
#' @param fillOpacity Opacity of the marker fill color.
#' @param shape Shape of the marker. Available Options for shape: \code{"square"} or \code{"circle"}.
#' @param radius Numeric. Radius of the marker (applies to square shape)
#' @param offsetX Numeric. Sets the left offset of the marker.
#' @param offsetY Numeric. Sets the top offset of the marker.
#' @param hover List with item \code{size} (Size of the marker when it is active).
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/markers/}
#' 
#' @examples 
#' data("economics", package = "ggplot2")
#' 
#' # show points
#' apex(
#'   data = tail(economics, 20),
#'   type = "line", 
#'   mapping = aes(x = date, y = uempmed)
#' ) %>% 
#'   ax_markers(size = 6) 
ax_markers <- function(ax,
                       size = NULL,
                       colors = NULL,
                       strokeColor = NULL,
                       strokeWidth = NULL,
                       strokeOpacity = NULL,
                       fillOpacity = NULL,
                       shape = NULL,
                       radius = NULL,
                       offsetX = NULL,
                       offsetY = NULL,
                       hover = NULL,
                       ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "markers", l = dropNulls(params))
}


#' No data specification
#'
#' @template ax-default 
#' @param text 
#' @param align 
#' @param verticalAlign 
#' @param offsetX 
#' @param offsetY 
#' @param style 
#' @param ... Additional parameters.
#'
#' 
#' @noRd
#'
ax_noData <- function(ax,
                      text = NULL,
                      align = NULL,
                      verticalAlign = NULL,
                      offsetX = NULL,
                      offsetY = NULL,
                      style = NULL,
                      ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "noData", l = dropNulls(params))
}


#' Responsive options
#'
#' @template ax-default 
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/responsive/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # Open in browser and resize window
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer, fill = year),
#'   type = "bar"
#' ) %>% 
#'   ax_legend(position = "right") %>% 
#'   ax_responsive(
#'     list(
#'       breakpoint = 1000,
#'       options = list(
#'         plotOptions = list(
#'           bar = list(
#'             horizontal = FALSE
#'           )
#'         ),
#'         legend = list(
#'           position = "bottom"
#'         )
#'       )
#'     )
#'   )
ax_responsive <- function(ax, ...) {
  .ax_opt(ax, "responsive", ...)
}


#' Add data to a chart
#'
#' @template ax-default 
#' @param ... Lists containing data to plot, typically list with two items: \code{name} and \code{data}.
#'
#' 
#' @export
#' 
#' @name ax-series
#'
#' @examples
#' 
#' # One serie
#' apexchart() %>% 
#'   ax_series(list(
#'     name = "rnorm",
#'     data = rnorm(10)
#'   ))
#' 
#' # Two series
#' apexchart() %>% 
#'   ax_series(
#'     list(
#'       name = "rnorm 1",
#'       data = rnorm(10)
#'     ),
#'     list(
#'       name = "rnorm 2",
#'       data = rnorm(10)
#'     )
#'   )
ax_series <- function(ax, ...) {
  .ax_opt(ax, "series", ...)
}

#' @param l A list.
#' @export
#' @rdname ax-series
ax_series2 <- function(ax, l) {
  .ax_opt2(ax, "series", l)
}


#' Charts' states
#'
#' @template ax-default 
#' @param normal A list of parameters.
#' @param hover A list of parameters.
#' @param active A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/states/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # Inverse effect on hover
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer),
#'   type = "bar"
#' ) %>% 
#'   ax_states(
#'     hover = list(
#'       filter = list(
#'         type = "darken"
#'       )
#'     )
#'   )
ax_states <- function(ax,
                      normal = NULL,
                      hover = NULL,
                      active = NULL,
                      ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "states", l = dropNulls(params))
}


#' Chart's title
#'
#' @template ax-default 
#' @param text Text to display as a title of chart.
#' @param align Alignment of subtitle relative to chart area. Possible Options: \code{"left"}, \code{"center"} and \code{"right"}.
#' @param margin Numeric. Vertical spacing around the title text.
#' @param offsetX Numeric. Sets the left offset for subtitle text.
#' @param offsetY Numeric. Sets the top offset for subtitle text
#' @param floating Logical. The floating option will take out the subtitle text from the chart area and make it float on top of the chart.
#' @param style List with two items: \code{fontSize} (Font Size of the title text) and \code{color} (Fore color of the title text).
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/title/}
#' 
#' @examples 
#' data("economics", package = "ggplot2")
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>% 
#'   ax_title(
#'     text = "Median duration of unemployment, in weeks"
#'   )
ax_title <- function(ax,
                     text = NULL,
                     align = NULL,
                     margin = NULL,
                     offsetX = NULL,
                     offsetY = NULL,
                     floating = NULL,
                     style = NULL,
                     ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "title", l = dropNulls(params))
}


#' Chart's subtitle
#'
#' @template ax-default 
#' @param text Text to display as a subtitle of chart.
#' @param align Alignment of subtitle relative to chart area. Possible Options: \code{"left"}, \code{"center"} and \code{"right"}.
#' @param margin Numeric. Vertical spacing around the subtitle text.
#' @param offsetX Numeric. Sets the left offset for subtitle text.
#' @param offsetY Numeric. Sets the top offset for subtitle text
#' @param floating Logical. The floating option will take out the subtitle text from the chart area and make it float on top of the chart.
#' @param style List with two items: \code{fontSize} (Font Size of the subtitle text) and \code{color} (Fore color of the subtitle text).
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/subtitle/}
#' 
#' @examples 
#' data("economics", package = "ggplot2")
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>%
#'   ax_title(
#'     text = "Median duration of unemployment"
#'   ) %>%
#'   ax_subtitle(
#'     text = "in weeks"
#'   )
ax_subtitle <- function(ax,
                        text = NULL,
                        align = NULL,
                        margin = NULL,
                        offsetX = NULL,
                        offsetY = NULL,
                        floating = NULL,
                        style = NULL,
                        ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "subtitle", l = dropNulls(params))
}


#' Stroke properties
#'
#' @template ax-default 
#' @param show Logical. To show or hide path-stroke / line
#' @param curve In line / area charts, whether to draw smooth lines or straight lines.
#'  Available Options: \code{"smooth"} (connects the points in a curve fashion. Also known as spline) 
#'  and \code{"straight"} (connect the points in straight lines.).
#' @param lineCap For setting the starting and ending points of stroke. Available Options:
#'  \code{"butt"} (ends the stroke with a 90-degree angle), \code{"square"}
#'   (similar to butt except that it extends the stroke beyond the length of the path) 
#'   and \code{"round"} (ends the path-stroke with a radius that smooths out the start and end points)
#' @param width Sets the width of border for svg path.
#' @param colors Colors to fill the border for paths.
#' @param dashArray Creates dashes in borders of svg path. Higher number creates more space between dashes in the border. 
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/stroke/}
#' 
#' @examples 
#' data("economics", package = "ggplot2")
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = uempmed),
#'   type = "line"
#' ) %>%
#'   ax_stroke(
#'     width = 1, 
#'     dashArray = 4
#'   )
#' 
#' data("economics_long", package = "ggplot2")
#' apex(
#'   data = economics_long,
#'   mapping = aes(x = date, y = value01, group = variable),
#'   type = "line"
#' ) %>%
#'   ax_stroke(
#'     width = c(1, 2, 3, 4, 5), 
#'     dashArray = c(1, 2, 3, 4, 5)
#'   )
ax_stroke <- function(ax,
                      show = NULL,
                      curve = NULL,
                      lineCap = NULL,
                      width = NULL,
                      colors = NULL,
                      dashArray = NULL,
                      ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "stroke", l = dropNulls(params))
}


#' Tooltip options
#'
#' @template ax-default 
#' @param enabled Logical. Show tooltip when user hovers over chart area.
#' @param shared Logical. When having multiple series, show a shared tooltip.
#' @param followCursor Logical. Follow user's cursor position instead of putting tooltip on actual data points.
#' @param intersect Logical. Show tooltip only when user hovers exactly over datapoint.
#' @param inverseOrder Logical. In multiple series, when having shared tooltip, inverse the order of series (for better comparison in stacked charts).
#' @param custom JS function. Draw a custom html tooltip instead of the default one based on the values provided in the function arguments. 
#' @param fillSeriesColor Logical. When enabled, fill the tooltip background with the corresponding series color.
#' @param onDatasetHover A list of parameters.
#' @param theme A list of parameters.
#' @param x A list of parameters.
#' @param y A list of parameters.
#' @param z A list of parameters.
#' @param marker A list of parameters.
#' @param items A list of parameters.
#' @param fixed A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/tooltip/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # Hide tooltip
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer, fill = year)
#' ) %>% 
#'   ax_tooltip(enabled = FALSE)
#' 
#' # Share between series
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer, fill = year)
#' ) %>% 
#'   ax_tooltip(shared = TRUE)
#' 
#' # Fixed tooltip
#' data("economics", package = "ggplot2")
#' apex(
#'   data = economics,
#'   mapping = aes(x = date, y = psavert),
#'   type = "line"
#' ) %>% 
#'   ax_tooltip(
#'     fixed = list(enabled = TRUE, position = "topLeft")
#'   )
ax_tooltip <- function(ax,
                       enabled = NULL,
                       shared = NULL,
                       followCursor = NULL,
                       intersect = NULL,
                       inverseOrder = NULL,
                       custom = NULL,
                       fillSeriesColor = NULL,
                       onDatasetHover = NULL,
                       theme = NULL,
                       x = NULL,
                       y = NULL,
                       z = NULL,
                       marker = NULL,
                       items = NULL,
                       fixed = NULL,
                       ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "tooltip", l = dropNulls(params))
}


#' X-axis options
#'
#' @template ax-default 
#' @param type Character. Available Options : \code{"categories"} and \code{"datetime"}.
#' @param categories Categories are labels which are displayed on the x-axis.
#' @param labels A list of parameters.
#' @param axisBorder A list of parameters.
#' @param axisTicks A list of parameters.
#' @param tickAmount Number of Tick Intervals to show.
#' @param min Lowest number to be set for the x-axis. The graph drawing beyond this number will be clipped off.
#' @param max Highest number to be set for the x-axis. The graph drawing beyond this number will be clipped off.
#' @param range Range takes the max value of x-axis, subtracts the provided range value and gets the min value based on that.
#'  So, technically it helps to keep the same range when min and max values gets updated dynamically.
#' @param floating Logical. Floating takes x-axis is taken out of normal flow and places x-axis on svg element directly,
#'  similar to an absolutely positioned element. Set the offsetX and offsetY then to adjust the position manually
#' @param position Setting this option allows you to change the x-axis position. Available options: \code{"top"} and \code{"bottom"}.
#' @param title A list of parameters.
#' @param crosshairs A list of parameters.
#' @param tooltip A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/xaxis/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' # X axis title
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_xaxis(title = list(text = "Car's manufacturer"))
#' 
#' # force labels to rotate and increase height
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_xaxis(labels = list(rotateAlways = TRUE, maxHeight = 180))
#' 
#' # force to not rotate
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_xaxis(labels = list(rotate = 0, trim = FALSE))
#' 
#' 
#' data("economics", package = "ggplot2")
#' 
#' # Custom crosshair
#' apex(
#'   data = tail(economics, 50),
#'   mapping = aes(x = date, y = psavert),
#'   type = "line"
#' ) %>% 
#'   ax_xaxis(
#'     crosshairs = list(
#'       opacity = 1,
#'       width = 2,
#'       fill = list(color = "red"),
#'       stroke = list(width = 0)
#'     )
#'   )
#' 
#' 
#' # Date format (zoom to see changes)
#' apex(
#'   data = tail(economics, 150),
#'   mapping = aes(x = date, y = psavert),
#'   type = "line"
#' ) %>% 
#'   ax_xaxis(
#'     labels = list(
#'       datetimeFormatter = list(
#'         year = "yyyy-MM",
#'         month = "yyyy-MM-dd",
#'         day = "yyyy-MM-dd HH:mm"
#'       )
#'     )
#'   )
ax_xaxis <- function(ax,
                     type = NULL,
                     categories = NULL,
                     labels = NULL,
                     axisBorder = NULL,
                     axisTicks = NULL,
                     tickAmount = NULL,
                     min = NULL,
                     max = NULL,
                     range = NULL,
                     floating = NULL,
                     position = NULL,
                     title = NULL,
                     crosshairs = NULL,
                     tooltip = NULL,
                     ...) {
  params <- c(as.list(environment()), list(...))[-1]
  .ax_opt2(ax, "xaxis", l = dropNulls(params))
}


#' Y-axis options
#'
#' @template ax-default 
#' @param opposite Logical. When enabled, will draw the yaxis on the right side of the chart.
#' @param tickAmount Number of Tick Intervals to show.
#' @param max Lowest number to be set for the y-axis. The graph drawing beyond this number will be clipped off.
#' @param min Highest number to be set for the y-axis. The graph drawing beyond this number will be clipped off.
#' @param floating Logical. Floating takes y-axis is taken out of normal flow and places y-axis on svg element directly,
#'  similar to an absolutely positioned element. Set the offsetX and offsetY then to adjust the position manually
#' @param labels A list of parameters.
#' @param axisBorder A list of parameters.
#' @param axisTicks A list of parameters.
#' @param title A list of parameters.
#' @param tooltip A list of parameters.
#' @param crosshairs A list of parameters.
#' @param ... Additional parameters.
#'
#' 
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/yaxis/}
#' 
#' @examples 
#' data("economics_long", package = "ggplot2")
#' apex(
#'   data = economics_long,
#'   mapping = aes(x = date, y = value01, group = variable),
#'   type = "line"
#' ) %>%
#'   ax_yaxis(
#'     decimalsInFloat = 2, title = list(text = "Rescaled to [0,1]")
#'   )
#'   
#' # Format tick labels
#' temperature <- data.frame(
#'   month = head(month.name),
#'   tp = c(4, -2, 2, 7, 11, 14)
#' )
#' apex(temperature, aes(month, tp), "line") %>% 
#'   ax_yaxis(
#'     labels = list(
#'       formatter = htmlwidgets::JS("function(value) {return value + '\u00b0C';}")
#'     )
#'   )
ax_yaxis <- function(ax,
                     opposite = NULL,
                     tickAmount = NULL,
                     max = NULL,
                     min = NULL,
                     floating = NULL,
                     labels = NULL,
                     axisBorder = NULL,
                     axisTicks = NULL,
                     title = NULL,
                     tooltip = NULL,
                     crosshairs = NULL,
                     ...) {
  params <- c(as.list(environment()), list(...))[-1]
  yaxis <- .get_ax_opt(ax, "yaxis")
  if (inherits(yaxis, "yaxis2")) {
    yaxis[[1]] <- dropNulls(params)
  } else {
    yaxis <- dropNulls(params)
    class(yaxis) <- c(class(yaxis), "yaxis1")
  }
  .ax_opt2(ax, "yaxis", l = yaxis)
}


#' Secondary Y-axis options
#'
#' @template ax-default 
#' @param ... See arguments from \code{\link{ax_yaxis}}.
#'
#' 
#' @export
#'
#' @example examples/ax_yaxis2.R 
ax_yaxis2 <- function(ax, ...) {
  params <- dropNulls(list(...))
  yaxis <- .get_ax_opt(ax, "yaxis")
  if (inherits(yaxis, "yaxis2")) {
    yaxis[[2]] <- params
  } else {
    yaxis <- list(yaxis, params)
    class(yaxis) <- c(setdiff(class(yaxis), "yaxis1"), "yaxis2")
    ax$x$ax_opts$yaxis <- NULL
  }
  .ax_opt2(ax, "yaxis", l = yaxis)
}




#' Theme for charts
#'
#' @template ax-default
#' @param mode use light or dark theme.
#' @param palette Character. Available palettes: \code{"palette1"} to \code{"palette10"}.
#' @param monochrome A list of parameters.
#' @param ... Additional parameters.
#'
#' @export
#'
#' @note See \url{https://apexcharts.com/docs/options/theme/}
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' data("diamonds", package = "ggplot2")
#' 
#' # Dark mode
#' apex(
#'   data = mpg,
#'   mapping = aes(x = manufacturer)
#' ) %>% 
#'   ax_theme(mode = "dark")
#' 
#' # Use predefined palette (1 to 10)
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = color, fill = cut)
#' ) %>% 
#'   ax_theme(palette = "palette2")
#' 
#' # monochrome palette
#' apex(
#'   data = diamonds,
#'   mapping = aes(x = color, fill = cut)
#' ) %>% 
#'   ax_theme(monochrome = list(enabled = TRUE, color = "#0B6121"))
ax_theme <- function(ax,
                     mode = c("light", "dark"),
                     palette = NULL,
                     monochrome = NULL,
                     ...) {
  mode <- match.arg(mode)
  params <- c(list(
    mode = mode,
    palette = palette,
    monochrome = monochrome
  ), list(...))
  .ax_opt2(ax, "theme", l = dropNulls(params))
}






#' Configuration for charts with no data
#'
#' @template ax-default
#' @param text The text to display when no-data is available.
#' @param align Horizontal alignment: \code{"left"}, \code{"center"} or \code{"right"}.
#' @param verticalAlign Vertical alignment: \code{"top"}, \code{"middle"} or \code{"bottom"}.
#' @param color ForeColor of the text.
#' @param fontSize FontSize of the text.
#' @param fontFamily FontFamily of the text.
#' @param offsetX,offsetY Text offset.
#'
#' @export
#'
#' @examples
#' empty <- data.frame(
#'   var1 = character(0),
#'   var2 = numeric(0)
#' )
#' apex(empty, aes(var1, var2), "column") %>% 
#'   ax_nodata(
#'     text = "Sorry no data to visualize",
#'     fontSize = "30px"
#'   )
ax_nodata <- function(ax, 
                      text = "No data", 
                      align = "center", 
                      verticalAlign = "middle",
                      color = NULL, 
                      fontSize = NULL, 
                      fontFamily = NULL,
                      offsetX = NULL,
                      offsetY = NULL) {
  params <- list(
    text = text,
    align = align,
    verticalAlign = verticalAlign,
    offsetX = offsetX,
    offsetY = offsetY,
    style = dropNulls(list(
      color = color,
      fontSize = fontSize,
      fontFamily = fontFamily
    ))
  )
  .ax_opt2(ax, "noData", l = dropNulls(params))
}




#' Forecast data points
#'
#' @template ax-default
#' @param count Number of ending data-points you want to indicate as a forecast or prediction values.
#'  The ending line/bar will result into a dashed border with a distinct look to differentiate from the rest of the data-points.
#' @param fillOpacity Opacity of the fill attribute.
#' @param strokeWidth Sets the width of the points.
#' @param dashArray Creates dashes in borders of svg path. Higher number creates more space between dashes in the border.
#' @param ... Additional arguments (not used).
#'
#' @export
#'
#' @examples
#' # add 5 predictions to data then plot it
#' data.frame(
#'   time = seq_len(53),
#'   lh = c(
#'     as.vector(lh),
#'     as.vector(predict(arima(lh, order = c(1,0,1)), 5)$pred)
#'   )
#' ) %>% 
#'   apex(aes(time, lh), type = "line") %>% 
#'   ax_xaxis(type = "numeric") %>% 
#'   ax_forecast_data_points(count = 5)
ax_forecast_data_points <- function(ax,
                                    count = NULL,
                                    fillOpacity = NULL,
                                    strokeWidth = NULL,
                                    dashArray = NULL,
                                    ...) {
  params <- list(
    count = count,
    fillOpacity = fillOpacity,
    strokeWidth = strokeWidth,
    dashArray = dashArray
  )
  .ax_opt2(ax, "forecastDataPoints", l = dropNulls(params))
}





