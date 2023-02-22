



# ApexCharts options ------------------------------------------------------



#' Events options
#'
#' @param click Fires when user clicks on any area of the chart.
#' @param beforeMount Fires before the chart has been drawn on screen.
#' @param mounted Fires after the chart has been drawn on screen.
#' @param updated Fires when the chart has been dynamically updated.
#' @param legendClick Fires when user clicks on legend. 
#' @param selection Fires when user selects rect using the selection tool. 
#' @param dataPointSelection Fires when user clicks on a datapoint (bar/column/marker/bubble/donut-slice). 
#' @param dataPointMouseEnter Fires when user's mouse enter on a datapoint (bar/column/marker/bubble/donut-slice). 
#' @param dataPointMouseLeave MouseLeave event for a datapoint (bar/column/marker/bubble/donut-slice). 
#' @param beforeZoom This function, if defined, runs just before zooming in/out of the chart allowing you to set a custom range for zooming in/out. 
#' @param zoomed Fires when user zooms in/out the chart using either the selection zooming tool or zoom in/out buttons. 
#' @param scrolled Fires when user scrolls using the pan tool. 
#' @param ... Additional parameters.
#' 
#' @note All arguments should be JavaScript function defined with \code{htmlwidgets::JS}.
#' 
#' @return A \code{list} of options that can be used in \code{\link{ax_chart}}.
#'
#' @note See \url{https://apexcharts.com/docs/options/chart/events/}.
#' 
#' @export
#' 
#' @examples 
#' 
#' if (interactive()) {
#'   library(shiny)
#'   
#'   ui <- fluidPage(
#'     fluidRow(
#'       column(
#'         width = 8, offset = 2,
#'         tags$h2("Apexchart in Shiny"),
#'         apexchartOutput("chart"),
#'         verbatimTextOutput(outputId = "res_click")
#'       )
#'     )
#'   )
#'   
#'   server <- function(input, output, session) {
#'     
#'     output$chart <- renderApexchart({
#'       apexchart() %>%
#'         ax_chart(
#'           type = "bar",
#'           events = events_opts(
#'             dataPointSelection = JS(
#'               "function(event, chartContext, config) {
#'                Shiny.setInputValue('click', config.selectedDataPoints)
#'               }"
#'             ) 
#'           )
#'         ) %>%
#'         ax_series(
#'           list(
#'             name = "Example",
#'             data = sample(1:100, 5)
#'           )
#'         ) %>%
#'         ax_xaxis(
#'           categories = LETTERS[1:5]
#'         )
#'     })
#'     
#'     output$res_click <- renderPrint({
#'       input$click
#'     })
#'   }
#'   
#'   shinyApp(ui, server)
#' }
events_opts <- function(click = NULL,
                        beforeMount = NULL,
                        mounted = NULL,
                        updated = NULL,
                        legendClick = NULL,
                        selection = NULL,
                        dataPointSelection = NULL,
                        dataPointMouseEnter = NULL,
                        dataPointMouseLeave = NULL,
                        beforeZoom = NULL,
                        zoomed = NULL,
                        scrolled = NULL,
                        ...) {
  dropNulls(
    list(
      click = click,
      beforeMount = beforeMount,
      mounted = mounted,
      updated = updated,
      legendClick = legendClick,
      selection = selection,
      dataPointSelection = dataPointSelection,
      dataPointMouseEnter = dataPointMouseEnter,
      dataPointMouseLeave = dataPointMouseLeave,
      beforeZoom = beforeZoom,
      zoomed = zoomed,
      scrolled = scrolled,
      ...
    )
  )
}




