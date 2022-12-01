
#' Create an ApexCharts widget
#'
#' @param ax_opts A `list` in JSON format with chart parameters.
#' @param auto_update In Shiny application, update existing chart
#'  rather than generating new one. Can be `TRUE`/`FALSE` or
#'  use [config_update()] for more control.
#' @param width,height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#'
#' @return An [apexchart()] `htmlwidget` object.
#' @seealso For quickly create a chart, see [apex()].
#' @export
#'
#' @importFrom htmlwidgets createWidget sizingPolicy
#'
#' @example examples/apexchart.R
apexchart <- function(ax_opts = list(),
                      auto_update = TRUE,
                      width = NULL,
                      height = NULL,
                      elementId = NULL) {

  if (isTRUE(auto_update)) {
    auto_update <- config_update()
  }

  x <- list(
    ax_opts = ax_opts,
    auto_update = auto_update,
    sparkbox = FALSE
  )

  # create widget
  htmlwidgets::createWidget(
    name = "apexcharter",
    x = x,
    width = width,
    height = height,
    package = "apexcharter",
    elementId = elementId,
    preRenderHook = function(widget) {
      widget$x$data <- NULL
      widget$x$mapping <- NULL
      widget$x$add_line <- NULL
      add_locale_apex(widget)
    },
    sizingPolicy = htmlwidgets::sizingPolicy(
      defaultWidth = "100%",
      defaultHeight = "100%",
      viewer.defaultHeight = "100%",
      viewer.defaultWidth = "100%",
      knitr.figure = FALSE,
      knitr.defaultWidth = "100%",
      knitr.defaultHeight = "350px",
      browser.fill = TRUE,
      viewer.suppress = FALSE,
      browser.external = TRUE,
      padding = 0
    )
  )
}

# dput(tools::file_path_sans_ext(list.files("inst/apexcharts-locale/")))
#' @importFrom jsonlite fromJSON
add_locale_apex <- function(widget) {
  if (!is.null(widget$x$ax_opts$chart$defaultLocale)) {
    defaultLocale <- widget$x$ax_opts$chart$defaultLocale
    defaultLocale <- match.arg(
      arg = defaultLocale,
      choices = c("ca", "cs", "de", "el", "en", "es", "fi", "fr", "he", "hi",
                  "hr", "hu", "hy", "id", "it", "ja", "ka", "ko", "lt", "nb", "nl",
                  "pl", "pt-br", "pt", "rs", "ru", "se", "sk", "sl", "sq", "th",
                  "tr", "ua", "zh-cn")
    )
    if (!is.null(widget$x$ax_opts$chart$locales)) {
      warning(
        "defaultLocale is used but will be ignored since",
        " a custom array for locales is provided."
      )
    } else {
      path <- system.file(
        file.path("apexcharts-locale", paste0(defaultLocale, ".json")),
        package = "apexcharter"
      )
      locale <- jsonlite::fromJSON(txt = path)
      widget$x$ax_opts$chart$locales <- list(locale)
    }
  }
  widget
}



#' Configuration for auto update
#'
#' @param series_animate Should the chart animate on re-rendering.
#' @param update_options Update or not global options for chart.
#' @param options_animate Should the chart animate on re-rendering.
#' @param options_redrawPaths When the chart is re-rendered,
#'  should it draw from the existing paths or completely redraw
#'  the chart paths from the beginning. By default, the chart
#'  is re-rendered from the existing paths.
#' @param update_synced_charts All the charts in a group should
#'  also update when one chart in a group is updated.
#'
#' @export
config_update <- function(series_animate = TRUE,
                          update_options = FALSE,
                          options_animate = TRUE,
                          options_redrawPaths = TRUE,
                          update_synced_charts = FALSE) {
  list(
    series_animate = series_animate,
    update_options = update_options,
    options_animate = options_animate,
    options_redrawPaths = options_redrawPaths,
    update_synced_charts = update_synced_charts
  )
}


#' @title Shiny bindings for apexcharter
#'
#' @description Output and render functions for using apexcharter within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId Output variable to read from.
#' @param width,height Must be a valid CSS unit (like `100%`,
#'   `400px`, `auto`) or a number, which will be coerced to a
#'   string and have `px` appended.
#' @param expr An expression that generates a calendar
#' @param env The environment in which to evaluate `expr`.
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This
#'   is useful if you want to save an expression in a variable.
#'
#' @return Output element that can be included in UI. Render function to create output in server.
#'
#' @note To render a chart with facets (using [ax_facet_wrap()] or [ax_facet_grid()]) in Shiny,
#'  see [apexfacetOutput()] (in UI) and [renderApexfacet()] (in Server).
#'
#' @name apexcharter-shiny
#'
#' @export
#'
#' @importFrom htmlwidgets shinyWidgetOutput shinyRenderWidget
#'
#' @example examples/apexcharter-shiny.R
apexchartOutput <- function(outputId, width = "100%", height = "400px") { # nocov start
  htmlwidgets::shinyWidgetOutput(outputId, "apexcharter", width, height, package = "apexcharter")
} # nocov end

#' @rdname apexcharter-shiny
#' @export
renderApexchart <- function(expr, env = parent.frame(), quoted = FALSE) { # nocov start
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, apexchartOutput, env, quoted = TRUE)
} # nocov end
