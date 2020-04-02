
#' @title Add a shaded area to a chart
#' 
#' @description \code{add_shade()} allow to add a shaded area on specified range,
#'  \code{add_shade_weekend()} add a shadow on every week-end.
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param from Vector of position to start shadow.
#' @param to Vector of position to end shadow.
#' @param color Color of the shadow.
#' @param opacity Opacity of the shadow.
#' @param ... Additional arguments, see
#'  \url{https://apexcharts.com/docs/options/annotations/} for possible options.
#'  
#' @note \code{add_shade_weekend} only works if variable
#'  used for x-axis is of class \code{Date} or \code{POSIXt}.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object. 
#' @export
#' 
#' @name add-shade
#'
#' @example examples/add_shade.R
add_shade <- function(ax, from, to, color = "#848484", opacity = 0.2, ...) {
  if (length(from) != length(to)) {
    stop("In add_shade: from and to must be of same length!", call. = FALSE)
  }
  len <- length(from)
  config <- list(
    x = from,
    x2 = to,
    fillColor = color,
    opacity = opacity,
    ...
  )
  config <- rapply(
    object = config, 
    f = rep_len, 
    length.out = len, 
    how = "replace"
  )
  extract <- function(el, position) {
    `[`(el, position)
  }
  xaxis <- lapply(
    X = seq_len(len),
    FUN = function(i) {
      this <- rapply(
        object = config, 
        f = extract,
        position = i, 
        how = "list"
      )
      this$x <- format_date(this$x)
      this$x2 <- format_date(this$x2)
      this
    }
  )
  if (!is.null(ax$x$ax_opts$annotations$xaxis)) {
    xaxis <- c(xaxis, ax$x$ax_opts$annotations$xaxis)
    ax$x$ax_opts$annotations$xaxis <- NULL
  }
  ax_annotations(
    ax = ax,
    position = "back",
    xaxis = xaxis
  )
}



#' @export
#' @rdname add-shade
add_shade_weekend <- function(ax, color = "#848484", opacity = 0.2, ...) {
  if (is.null(ax$x$xaxis)) {
    stop("add_shade_weekend can only be used with apex().", call. = FALSE)
  }
  if (inherits(ax$x$xaxis$min, c("Date", "POSIXt"))) {
    from <- as.Date(format(ax$x$xaxis$min, format = "%Y-%m-%d"))
    to <- as.Date(format(ax$x$xaxis$max, format = "%Y-%m-%d"))
    dates <- seq(from = from - 2, to = to + 2, by = "day")
    if (inherits(ax$x$xaxis$min, "Date")) {
      sat <- dates[format(dates, format = "%u") == 5]
      time <- "12:00:00"
    } else {
      sat <- dates[format(dates, format = "%u") == 6]
      time <- "00:00:00"
    }
    sun <- sat + 2
    ax <- add_shade(
      ax = ax, 
      from = paste(format(sat, format = "%Y-%m-%d"), time),
      to = paste(format(sun, format = "%Y-%m-%d"), time),
      color = color,
      opacity = opacity,
      ...
    )
  }
  return(ax)
}


