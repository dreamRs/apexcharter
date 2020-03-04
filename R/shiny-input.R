
#' Retrieve category (x-axis) in Shiny
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param inputId The id that will be used server-side for retrieveng category.
#' @param multiple Allow multiple selection: \code{TRUE} or \code{FALSE} (default).
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @examples
set_input_category <- function(ax, inputId, multiple = FALSE) {
  if (isTRUE(multiple)) {
    ax <- ax_states(ax, active = list(
      allowMultipleDataPointsSelection = TRUE
    ))
  }
  ax$x$input$category <- list(
    inputId = inputId
  )
  ax
}


