
#' Create a apexcharts.js widget
#'
#' @param ax_opts A \code{list} in JSON format with chart parameters
#' @param data A \code{data.frame}.
#' @param width A numeric input in pixels.
#' @param height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#'
#' @return A \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#' @examples
#'
#' library(apexcharter)
#'
#' apexchart(ax_opts = list(
#'   chart = list(type = "bar"),
#'   series = list(list(
#'     name = "Example",
#'     data = sample(1:100, 5)
#'   )),
#'   xaxis = list(categories = LETTERS[1:5])
#' ))
apexchart <- function(ax_opts = list(), data = NULL, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x <- list(
    ax_opts = ax_opts,
    data = data
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'apexcharter',
    x,
    width = width,
    height = height,
    package = 'apexcharter',
    elementId = elementId,
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "90%",
      defaultHeight = "90%",
      viewer.defaultHeight = "100%",
      viewer.defaultWidth = "100%",
      knitr.figure = FALSE,
      browser.fill = TRUE,
      viewer.suppress = FALSE,
      browser.external = TRUE,
      padding = 20
    )
  )
}

#' Shiny bindings for apexcharter
#'
#' Output and render functions for using apexcharter within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a apexcharter
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name apexcharter-shiny
#'
#' @export
#'
#' @importFrom htmlwidgets shinyWidgetOutput shinyRenderWidget
apexchartOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'apexcharter', width, height, package = 'apexcharter')
}

#' @rdname apexcharter-shiny
#' @export
renderApexchart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, apexchartOutput, env, quoted = TRUE)
}
