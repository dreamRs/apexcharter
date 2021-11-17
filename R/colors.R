
#' Set specific color's series
#'
#' @template ax-default 
#' @param values Named list, names represent data series, values colors to use.
#'
#' @export
#'
#' @example examples/colors.R
ax_colors_manual <- function(ax, values) {
  if (!inherits(ax, "apexcharter"))
    stop("ax_colors_manual: ax must be an apexcharter object", call. = FALSE)
  ax$x$colors_manual <- values
  ax$x$ax_opts$colors <- NULL
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
    stop("ax must have a serie of data")
  groups <- lapply(ax$x$ax_opts$series, `[[`, "name")
  groups <- unlist(groups)
  as.character(groups)
}



