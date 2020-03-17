
#' @title Retrieve click information in Shiny
#' 
#' @description According to type of chart, different values are retrieved:
#'  * **bar and column:** retrieve category (x-axis).
#'  * **pie and donut:** retrieve label.
#'  * **time-series:** retrieve x-axis value, you have to display markers
#'   with size > 0 and set tooltip's options `intersect = TRUE` and `shared = FALSE`.
#'  * **scatter:** retrieve XY coordinates.
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param inputId The id that will be used server-side for retrieving click.
#' @param multiple Allow multiple selection: \code{TRUE} or \code{FALSE} (default).
#' @param effect_type Type of effect for selected element, default is to use lightly darken color.
#' @param effect_value A larger value intensifies the select effect, accept value between 0 and 1.
#' @param session The Shiny session.
#' 
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#' 
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_input_demo("click")
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
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param inputId The id that will be used server-side for retrieving click.
#' @param session The Shiny session.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#' 
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_input_demo("zoom")
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







#' Run Shiny input events examples
#'
#' @param example NAme of the example.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#' 
#'   run_input_demo()
#' 
#' }
run_input_demo <- function(example = c("click", "zoom")) {
  example <- match.arg(example)
  shiny::shinyAppFile(
    appFile = system.file("examples-input", example, "app.R", package = "apexcharter"),
    options = list("display.mode" = "showcase")
  )
}







