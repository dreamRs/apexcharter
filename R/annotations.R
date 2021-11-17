
add_annotation <- function(ax, type_annotation = c("xaxis", "yaxis", "points"),
                           as_date = FALSE, position = "back", ...) {
  type_annotation <- match.arg(type_annotation)
  config <- dropNullsOrEmpty(list(...))
  if (!is.null(config$label) && is.character(config$label)) {
    config$label <- list(text = config$label)
  }
  if (!is.null(config$marker) && is.numeric(config$marker)) {
    config$marker <- list(size = config$marker)
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
      position = position,
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
      position = position,
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
#' @return A \code{list} that can be used in \code{\link{add_shade}}, \code{\link{add_point}},
#'  \code{\link{add_event}}, \code{\link{add_event_marker}}.
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


#' Marker for annotations
#'
#' @param size Size of the marker.
#' @param fillColor Fill Color of the marker point.
#' @param strokeColor Stroke Color of the marker point.
#' @param strokeWidth Stroke Size of the marker point.
#' @param shape Shape of the marker: \code{"circle"} or \code{"square"}.
#' @param radius Radius of the marker (applies to square shape).
#' @param OffsetX Sets the left offset of the marker.
#' @param OffsetY Sets the top offset of the marker.
#' @param cssClass Additional CSS classes to append to the marker.
#'
#' @return A \code{list} that can be used in \code{\link{add_point}}.
#' @noRd
#'
marker <- function(size = NULL,
                   fillColor = NULL,
                   strokeColor = NULL,
                   strokeWidth = NULL,
                   shape = NULL,
                   radius = NULL,
                   OffsetX = NULL,
                   OffsetY = NULL,
                   cssClass = NULL) {
  dropNulls(list(
    size = size,
    fillColor = fillColor,
    strokeColor = strokeColor,
    strokeWidth = strokeWidth,
    shape = shape,
    radius = radius,
    OffsetX = OffsetX,
    OffsetY = OffsetY,
    cssClass = cssClass
  ))
}


#' @title Add a shaded area to a chart
#' 
#' @description \code{add_shade()} allow to add a shaded area on specified range,
#'  \code{add_shade_weekend()} add a shadow on every week-end.
#'
#' @template ax-default 
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
#'  
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
#' @template ax-default 
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
#'  
#' @export
#' 
#' @seealso \code{\link{add_event_marker}} to add a point.
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


#' @title Add an event marker to a chart
#' 
#' @description Add a point with a label based on a datetime.
#'
#' @param when Vector of position to place the event.
#' @inheritParams add_point
#'
#' @return An [apexchart()] `htmlwidget` object.
#' @export
#' 
#' @seealso \code{\link{add_event}} to add a vertical line.
#'
#' @example examples/add_event_marker.R
add_event_marker <- function(ax, when, y,
                             size = 5,
                             color = "#000",
                             fill = "#FFF",
                             width = 2,
                             shape = "circle", 
                             radius = 2, 
                             label = NULL, ...) {
  add_annotation(
    ax = ax, 
    type_annotation = "points", 
    position = "front",
    as_date = TRUE, 
    x = when, y = y,
    marker = marker(
      size = size, 
      fillColor = fill,
      strokeColor = color, 
      strokeWidth = width, 
      shape = shape, 
      radius = radius
    ),
    label = label,
    ...
  )
}







#' Add horizontal or vertical line
#'
#' @template ax-default 
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
#'  
#' @export
#' 
#' @name add-vh-lines
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
#' @rdname add-vh-lines
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



#' Add an annotation point
#'
#' @template ax-default 
#' @param x Coordinate(s) on the x-axis.
#' @param y Coordinate(s) on the y-axis.
#' @param size Size of the marker.
#' @param color Stroke Color of the marker point.
#' @param fill Fill Color of the marker point.
#' @param width Stroke Size of the marker point.
#' @param shape Shape of the marker: \code{"circle"} or \code{"square"}.
#' @param radius Radius of the marker (applies to square shape).
#' @param label Add a label to the shade, use a \code{character}
#'  or see \code{\link{label}} for more controls.
#' @param ... Additional arguments, see
#'  \url{https://apexcharts.com/docs/options/annotations/} for possible options.
#'
#'  
#' @export
#' 
#' @seealso \code{\link{add_event_marker}} to add a point when x-axis is a datetime.
#'
#' @example examples/add_point.R
add_point <- function(ax, x, y,
                      size = 5,
                      color = "#000",
                      fill = "#FFF",
                      width = 2,
                      shape = "circle", 
                      radius = 2, 
                      label = NULL, ...) {
  add_annotation(
    ax = ax, 
    type_annotation = "points", 
    position = "front",
    as_date = inherits(x, c("Date", "POSIXct")), 
    x = x, y = y,
    marker = marker(
      size = size, 
      fillColor = fill,
      strokeColor = color, 
      strokeWidth = width, 
      shape = shape, 
      radius = radius
    ),
    label = label,
    ...
  )
}
