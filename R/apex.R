
#' @title Quick ApexChart
#' 
#' @description Initialize a chart with three main parameters : data, mapping and type of chart.
#'
#' @param data Default dataset to use for chart. If not already a \code{data.frame}, it will be coerced to with \code{as.data.frame}.
#' @param mapping Default list of aesthetic mappings to use for chart
#' @param type Specify the chart type. Available Options: \code{"column"}, \code{"bar"}, \code{"line"},
#'  \code{"area"}, \code{"spline"}, \code{"pie"}, \code{"donut"}, \code{"radialBar"}, \code{"radar"}, \code{"scatter"}, \code{"heatmap"}.
#' @param ... Other arguments passed on to methods. Not currently used.
#' @param auto_update In Shiny application, update existing chart rather than generating new one.
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
#'
#' @example examples/apex.R
apex <- function(data, mapping, type = "column", ..., auto_update = TRUE, width = NULL, height = NULL, elementId = NULL) {
  type <- match.arg(type, c("column", "bar", "line", "area", "spline", "area-spline",
                            "pie", "donut", "radialBar", "radar", "scatter", "heatmap",
                            "rangeBar"))
  data <- as.data.frame(data)
  if (identical(type, "heatmap")) {
    mapping <- rename_aes_heatmap(mapping)
  }
  mapdata <- lapply(mapping, rlang::eval_tidy, data = data)
  if (type %in% c("pie", "donut", "radialBar")) {
    opts <- list(
      chart = list(type = correct_type(type)),
      series = list1(mapdata$y),
      labels = list1(mapdata$x)
    )
  } else {
    opts <- list(
      chart = list(type = correct_type(type)),
      series = make_series(mapdata, mapping, type)
    )
  }
  opts <- modifyList(opts, choose_config(type, mapdata))
  apexchart(
    ax_opts = opts, width = width, height = height,
    elementId = elementId, auto_update = auto_update
  )
}


# Construct series
make_series <- function(mapdata, mapping, type) {
  mapdata <- as.data.frame(mapdata)
  series_names <- "Series"
  if (is_x_datetime(mapdata)) {
    add_names <- FALSE
  } else {
    add_names <- names(mapping)
  }
  if (!is.null(mapping$y))
    series_names <- rlang::as_label(mapping$y)
  series <- list(list(
    name = series_names,
    data = parse_df(mapdata, add_names = add_names)
  ))
  if (is_grouped(names(mapping))) {
    mapdata <- rename_aes(mapdata)
    series <- lapply(
      X = unique(mapdata$group),
      FUN = function(x) {
        data <- mapdata[mapdata$group %in% x, ]
        data <- data[, setdiff(names(data), "group"), drop = FALSE]
        list(
          name = x,
          data = parse_df(
            data = data, 
            add_names = add_names
          )
        )
      }
    )
  }
  series
}

is_grouped <- function(x) {
  any(c("colour", "fill", "group") %in% x)
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
  } else if (identical(type, "spline")) {
    "line"
  } else {
    type
  }
}

range_num <- function(x) {
  if (is.numeric(x)) {
    range(pretty(x))
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
    "column" = config_bar(horizontal = FALSE),
    "line" = config_line(datetime = datetime),
    "area" = config_line(datetime = datetime),
    "spline" = config_line(curve = "smooth", datetime = datetime),
    "scatter" = config_scatter(range_x = range_x, range_y = range_y),
    list()
  )
}


# Config for column & bar charts
config_bar <- function(horizontal = FALSE) {
  config <- list(
    dataLabels = list(enabled = FALSE),
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
    dataLabels = list(enabled = FALSE),
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


config_scatter <- function(range_x, range_y) {
  config <- list(
    xaxis = list(
      min = range_x[1], max = range_x[2]
    ),
    yaxis = list(
      min = range_y[1], max = range_y[2]
    )
  )
}



