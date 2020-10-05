
#' Set specific color's series
#'
#' @param ax A \code{apexcharts} \code{htmlwidget} object. 
#' @param values Named list, names represent data series, values colors to use.
#'
#' @return A \code{apexcharts} \code{htmlwidget} object.
#' @export
#'
#' @example examples/colors.R
ax_colors_manual <- function(ax, values) {
  groups <- get_groups(ax)
  values <- validate_values(values, groups)
  ax_colors(ax = ax, values$val)
}

#' @importFrom rlang is_named
validate_values <- function(values, groups) {
  if (!rlang::is_named(values))
    stop("values must be a named list or vector")
  nm <- names(values)
  val <- unname(unlist(values))
  nm_check <- setdiff(groups, nm)
  if (length(nm_check) > 0) {
    warning("Some groups doesn't have a corresponding color value")
  }
  list(
    nm = intersect(groups, nm), 
    val = val[match(x = groups, table = nm, nomatch = 0L)]
  )
}

get_groups <- function(ax) {
  if (!inherits(ax, "apexcharter"))
    stop("ax must be an apexcharter htmlwidget")
  if (is.null(ax$x$ax_opts$series))
    stop("ax must have a series of data")
  groups <- lapply(ax$x$ax_opts$series, `[[`, "name")
  groups <- unlist(groups)
  as.character(groups)
}


