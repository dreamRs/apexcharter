
#' Create a box with a sparkline
#'
#' @param data A \code{data.frame}-like object with at least two columns,
#'  first is mapped to x-axis, second to y-axis.
#' @param title Title to display in the box.
#' @param subtitle Subtitle to display in the box.
#' @param color Color of the chart.
#' @param background Background color of the box.
#' @param type Type of chart, currently type supported are :
#'  \code{"area"} (default), \code{"line"}, \code{"spline"}, \code{"column"}.
#' @param synchronize Give a common id to charts to synchronize them (tooltip and zoom).
#' @param title_style,subtitle_style A \code{list} of named attributes to style
#'  the title / subtitle, possible values are \code{fontSize}, 
#'  \code{fontWeight}, \code{fontFamily}, \code{color}.
#' @param width,height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object. 
#' @export
#' 
#' @note In Shiny use \code{sparkBoxOutput} / \code{renderSparkBox} to render boxes, see example.
#'  Boxes have CSS class \code{"apexcharter-spark-box"} if you need more styling.
#' 
#' @importFrom htmlwidgets sizingPolicy
#' @importFrom rlang sym
#' @importFrom ggplot2 aes
#'
#' @example examples/spark_box.R
spark_box <- function(data, 
                      title = NULL,
                      subtitle = NULL, 
                      color = "#2E93fA", 
                      background = "#FFF",
                      type = c("area", "line", "spline", "column"),
                      synchronize = NULL,
                      title_style = NULL, 
                      subtitle_style = NULL,
                      width = NULL,
                      height = NULL, 
                      elementId = NULL) {
  type <- match.arg(type)
  data <- as.data.frame(data)
  if (ncol(data) < 2)
    stop("'data' must have at least two columns!", call. = FALSE)
  x_var <- names(data)[1]
  y_var <- names(data)[2]
  spark <- apex(
    data = data, 
    aes(x = !!sym(x_var), y = !!sym(y_var)),
    type = type, 
    auto_update = config_update(update_options = TRUE)
  )
  spark <- ax_chart(
    ax = spark, 
    sparkline = list(enabled = TRUE),
    group = synchronize
  )
  spark <- ax_yaxis(spark, show = FALSE)
  spark <- ax_colors(spark, color)
  if (!is.null(title)) {
    if (is.null(title_style))
      title_style <- list(fontSize = "24px")
    if (is.null(title_style$fontSize))
      title_style$fontSize <- "24px"
    spark <- ax_title(
      ax = spark,
      text = title,
      style = title_style
    )
  }
  if (!is.null(subtitle)) {
    if (is.null(subtitle_style))
      subtitle_style <- list(fontSize = "14px")
    if (is.null(subtitle_style$fontSize))
      subtitle_style$fontSize <- "14px"
    spark <- ax_subtitle(
      ax = spark,
      text = subtitle,
      style = subtitle_style
    )
  }
  spark$x$sparkbox <- list(
    color = color, background = background
  )
  spark$sizingPolicy <- htmlwidgets::sizingPolicy(
    defaultWidth = "100%",
    defaultHeight = "160px",
    viewer.defaultHeight = "160px",
    viewer.defaultWidth = "100%",
    viewer.fill = FALSE,
    knitr.figure = FALSE,
    knitr.defaultWidth = "100%",
    knitr.defaultHeight = "160px",
    browser.fill = FALSE,
    viewer.suppress = FALSE,
    browser.external = TRUE,
    padding = 15
  )
  return(spark)
}


#' @rdname apexcharter-shiny
#' @export
sparkBoxOutput <- function(outputId, width = "100%", height = "160px") { # nocov start
  htmlwidgets::shinyWidgetOutput(outputId, "apexcharter", width, height, package = "apexcharter")
} # nocov end

#' @rdname apexcharter-shiny
#' @export
renderSparkBox <- function(expr, env = parent.frame(), quoted = FALSE) { # nocov start
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, apexchartOutput, env, quoted = TRUE)
} # nocov end

