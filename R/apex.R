
#' Quick Apex Chart
#'
#' @param data Default dataset to use for chart. If not already a \code{data.frame}, it will be coerced to with \code{as.data.frame}.
#' @param mapping Default list of aesthetic mappings to use for chart
#' @param type Specify the chart type. Available Options: \code{"column"}, \code{"bar"}, \code{"line"},
#'  \code{"area"}, \code{"spline"}, \code{"pie"}, \code{"donut"}, \code{"radialBar"}, \code{"scatter"}, \code{"bubble"}, \code{"heatmap"}.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @param width A numeric input in pixels.
#' @param height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#'
#' @export
#' 
#' @importFrom rlang eval_tidy as_name
#' @importFrom utils modifyList
#'
apex <- function(data, mapping, type = "column", ..., width = NULL, height = NULL, elementId = NULL) {
  type <- match.arg(type, c("column", "bar", "line", "area", "spline", "area-spline", "pie", "donut", "radialBar", "scatter", "bubble", "heatmap"))
  data <- as.data.frame(data)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  opts <- list(
    chart = list(type = correct_type(type)),
    series = make_series(mapdata, mapping, type)
  )
  opts <- modifyList(opts, choose_config(type, is_datetime(mapdata)))
  apexcharter(ax_opts = opts, width = width, height = height, elementId = elementId)
}


# Construct series
make_series <- function(mapdata, mapping, type) {
  mapdata <- as.data.frame(mapdata)
  series_names <- "Series"
  series <- list()
  if (identical(names(mapping), c("x", "y"))) {
    series_names <- rlang::as_name(mapping$y)
    series <- list(list(
      name = series_names,
      data = parse_df(mapdata, add_names = names(mapping))
    ))
  }
  if ("fill" %in% names(mapping)) {
    series <- lapply(
      X = unique(mapdata$fill),
      FUN = function(x) {
        list(
          name = x,
          data = parse_df(mapdata[mapdata$fill %in% x, ], add_names = names(mapping))
        )
      }
    )
  }
  series
}


is_datetime <- function(mapdata) {
  inherits(mapdata$x, what = c("Date", "POSIXt"))
}



# Change type of charts for helpers type
correct_type <- function(type) {
  if (identical(type, "column")) {
    "bar"
  } else if (identical(type, "spline")) {
    "line"
  } else {
    type
  }
}




# Switch between auto configs according to type & mapping
choose_config <- function(type, datetime) {
  switch(
    type, 
    "bar" = config_bar(horizontal = TRUE),
    "column" = config_bar(horizontal = FALSE),
    "line" = config_line(datetime = datetime),
    "area" = config_line(datetime = datetime),
    "spline" = config_line(curve = "smooth", datetime = datetime),
    list()
  )
}


# Config for column & bar charts
config_bar <- function(horizontal = FALSE) {
  config <- list(
    plotOptions = list(
      bar = list(
        horizontal = horizontal
      )
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
  config
}

# Config for line, spline, area, area-spline
config_line <- function(curve = "straight", datetime = FALSE) {
  config <- list(
    stroke = list(
      curve = curve
    )
  )
  if (isTRUE(datetime)) {
    config <- c(config, list(
      xaxis = list(type = "datetime")
    ))
  }
  config
}


