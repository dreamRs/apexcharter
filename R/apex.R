
#' @title Quick ApexCharts
#' 
#' @description Initialize a chart with three main parameters :
#'  data, mapping and type of chart.
#'
#' @param data Default dataset to use for chart. If not already
#'  a \code{data.frame}, it will be coerced to with \code{as.data.frame}.
#' @param mapping Default list of aesthetic mappings to use for chart
#' @param type Specify the chart type. Available options:
#'  \code{"column"}, \code{"bar"}, 
#'  \code{"line"}, \code{"step"}, \code{"spline"},
#'  \code{"area"}, \code{"area-step"}, \code{"area-spline"}, 
#'  \code{"pie"}, \code{"donut"},
#'  \code{"radialBar"}, \code{"radar"}, \code{"scatter"},
#'  \code{"heatmap"}, \code{"treemap"}, 
#'  \code{"timeline"}.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @param auto_update In Shiny application, update existing chart
#'  rather than generating new one. Can be \code{TRUE}/\code{FALSE} or
#'  use \code{\link{config_update}} for more control.
#' @param synchronize Give a common id to charts to synchronize them (tooltip and zoom).
#' @param serie_name Name for the serie displayed in tooltip,
#'  only used for single serie.
#' @param width A numeric input in pixels.
#' @param height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#' 
#' @return A \code{apexcharts} \code{htmlwidget} object.
#'
#' @export
#' 
#' @importFrom rlang eval_tidy as_label
#' @importFrom utils modifyList
#' @importFrom stats complete.cases
#'
#' @example examples/apex.R
apex <- function(data, mapping, type = "column", ..., 
                 auto_update = TRUE,
                 synchronize = NULL,
                 serie_name = NULL,
                 width = NULL,
                 height = NULL, 
                 elementId = NULL) {
  type <- match.arg(
    arg = type, 
    choices = c(
      "column", "bar", 
      "line", "spline", "step", 
      "area", "area-spline", "area-step",
      "pie", "donut", 
      "radialBar",
      "radar", 
      "polarArea",
      "scatter", "bubble", 
      "heatmap",
      "treemap",
      "timeline",
      "candlestick"
    )
  )
  data <- as.data.frame(data)
  if (identical(type, "heatmap")) {
    mapping <- rename_aes_heatmap(mapping)
  }
  if (identical(type, "scatter") & is_sized(mapping)) {
    type <- "bubble"
  }
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  if (type %in% c("pie", "donut", "radialBar", "polarArea")) {
    opts <- list(
      chart = list(type = correct_type(type)),
      series = list1(mapdata$y),
      labels = list1(mapdata$x)
    )
  } else {
    opts <- list(
      chart = dropNulls(list(
        type = correct_type(type), 
        group = synchronize
      )),
      series = make_series(mapdata, mapping, type, serie_name)
    )
  }
  if (!is.null(synchronize)) {
    opts$yaxis$labels$minWidth <- 15
  }
  opts <- modifyList(opts, choose_config(type, mapdata))
  if (isTRUE(getOption("apex.axis.light", default = TRUE))) {
    opts$yaxis$labels$style$colors <- "#848484"
    opts$xaxis$labels$style$colors <- "#848484"
  }
  ax <- apexchart(
    ax_opts = opts, 
    width = width, 
    height = height,
    elementId = elementId, 
    auto_update = auto_update
  )
  if (inherits(mapdata$x, c("character", "Date", "POSIXt", "numeric", "integer")) & length(mapdata$x) > 0) {
    ax$x$xaxis <- list(
      min = min(mapdata$x, na.rm = TRUE),
      max = max(mapdata$x, na.rm = TRUE)
    )
  }
  ax$x$data <- data
  ax$x$mapping <- mapping
  ax$x$type <- type
  ax$x$serie_name <- serie_name
  class(ax) <- c(class(ax), "apex")
  return(ax)
}


