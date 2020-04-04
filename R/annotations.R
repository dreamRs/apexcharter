
add_annotation <- function(ax, type_annotation = c("xaxis", "yaxis", "points"),
                           as_date = FALSE, position = "back", ...) {
  type_annotation <- match.arg(type_annotation)
  config <- dropNullsOrEmpty(list(...))
  if (!is.null(config$label) && is.character(config$label)) {
    config$label <- list(text = config$label)
  }
  if (identical(type_annotation, "yaxis")) {
    len <- length(config$y)
  } else {
    len <- length(config$x)
  }
  config <- rapply(
    object = config, 
    f = rep_len, 
    length.out = len, 
    how = "replace"
  )
  extract <- function(el, index) {
    `[`(el, index)
  }
  annotations <- lapply(
    X = seq_len(len),
    FUN = function(i) {
      this <- rapply(
        object = config, 
        f = extract,
        index = i, 
        how = "list"
      )
      if (isTRUE(as_date)) {
        if (!is.null(this$x))
          this$x <- format_date(this$x)
        if (!is.null(this$x2))
          this$x2 <- format_date(this$x2)
      }
      this
    }
  )
  if (identical(type_annotation, "xaxis")) {
    if (!is.null(ax$x$ax_opts$annotations$xaxis)) {
      annotations <- c(annotations, ax$x$ax_opts$annotations$xaxis)
      ax$x$ax_opts$annotations$xaxis <- NULL
    }
    ax <- ax_annotations(
      ax = ax,
      position = "back",
      xaxis = annotations
    )
  } else if (identical(type_annotation, "yaxis")) {
    if (!is.null(ax$x$ax_opts$annotations$yaxis)) {
      annotations <- c(annotations, ax$x$ax_opts$annotations$yaxis)
      ax$x$ax_opts$annotations$yaxis <- NULL
    }
    ax <- ax_annotations(
      ax = ax,
      position = position,
      yaxis = annotations
    )
  } else if (identical(type_annotation, "points")) {
    if (!is.null(ax$x$ax_opts$annotations$points)) {
      annotations <- c(annotations, ax$x$ax_opts$annotations$points)
      ax$x$ax_opts$annotations$points <- NULL
    }
    ax <- ax_annotations(
      ax = ax,
      position = "back",
      points = annotations
    )
  }
  return(ax)
}





#' Label for annotations
#'
#' @param text Text for the annotation label.
#' @param borderColor Border color for the label.
#' @param borderWidth Border width for the label.
#' @param textAnchor The alignment of text relative to label's drawing position.
#' @param position Available options: left or right.
#' @param offsetX Sets the left offset for annotation label.
#' @param offsetY Sets the top offset for annotation label.
#' @param background Background Color for the annotation label.
#' @param color ForeColor for the annotation label.
#' @param fontSize FontSize for the annotation label.
#' @param fontWeight Font-weight for the annotation label.
#' @param fontFamily Font-family for the annotation label.
#' @param cssClass A custom Css Class to give to the annotation label elements.
#' @param padding Padding for the label: top, right, bottom, left.
#'
#' @return A \code{list} that can be used in \code{\link{add_shade}}.
#' @export
#'
label <- function(text = NULL,
                  borderColor = NULL,
                  borderWidth = NULL,
                  textAnchor = NULL,
                  position = NULL,
                  offsetX = NULL,
                  offsetY = NULL,
                  background = NULL,
                  color = NULL,
                  fontSize = NULL,
                  fontWeight = NULL,
                  fontFamily = NULL,
                  cssClass = NULL,
                  padding = c(2, 5, 2, 5)) {
  dropNulls(list(
    borderColor = borderColor,
    borderWidth = borderWidth,
    text = text,
    textAnchor = textAnchor,
    position = position,
    offsetX = offsetX,
    offsetY = offsetY,
    style = dropNulls(list(
      background = background,
      color = color,
      fontSize = fontSize,
      fontWeight = fontWeight,
      fontFamily = fontFamily,
      padding = list(
        top = padding[1],
        right = padding[2],
        bottom = padding[3],
        left = padding[4]
      )
    ))
  ))
}


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
#' @param label Add a label to the shade, use a \code{character}
#'  or see \code{\link{label}} for more controls.
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
add_shade <- function(ax, from, to, color = "#848484", opacity = 0.2, label = NULL, ...) {
  if (length(from) != length(to)) {
    stop("In add_shade: from and to must be of same length!", call. = FALSE)
  }
  add_annotation(
    ax = ax, 
    type_annotation = "xaxis", 
    as_date = TRUE, 
    x = from,
    x2 = to,
    fillColor = color,
    opacity = opacity,
    label = label,
    ...
  )
}



#' @export
#' @rdname add-shade
add_shade_weekend <- function(ax, color = "#848484", opacity = 0.2, label = NULL, ...) {
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
      label = label,
      ...
    )
  }
  return(ax)
}





#' @title Add an event to a chart
#' 
#' @description Add a vertical line to mark a special event on a chart.
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param when Vector of position to place the event.
#' @param color Color of the line.
#' @param dash Creates dashes in borders of SVG path.
#'  A higher number creates more space between dashes in the border. 
#'  Use \code{0} for plain line.
#' @param label Add a label to the shade, use a \code{character}
#'  or see \code{\link{label}} for more controls.
#' @param ... Additional arguments, see
#'  \url{https://apexcharts.com/docs/options/annotations/} for possible options.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object. 
#' @export
#'
#' @example examples/add_event.R
add_event <- function(ax, when, color = "#E41A1C", dash = 4, label = NULL, ...) {
  add_annotation(
    ax = ax, 
    type_annotation = "xaxis", 
    as_date = TRUE, 
    x = when,
    borderColor = color,
    strokeDashArray = dash,
    label = label,
    ...
  )
}






#' Add horizontal or vertical line
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object. 
#' @param value Vector of position for the line(s).
#' @param color Color(s) of the line(s). 
#' @param dash Creates dashes in borders of SVG path.
#'  A higher number creates more space between dashes in the border. 
#'  Use \code{0} for plain line.
#' @param label Add a label to the shade, use a \code{character}
#'  or see \code{\link{label}} for more controls.
#' @param ... Additional arguments, see
#'  \url{https://apexcharts.com/docs/options/annotations/} for possible options.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object. 
#' @export
#' 
#' @name add-lines
#'
#' @example examples/add-lines.R
add_hline <- function(ax, value, color = "#000", dash = 0, label = NULL, ...) {
  add_annotation(
    ax = ax, 
    type_annotation = "yaxis", 
    position = "front",
    as_date = FALSE, 
    y = value,
    borderColor = color,
    strokeDashArray = dash,
    label = label,
    ...
  )
}
#' @export
#' @rdname add-lines
add_vline <- function(ax, value, color = "#000", dash = 0, label = NULL, ...) {
  add_annotation(
    ax = ax, 
    type_annotation = "xaxis", 
    position = "front",
    as_date = FALSE, 
    x = value,
    borderColor = color,
    strokeDashArray = dash,
    label = label,
    ...
  )
}



