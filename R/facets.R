
#' @importFrom rlang eval_tidy
get_facets <- function(data, vars) {
  byvars <- lapply(X = vars, FUN = eval_tidy, data = data)
  facets <- split(x = data, f = byvars, sep = "|__|")
  lapply(
    X = seq_along(facets),
    FUN = function(i) {
      facet <- facets[[i]]
      attr(facet, "keys") <- strsplit(x = names(facets)[i], split = "|__|", fixed = TRUE)
      facet
    }
  )
}

#' @importFrom rlang eval_tidy is_null is_function
buil_facets <- function(chart, data, facets_args, mapping, type, serie_name) {
  labeller <- facets_args$labeller
  facets_data <- get_facets(data, facets_args$vars)
  lapply(
    X = seq_along(facets_data),
    FUN = function(i) {
      new <- chart
      facet <- facets_data[[i]]
      if (!is_null(labeller) && is_function(labeller)) {
        keys <- attr(facet, "keys")
        # browser()
        new <- ax_title(new, text = labeller(keys))
      }
      mapdata <- lapply(mapping, eval_tidy, data = facet)
      new$x$ax_opts$series <- make_series(mapdata, mapping, type, serie_name)
      new$x$facet <- NULL
      new$height <- facets_args$chart_height
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
    class = "apexcharter-facet-container",
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
    mapping = x$x$mapping,
    type = x$x$type, 
    serie_name = x$x$serie_name, 
    facets_args = x$x$facet
  )
  TAG <- build_grid(facets_charts, nrow = x$x$facet$nrow, ncol = x$x$facet$ncol)
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
ax_facet_wrap <- function(ax, 
                          vars, 
                          nrow = NULL,
                          ncol = NULL,
                          labeller = ggplot2::label_value,
                          chart_height = "300px") {
  if (!inherits(ax, "apex"))
    stop("ax_facet_wrap only works with charts generated with apex()", call. = FALSE)
  ax$x$facet <- list(
    vars = vars,
    nrow = nrow,
    ncol = ncol,
    labeller = labeller,
    chart_height = chart_height
  )
  class(ax) <- c("apex_facet", class(ax))
  return(ax)
}