#' @title Bar options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param horizontal Logical. This option will turn a column chart into a horizontal bar chart.
#' @param endingShape Available Options: \code{"flat"} or \code{"rounded"}.
#' @param columnWidth In column charts, columnWidth is the percentage of the available width in the grid-rect. 
#' @param barHeight In horizontal bar charts, barHeight is the percentage of the available height in the grid-rect. 
#' @param distributed Logical. Turn this option to make the bars discrete. Each value indicates one bar per series.
#' @param colors A list of parameters.
#' @param dataLabels List with fields \code{position} (available options: \code{"top"}, \code{"center"} or \code{"bottom"})
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/bar/}.
#' 
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#'
#' @export
#' 
#' @examples 
#' 
#' data("mpg", package = "ggplot2")
#' 
#' apex(mpg, aes(manufacturer)) %>% 
#'   ax_plotOptions(
#'     bar = bar_opts(
#'       endingShape = "rounded",
#'       columnWidth = 100,
#'       distributed = TRUE
#'     )
#'   )
#'   
bar_opts <- function(horizontal = NULL,
                     endingShape = NULL,
                     columnWidth = NULL,
                     barHeight = NULL,
                     distributed = NULL,
                     colors = NULL,
                     dataLabels = NULL,
                     ...) {
  dropNulls(
    list(
      horizontal = horizontal,
      endingShape = endingShape,
      columnWidth = columnWidth,
      barHeight = barHeight,
      distributed = distributed,
      colors = colors,
      dataLabels = dataLabels,
      ...
    )
  )
}


#' @title Heatmap options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param radius Numeric. Radius of the rectangle inside heatmap.
#' @param enableShades Logical. Enable different shades of color depending on the value
#' @param shadeIntensity Numeric \code{[0,1]}. The intensity of the shades generated for each value.
#' @param colorScale List.
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/heatmap/}.
#' 
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#'
#' @export
#' 
#' @examples 
#' 
#' df <- expand.grid(
#'   month = month.name,
#'   person = c("Obi-Wan", "Luke", "Anakin", "Leia")
#' )
#' df$value <- sample(0:1, nrow(df), TRUE)
#' 
#' apex(
#'   data = df,
#'   mapping = aes(x = month, y = person, fill = value),
#'   type = "heatmap"
#' ) %>% 
#'   ax_plotOptions(
#'     heatmap = heatmap_opts(
#'       enableShades = FALSE,
#'       colorScale = list(
#'         ranges = list(
#'           list(from = 0, to = 0.5, color = "#FF0000"),
#'           list(from = 0.5, to = 1, color = "#088A08")
#'         )
#'       )
#'     )
#'   )
#'   
heatmap_opts <- function(radius = NULL,
                         enableShades = NULL,
                         shadeIntensity = NULL,
                         colorScale = NULL,
                         ...) {
  dropNulls(
    list(
      radius = radius,
      enableShades = enableShades,
      shadeIntensity = shadeIntensity,
      colorScale = colorScale,
      ...
    )
  )
}


#' @title Radial bar options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param size Numeric. Manual size of the radialBars instead of calculating automatically from default height / width.
#' @param inverseOrder Logical. Whether to make the first value of series innermost or outermost.
#' @param startAngle Numeric. Angle from which the radialBars should start.
#' @param endAngle Numeric. Angle to which the radialBars should end. The sum of the startAngle and endAngle should not exceed 360.
#' @param offsetX Numeric. Sets the left offset for radialBars.
#' @param offsetY Numeric. Sets the top offset for radialBars.
#' @param hollow List.
#' @param track List.
#' @param dataLabels List.
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/radialbar/}.
#' 
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#'
#' @export
#' 
#' @examples 
#' apexchart() %>% 
#'   ax_chart(type = "radialBar") %>% 
#'   ax_plotOptions(
#'     radialBar = radialBar_opts(
#'       startAngle = -135,
#'       endAngle = 135,
#'       dataLabels = list(
#'         name = list(
#'           fontSize = "16px",
#'           # color = undefined,
#'           offsetY = 120
#'         ),
#'         value = list(
#'           offsetY = 76,
#'           fontSize = "22px",
#'           # color = undefined,
#'           formatter = htmlwidgets::JS("function (val) {return val + '%';}")
#'         )
#'       )
#'     )
#'   ) %>% 
#'   ax_stroke(dashArray = 4) %>% 
#'   ax_series(70) %>% 
#'   ax_labels("Indicator")
radialBar_opts <- function(size = NULL,
                           inverseOrder = NULL,
                           startAngle = NULL,
                           endAngle = NULL,
                           offsetX = NULL,
                           offsetY = NULL,
                           hollow = NULL,
                           track = NULL,
                           dataLabels = NULL,
                           ...) {
  dropNulls(
    list(
      size = size,
      inverseOrder = inverseOrder,
      startAngle = startAngle,
      endAngle = endAngle,
      offsetX = offsetX,
      offsetY = offsetY,
      hollow = hollow,
      track = track,
      dataLabels = dataLabels,
      ...
    )
  )
}


