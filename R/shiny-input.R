
#' Retrieve category (x-axis) in Shiny
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param inputId The id that will be used server-side for retrieveng category.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @examples
set_input_category <- function(ax, inputId) {
  ax$x$input$category <- list(
    inputId = inputId
  )
  ax
}


