
#' Add a line to a chart
#'
#' @param ax An \code{\link{apex}} \code{htmlwidget} object. 
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param data A \code{data.frame} to use to add a line, if \code{NULL} (default),
#'  the \code{data.frame} provided in \code{apex()} will be used.
#' @param type Type of line.
#' @param serie_name Name for the serie displayed in tooltip and legend.
#'
#' @return A \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @example examples/mixed-charts.R
add_line <- function(ax, mapping, data = NULL, type = c("line", "spline"), serie_name = NULL) {
  type <- match.arg(type)
  if (!inherits(ax, "apex"))
    stop("add_line: ax must have been created with apex() function.", call. = FALSE)
  if (is.null(ax$x$mixed_type)) {
    apex_type <- ax$x$ax_opts$chart$type
    ax$x$mixed_type <- apex_type
  } else {
    apex_type <- ax$x$mixed_type
  }
  if (!isTRUE(apex_type %in% c("line", "bar", "scatter")))
    stop("add_line: apex() must be a column or scatter chart.", call. = FALSE)
  ax$x$ax_opts$chart$type <- "line"
  if (is.null(data))
    data <- ax$x$data
  data <- as.data.frame(data)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  ax$x$ax_opts$series <- c(
    ax$x$ax_opts$series,
    make_series(mapdata, mapping, type, serie_name)
  )
  if (identical(apex_type, "scatter")) {
    if (is.null(ax$x$ax_opts$markers$size)) {
      ax$x$ax_opts$markers$size <- c(6, 0)
    } else {
      ax$x$ax_opts$markers$size <- c(ax$x$ax_opts$markers$size, 0)
    }
  }
  if (identical(apex_type, "bar")) {
    if (is.null(ax$x$ax_opts$stroke$width)) {
      ax$x$ax_opts$stroke$width <- c(0, 4)
    } else {
      ax$x$ax_opts$stroke$width <- c(ax$x$ax_opts$stroke$width, 4)
    }
  }
  return(ax)
}


