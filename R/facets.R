
#' @importFrom rlang eval_tidy
get_facets <- function(data, vars) {
  byvars <- lapply(X = vars, FUN = eval_tidy, data = data)
  split(x = data, f = byvars, sep = "|__|")
}

#' @importFrom rlang eval_tidy
buil_facets <- function(chart, data, vars, mapping, type, serie_name, height) {
  facets_data <- get_facets(data, vars)
  lapply(
    X = seq_along(facets_data),
    FUN = function(i) {
      new <- chart
      mapdata <- lapply(mapping, eval_tidy, data = facets_data[[i]])
      new$x$ax_opts$series <- make_series(mapdata, mapping, type, serie_name)
      new$x$facet <- NULL
      new$height <- height
      class(new) <- setdiff(class(new), "apex_facet")
      return(new)
    }
  )
}

build_grid <- function(content, nrow = NULL, ncol = NULL, col_gap = "0px", row_gap = "0px") {
  n <- length(content)
  if (is.null(nrow) & !is.null(ncol))
    nrow <- ceiling(n / ncol)
  if (!is.null(nrow) & is.null(ncol))
    ncol <- ceiling(n / nrow)
  if (is.null(nrow) & is.null(ncol)) {
    if (n %% 3 < 1) {
      ncol <- 3
      nrow <- ceiling(n / ncol)
    } else {
      ncol <- 2
      nrow <- ceiling(n / ncol)
    } 
  }
  htmltools::tags$div(
    style = "display: grid;",
    style = sprintf("grid-template-columns: repeat(%s, 1fr);", ncol),
    style = sprintf("grid-template-rows: repeat(%s, 1fr);", nrow),
    style = sprintf("grid-column-gap: %s;", col_gap),
    style = sprintf("grid-row-gap: %s;", row_gap),
    content
  )
}


#' @export
print.apex_facet <- function(x, ...) {
  facets_charts <- buil_facets(
    chart = x,
    data = x$x$data, 
    vars = x$x$facet$vars, 
    mapping = x$x$mapping,
    type = x$x$type, 
    serie_name = x$x$serie_name, 
    height = x$x$facet$chart_height
  )
  TAG <- build_grid(facets_charts, nrow = x$x$facet$nrow, ncol = x$x$facet$ncol)
  print(str(TAG, max.level = 1))
  print(htmltools::browsable(TAG))
}


#' Facet wrap for ApexCharts
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object.
#' @param vars Variable(s) to use for facetting, wrapped in \code{vars(...)}.
#' @param nrow,ncol Number of row and column in output matrix.
#' @param chart_height Individual chart height.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @examples
ax_facet_wrap <- function(ax, vars, nrow = NULL, ncol = NULL, chart_height = "300px") {
  if (!inherits(ax, "apex"))
    stop("ax_facet_wrap only works with charts generated with apex()", call. = FALSE)
  ax$x$facet <- list(
    vars = vars,
    nrow = nrow,
    ncol = ncol,
    chart_height = chart_height
  )
  class(ax) <- c("apex_facet", class(ax))
  return(ax)
}

