
#' @title Add a line to a chart
#'
#' @description Add a line to an existing chart (bar, scatter and line types supported).
#'  On scatter charts you can also add a smooth line.
#'
#' @template ax-default
#' @param mapping Default list of aesthetic mappings to use for chart.
#' @param data A \code{data.frame} to use to add a line, if \code{NULL} (default),
#'  the \code{data.frame} provided in \code{apex()} will be used.
#' @param type Type of line.
#' @param serie_name Name for the serie displayed in tooltip and legend.
#'
#' @export
#'
#' @name add-line
#'
#' @example examples/mixed-charts.R
add_line <- function(ax,
                     mapping,
                     data = NULL,
                     type = c("line", "spline"),
                     serie_name = NULL) {
  type <- match.arg(type)
  if (!inherits(ax, "apex"))
    stop("add_line: ax must have been created with apex() function.", call. = FALSE)
  if (is.null(ax$x$mixed_type)) {
    apex_type <- ax$x$ax_opts$chart$type
    ax$x$mixed_type <- apex_type
  } else {
    apex_type <- ax$x$mixed_type
  }
  if (!isTRUE(apex_type %in% c("line", "bar", "scatter", "candlestick", "rangeArea")))
    stop("add_line: apex() must be a column, scatter or candlestick chart.", call. = FALSE)
  if (!identical(apex_type, "rangeArea"))
    ax$x$ax_opts$chart$type <- "line"
  if (is.null(data))
    data <- ax$x$data
  data <- as.data.frame(data)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  ax$x$ax_opts$series <- c(
    ax$x$ax_opts$series,
    make_series(mapdata, mapping, type, serie_name, force_datetime_names = c("x", "y"))
  )
  ax$x$add_line <- list(
    data = data,
    mapping = mapping,
    type = type,
    serie_name = serie_name
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
  if (identical(apex_type, "candlestick")) {
    if (is.null(ax$x$ax_opts$stroke$width)) {
      ax$x$ax_opts$stroke$width <- c(1, 4)
    } else {
      ax$x$ax_opts$stroke$width <- c(ax$x$ax_opts$stroke$width, 4)
    }
  }
  if (identical(type, "line")) {
    ax$x$ax_opts$stroke$curve <- "straight"
  } else if (identical(type, "spline")) {
    ax$x$ax_opts$stroke$curve <- "smooth"
  }
  return(ax)
}




#' @param formula Formula passed to the \code{method}, default to \code{y ~ x} from main aesthetics.
#' @param model Model to use between \code{\link{lm}} or \code{\link{loess}}.
#' @param n Number of points used for predictions.
#' @param ... Arguments passed to \code{model}.
#'
#' @export
#'
#' @importFrom stats lm loess predict
#' @importFrom rlang !! sym
#'
#' @name add-line
add_smooth_line <- function(ax,
                            formula = y ~ x,
                            model = c("lm", "loess"),
                            n = 100,
                            ...,
                            type = c("line", "spline"),
                            serie_name = NULL) {
  model <- match.arg(model)
  type <- match.arg(type)
  if (!inherits(ax, "apex"))
    stop("add_smooth_line: ax must have been created with apex() function.", call. = FALSE)
  if (is.null(ax$x$mixed_type)) {
    apex_type <- ax$x$ax_opts$chart$type
    ax$x$mixed_type <- apex_type
  } else {
    apex_type <- ax$x$mixed_type
  }
  if (!isTRUE(apex_type %in% c("scatter")))
    stop("add_smooth_line: apex() must be a scatter chart.", call. = FALSE)
  ax$x$ax_opts$chart$type <- "line"
  data <- as.data.frame(ax$x$data)
  mapping <- ax$x$mapping
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  if (identical(model, "lm")) {
    model_results <- lm(formula = formula, data = mapdata, ...)
  } else if (identical(model, "loess")) {
    model_results <- loess(formula = formula, data = mapdata, ...)
  }
  new_data <- data.frame(x = seq(
    from = min(mapdata$x, na.rm = TRUE),
    to = max(mapdata$x, na.rm = TRUE),
    length.out = n
  ))
  new_data$smooth <- predict(model_results, new_data)
  add_line(
    ax = ax,
    mapping = aes(x = `!!`(sym("x")), y = `!!`(sym("smooth"))),
    data = new_data,
    type = type,
    serie_name = serie_name
  )
}