# Construct series
make_series <- function(mapdata, mapping, type = NULL, serie_name = NULL) {
  if (identical(type, "candlestick")) {
    if (!all(c("x", "open", "high", "low", "close") %in% names(mapping)))
      stop("For candlestick charts 'x', 'open', 'high', 'low', and 'close' aesthetics must be provided.", call. = FALSE)
    if (!is.null(mapdata$group))
      warning("'group' aesthetic in candlestick chart is not supported", call. = FALSE)
    mapdata$group <- NULL
    series <- parse_candlestick_data(mapdata)
  } else if (identical(type, "rangeBar")) {
    if (!all(c("x", "start", "end") %in% names(mapping)))
      stop("For timeline charts 'x', 'start', and 'end' aesthetics must be provided.", call. = FALSE)
    if (is.null(mapdata$group))
      mapdata$group <- serie_name %||% rlang::as_label(mapping$x)
    series <- parse_timeline_data(mapdata)
  } else {
    mapdata <- as.data.frame(mapdata, stringsAsFactors = FALSE)
    if (isTRUE(type %in% c("scatter", "bubble"))) {
      complete <- complete.cases(mapdata[c("x", "y")])
      n_missing <- sum(!complete)
      if (n_missing > 0) {
        mapdata <- mapdata[complete, ]
        warning(sprintf("apex: Removed %s rows containing missing values", n_missing), call. = FALSE)
      }
    }
    if (is.character(mapdata$x))
      mapdata$x[is.na(mapdata$x)] <- "NA"
    x_order <- unique(mapdata$x)
    if (is_x_datetime(mapdata)) {
      add_names <- c("x", "y")
      x_order <- sort(x_order)
    } else {
      add_names <- names(mapping)
    }
    if (is.null(serie_name) & !is.null(mapping$y))
      serie_name <- rlang::as_label(mapping$y)
    series <- list(dropNulls(list(
      name = serie_name,
      type = multi_type(type),
      data = parse_df(mapdata, add_names = add_names)
    )))
    if (is_grouped(mapping)) {
      mapdata <- rename_aes(mapdata)
      len_grp <- tapply(mapdata$group, mapdata$group, length)
      if (length(unique(len_grp)) > 1 & !isTRUE(type %in% c("scatter", "bubble"))) {
        warning("apex: all groups must have same length! You can use `tidyr::complete` for this.")
      }
      series <- lapply(
        X = unique(mapdata$group),
        FUN = function(x) {
          data <- mapdata[mapdata$group %in% x, ]
          data <- data[, setdiff(names(data), "group"), drop = FALSE]
          data <- data[order(match(x = data[["x"]], table = x_order, nomatch = 0L)), , drop = FALSE]
          dropNulls(list(
            name = x,
            type = multi_type(type),
            data = parse_df(
              data = data, 
              add_names = add_names
            )
          ))
        }
      )
    }
  }
  series
}

is_grouped <- function(x) {
  any(c("colour", "fill", "group") %in% names(x))
}

is_sized <- function(x) {
  any(c("size", "z") %in% names(x))
}


rename_aes_heatmap <- function(mapping) {
  n_mapping <- names(mapping)
  n_mapping[n_mapping == "y"] <- "group"
  if ("fill" %in% n_mapping) {
    n_mapping[n_mapping == "fill"] <- "y"
  }
  if ("colour" %in% n_mapping) {
    n_mapping[n_mapping == "colour"] <- "y"
  }
  names(mapping) <- n_mapping
  return(mapping)
}

rename_aes <- function(mapping) {
  if ("colour" %in% names(mapping)) {
    names(mapping)[names(mapping) == "colour"] <- "group"
  }
  if ("fill" %in% names(mapping)) {
    names(mapping)[names(mapping) == "fill"] <- "group"
  }
  if ("size" %in% names(mapping)) {
    names(mapping)[names(mapping) == "size"] <- "z"
  }
  mapping
}

is_x_datetime <- function(mapdata) {
  inherits(mapdata$x, what = c("Date", "POSIXt"))
}
list1 <- function(x) {
  if (length(x) == 1) {
    list(x)
  } else {
    x
  }
}


