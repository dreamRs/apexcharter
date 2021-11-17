
#' @title Retrieve click information in Shiny
#' 
#' @description According to type of chart, different values are retrieved:
#'  * **bar and column:** retrieve category (x-axis).
#'  * **pie and donut:** retrieve label.
#'  * **time-series:** retrieve x-axis value, you have to display markers
#'   with size > 0 and set tooltip's options `intersect = TRUE` and `shared = FALSE`.
#'  * **scatter:** retrieve XY coordinates.
#'
#' @template ax-default
#' @param inputId The id that will be used server-side for retrieving click.
#' @param multiple Allow multiple selection: \code{TRUE} or \code{FALSE} (default).
#' @param effect_type Type of effect for selected element, default is to use lightly darken color.
#' @param effect_value A larger value intensifies the select effect, accept value between 0 and 1.
#' @param session The Shiny session.
#' 
#' @note If x-axis is of type datetime, value retrieved is of class \code{POSIXct}.
#'
#' @export
#' 
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' 
#' library(apexcharter)
#' 
#' # Not in Shiny but you can still click on bars
#' data.frame(
#'   month = month.abb,
#'   value = sample(1:100, 12)
#' ) %>% 
#'   apex(aes(month, value)) %>% 
#'   set_input_click("month_click", multiple = TRUE)
#' 
#' 
#' # Interactive examples:
#' if (interactive()) {
#' 
#'   run_demo_input("click")
#' 
#' }
set_input_click <- function(ax, inputId, multiple = FALSE,
                            effect_type = c("darken", "lighten", "none"), 
                            effect_value = 0.35, 
                            session = shiny::getDefaultReactiveDomain()) {
  effect_type <- match.arg(effect_type)
  if (is.null(session))
    session <- list(ns = identity)
  ax <- ax_states(ax, active = list(
    allowMultipleDataPointsSelection = isTRUE(multiple),
    filter = list(
      type = effect_type,
      value = effect_value
    )
  ))
  ax$x$shinyEvents$click <- list(
    inputId = session$ns(inputId)
  )
  ax
}





#' Retrieve zoom information in Shiny
#'
#' @template ax-default
#' @param inputId The id that will be used server-side for retrieving zoom.
#' @param session The Shiny session.
#' 
#' @note If x-axis is of type datetime, value retrieved is of class \code{POSIXct}.
#'
#' @export
#' 
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_demo_input("zoom")
#' 
#' }
set_input_zoom <- function(ax, inputId,
                           session = shiny::getDefaultReactiveDomain()) {
  if (is.null(session))
    session <- list(ns = identity)
  ax$x$shinyEvents$zoomed <- list(
    inputId = session$ns(inputId)
  )
  ax
}


#' Retrieve selection information in Shiny
#'
#' @template ax-default
#' @param inputId The id that will be used server-side for retrieving selection.
#' @param type Allow selection either on x-axis, y-axis or on both axis.
#' @param fill_color Background color of the selection rect which is drawn when user drags on the chart.
#' @param fill_opacity Opacity of background color of the selection rectangle.
#' @param stroke_width Border thickness of the selection rectangle.
#' @param stroke_dasharray Creates dashes in borders of selection rectangle.
#'  Higher number creates more space between dashes in the border.
#' @param stroke_color Colors of selection border.
#' @param stroke_opacity Opacity of selection border.
#' @param xmin,xmax Start value of x-axis. Both \code{min} and \code{max} must be provided.
#' @param ymin,ymax Start value of y-axis. Both \code{min} and \code{max} must be provided.
#' @param session The Shiny session.
#'
#' @export
#'
#' @examples
#' 
#' library(apexcharter)
#' data("economics", package = "ggplot2")
#' 
#' # Not in Shiny so no events
#' # but you can still select an area on chart
#' apex(economics, aes(date, psavert), type = "line") %>% 
#'   set_input_selection("selection")
#' 
#' # Default selection at start
#' apex(economics, aes(date, psavert), type = "line") %>% 
#'   set_input_selection(
#'     inputId = "selection", 
#'     xmin = format_date("1980-01-01"), 
#'     xmax = format_date("1985-01-01")
#'   )
set_input_selection <- function(ax, 
                                inputId,
                                type = c("x", "xy", "y"),
                                fill_color = "#24292e", 
                                fill_opacity = 0.1,
                                stroke_width = 1,
                                stroke_dasharray = 3, 
                                stroke_color = "#24292e", 
                                stroke_opacity = 0.4,
                                xmin = NULL, 
                                xmax = NULL, 
                                ymin = NULL, 
                                ymax = NULL,
                                session = shiny::getDefaultReactiveDomain()) {
  type <- match.arg(type)
  if (is.null(session))
    session <- list(ns = identity)
  selection <- list(
    enabled = TRUE, type = type,
    fill = list(color = fill_color, opacity = fill_opacity),
    stroke = list(
      width = stroke_width, dashArray = stroke_dasharray,
      color = stroke_color, opacity = stroke_opacity
    )
  )
  if (!is.null(xmin) & !is.null(xmax)) {
    selection$xaxis <- list(min = xmin, max = xmax)
  }
  if (!is.null(ymin) & !is.null(ymax)) {
    selection$yaxis <- list(min = ymin, max = ymax)
  }
  ax <- ax_chart(
    ax = ax,
    selection = selection,
    toolbar = list(autoSelected = "selection")
  )
  ax$x$shinyEvents$selection <- list(
    inputId = session$ns(inputId),
    type = type
  )
  ax
}




#' Retrieve chart's base64 dataURI.
#'
#' @template ax-default
#' @param inputId The id that will be used server-side for retrieving data.
#' @param session The Shiny session.
#'
#' @export
#'
#' @example examples/export-2.R
set_input_export <- function(ax, inputId,
                             session = shiny::getDefaultReactiveDomain()) { # nocov start
  if (is.null(session))
    session <- list(ns = identity)
  ax$x$shinyEvents$export <- list(
    inputId = session$ns(inputId)
  )
  ax
} # nocov end






# Demo --------------------------------------------------------------------

# nocov start

#' Run Shiny input events examples
#'
#' @param example Name of the example.
#'
#' @export
#' 
#' @importFrom shiny shinyAppFile
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_demo_input("click")
#'   run_demo_input("zoom")
#'   run_demo_input("selection")
#' 
#' }
run_demo_input <- function(example = c("click", "zoom", "selection")) { 
  example <- match.arg(example)
  shiny::shinyAppFile(
    appFile = system.file("examples/input", example, "app.R", package = "apexcharter"),
    options = list("display.mode" = "showcase")
  )
}




#' Run Shiny synchronization example
#'
#' @export
#' 
#' @importFrom shiny shinyAppFile
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_demo_sync()
#' 
#' }
run_demo_sync <- function() {
  shiny::shinyAppFile(
    appFile = system.file("examples/sync", "app.R", package = "apexcharter"),
    options = list("display.mode" = "showcase")
  )
}


#' Run Shiny spark boxes example
#'
#' @export
#' 
#' @importFrom shiny shinyAppFile
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_demo_sparkbox()
#' 
#' }
run_demo_sparkbox <- function() {
  shiny::shinyAppFile(
    appFile = system.file("examples/spark", "app.R", package = "apexcharter"),
    options = list("display.mode" = "showcase")
  )
}

# nocov end