#' @title Pie options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param size Numeric. Custom size of the pie which will override the default size calculations.
#' @param donut List with two fields \code{size} (Donut / ring size in percentage relative to the total pie area.)
#'  and \code{background} (The background color of the pie).
#' @param customScale Numeric. Transform the scale of whole pie/donut overriding the default calculations.
#' @param offsetX Numeric. Sets the left offset of the whole pie area.
#' @param offsetY Numeric. Sets the top offset of the whole pie area.
#' @param dataLabels List with field \code{offset} (Numeric, Offset by which labels will move outside / inside of the donut area)
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/pie/}.
#' 
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#'
#' @export
#' 
#' @examples 
#' data("mpg", package = "ggplot2")
#' 
#' apex(mpg, aes(cyl), type = "donut") %>%
#'   ax_plotOptions(
#'     pie = pie_opts(
#'       donut = list(size = "90%", background = "#BABABA")
#'     )
#'   )
pie_opts <- function(size = NULL,
                     donut = NULL,
                     customScale = NULL,
                     offsetX = NULL,
                     offsetY = NULL,
                     dataLabels = NULL,
                     ...) {
  dropNulls(
    list(
      size = size,
      donut = donut,
      customScale = customScale,
      offsetX = offsetX,
      offsetY = offsetY,
      dataLabels = dataLabels,
      ...
    )
  )
}



#' @title Bubble options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param minBubbleRadius Minimum radius size of a bubble.
#'  If a bubble value is too small to be displayed, this size will be used.
#' @param maxBubbleRadius Maximum radius size of a bubble.
#'  If a bubble value is too large to cover the chart, this size will be used.
#' @param ... Additional parameters.
#' 
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/bubble/}.
#'
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#' @export
#'
#' @examples
#' apex(
#'   data = mtcars, 
#'   type = "scatter", 
#'   mapping = aes(x = wt, y = mpg, z = qsec)
#' ) %>% 
#'   ax_plotOptions(
#'     bubble = bubble_opts(
#'       minBubbleRadius = 1,
#'       maxBubbleRadius = 20
#'     )
#'   )
bubble_opts <- function(minBubbleRadius, maxBubbleRadius, ...) {
  dropNulls(
    list(
      minBubbleRadius = minBubbleRadius,
      maxBubbleRadius = maxBubbleRadius,
      ...
    )
  )
}




#' @title Boxplot options
#' 
#' @description Use these options in [ax_plotOptions()].
#'
#' @param color.upper Color for the upper quartile (Q3 to median) of the box plot.
#' @param color.lower Color for the lower quartile (median to Q1) of the box plot.
#' @param ... Additional parameters.
#'
#' @note See \url{https://apexcharts.com/docs/options/plotoptions/boxplot/}.
#'
#' @return A \code{list} of options that can be used in [ax_plotOptions()].
#' @export
#'
#' @examples
#' data("mpg", package = "ggplot2")
#' apex(mpg, aes(class, hwy), "boxplot") %>% 
#'   ax_plotOptions(
#'     boxPlot = boxplot_opts(color.upper = "#848484", color.lower = "#848484" )
#'   )
boxplot_opts <- function(color.upper, color.lower, ...) {
  dropNulls(
    list(
      colors = dropNulls(list(
        upper = color.upper,
        lower = color.lower
      )),
      ...
    )
  )
}