# Change type of charts for helpers type
correct_type <- function(type) {
  if (identical(type, "column")) {
    "bar"
  } else if (isTRUE(type %in% c("spline", "step"))) {
    "line"
  } else if (isTRUE(type %in% c("area-spline", "area-step"))) {
    "area"
  } else if (identical(type, "timeline")) {
    "rangeBar"
  } else {
    type
  }
}

multi_type <- function(x) {
  multis <- c("column", "area", "line", 
              "spline", "step", "scatter", 
              "bubble")
  if (isTRUE(x %in% multis)) {
    correct_type(x)
  } else {
    NULL
  }
}

range_num <- function(x) {
  if (is.numeric(x) & length(x) > 0) {
    p <- pretty(x)
    list(
      values = p,
      n = length(p) - 1,
      range = range(p)
    )
  } else {
    NULL
  }
}




# Switch between auto configs according to type & mapping
choose_config <- function(type, mapdata) {
  datetime <- is_x_datetime(mapdata)
  range_x <- range_num(mapdata$x)
  range_y <- range_num(mapdata$y)
  switch(
    type, 
    "bar" = config_bar(horizontal = TRUE),
    "column" = config_bar(horizontal = FALSE, datetime = datetime),
    "line" = config_line(datetime = datetime),
    "area" = config_line(datetime = datetime),
    "spline" = config_line(curve = "smooth", datetime = datetime),
    "step" = config_line(curve = "stepline", datetime = datetime),
    "area-spline" = config_line(curve = "smooth", datetime = datetime),
    "area-step" = config_line(curve = "stepline", datetime = datetime),
    "scatter" = config_scatter(range_x = range_x, range_y = range_y, datetime = datetime),
    "bubble" = config_scatter(range_x = range_x, range_y = range_y, datetime = datetime),
    "timeline" = config_timeline(),
    "candlestick" = config_candlestick(),
    list()
  )
}


# Config for column & bar charts
config_bar <- function(horizontal = FALSE, datetime = FALSE) {
  config <- list(
    dataLabels = list(enabled = FALSE),
    plotOptions = list(
      bar = list(
        horizontal = horizontal
      )
    ),
    tooltip = list(
      shared = TRUE, 
      followCursor = TRUE
    )
  )
  if (isTRUE(horizontal)) {
    config <- c(config, list(
      grid = list(
        yaxis = list(lines = list(show = FALSE)),
        xaxis = list(lines = list(show = TRUE))
      )
    ))
  }
  if (isTRUE(datetime)) {
    config$xaxis$type <- "datetime"
  }
  config
}

# Config for line, spline, area, area-spline
config_line <- function(curve = "straight", datetime = FALSE) {
  config <- list(
    dataLabels = list(enabled = FALSE),
    stroke = list(
      curve = curve,
      width = 2
    ), 
    yaxis = list(
      decimalsInFloat = 2
    )
  )
  if (isTRUE(datetime)) {
    config <- c(config, list(
      xaxis = list(type = "datetime")
    ))
  }
  config
}


config_scatter <- function(range_x, range_y, datetime = FALSE) {
  config <- list(
    dataLabels = list(enabled = FALSE),
    xaxis = list(
      type = "numeric",
      min = range_x$range[1], 
      max = range_x$range[2],
      tickAmount = range_x$n,
      # labels = list(formatter = format_num("~r")),
      crosshairs = list(
        show = TRUE,
        stroke = list(dashArray = 0)
      )
    ),
    yaxis = list(
      min = range_y$range[1], 
      max = range_y$range[2],
      tickAmount = range_y$n,
      labels = list(formatter = format_num("~r")),
      tooltip = list(
        enabled = TRUE
      )
    ),
    grid = list(
      xaxis = list(
        lines = list(
          show = TRUE
        )
      )
    )
  )
  if (isTRUE(datetime)) {
    config$xaxis$type <- "datetime"
  }
  config
}

config_timeline <- function() {
  list(
    plotOptions = list(
      bar = list(
        horizontal = TRUE
      )
    ),
    xaxis = list(
      type = "datetime"
    )
  )
}

config_candlestick <- function() {
  list(
    xaxis = list(
      type = "datetime"
    )
  )
}

