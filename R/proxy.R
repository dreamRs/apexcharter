
#' @title Proxy for \code{apexchart}
#' 
#' @description Allow to update a chart in Shiny application.
#'
#' @param shinyId single-element character vector indicating the output ID of the
#'   chart to modify (if invoked from a Shiny module, the namespace will be added
#'   automatically)
#' @param session the Shiny session object to which the chart belongs; usually the
#'   default value will suffice 
#'
#' @export
#'
apexchartProxy <- function(shinyId, session = shiny::getDefaultReactiveDomain()) {
  
  if (is.null(session)) {
    stop("apexchartProxy must be called from the server function of a Shiny app")
  }
  
  if (!is.null(session$ns) && nzchar(session$ns(NULL)) && substring(shinyId, 1, nchar(session$ns(""))) != session$ns("")) {
    shinyId <- session$ns(shinyId)
  }
  
  structure(
    list(
      session = session,
      id = shinyId,
      x = list()
    ),
    class = "apexchart_Proxy"
  )
}


#' Call a proxy method
#'
#' @param proxy  A \code{apexchartProxy} \code{htmlwidget} object.
#' @param name Proxy method.
#' @param ... Arguments passed to method.
#'
#' @return A \code{apexchartProxy} \code{htmlwidget} object.
#' @noRd
.ax_proxy <- function(proxy, name, ...) {
  if (!"apexchart_Proxy" %in% class(proxy)) 
    stop("This function must be used with a apexchartProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("update-apexchart-%s", name),
    message = list(id = proxy$id, data = list(...))
  )
  proxy
}
.ax_proxy2 <- function(proxy, name, l) {
  if (!"apexchart_Proxy" %in% class(proxy)) 
    stop("This function must be used with a apexchartProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("update-apexchart-%s", name),
    message = list(id = proxy$id, data = l)
  )
  proxy
}




#' @title Proxy for updating series. 
#' 
#' @description Allows you to update the series array overriding the existing one. 
#'
#' @param proxy A \code{apexchartProxy} \code{htmlwidget} object.
#' @param newSeries The series array to override the existing one.
#' @param animate Should the chart animate on re-rendering.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' if (interactive()) {
#' 
#' 
#' 
#' }
#' 
#' }
ax_proxy_series <- function(proxy, newSeries, animate = TRUE) {
  .ax_proxy2(
    proxy = proxy, 
    name = "series", 
    l = list(newSeries = list(newSeries), animate = animate)
  )
}




