
#' @importFrom rlang eval_tidy
get_facets <- function(data, rows, cols, type = c("wrap", "grid")) {
  type <- match.arg(type)
  byrows <- lapply(X = rows, FUN = eval_tidy, data = data)
  bycols <- lapply(X = cols, FUN = eval_tidy, data = data)
  facets <- split(x = data, f = c(bycols, byrows), sep = "|__|")
  facets <- lapply(
    X = seq_along(facets),
    FUN = function(i) {
      facet <- facets[[i]]
      attr(facet, "keys") <- strsplit(
        x = names(facets)[i],
        split = "|__|", fixed = TRUE
      )[[1]]
      facet
    }
  )
  label_row <- lapply(byrows, unique)
  label_row <- lapply(label_row, sort)
  label_row <- apply(expand.grid(label_row), 1, paste, collapse = "*")
  label_col <- lapply(bycols, unique)
  label_col <- lapply(label_col, sort)
  label_col <- apply(expand.grid(label_col), 1, paste, collapse = "*")
  list(
    facets = facets,
    nrow = if (identical(type, "grid")) n_facet(byrows) else NULL,
    ncol = if (identical(type, "grid")) n_facet(bycols) else NULL,
    label_row = label_row,
    label_col = label_col
  )
}

n_facet <- function(l) {
  l <- lapply(l, function(x) {
    length(unique(x))
  })
  Reduce(`*`, l)
}

#' @importFrom rlang %||% is_list is_named
set_scale <- function(ax, values, scales = c("fixed", "free", "free_y", "free_x"), axis = c("x", "y", "y2")) {
  if (is.null(scales))
    return(ax)
  scales <- match.arg(scales)
  axis <- match.arg(axis)
  if (identical(axis, "y2")) {
    axis <- "y"
    wyaxis <- 2
  } else {
    wyaxis <- 1
  }
  if (is.null(values))
    return(ax)
  
  if (inherits(values, c("numeric", "integer", "Date", "POSIXt"))) {
    range_vals <- range(pretty(values, n = 10), na.rm = TRUE)
  } else {
    range_vals <- NULL
  }
  
  waxis <- switch(
    axis,
    "x" = "xaxis",
    "y" = "yaxis"
  )
  
  this_axis <- ax$x$ax_opts[[waxis]]
  if (inherits(this_axis, "yaxis2")) {
    ax$x$ax_opts[[waxis]][[wyaxis]] <- set_scale_axis(
      this_axis[[wyaxis]], 
      range_vals = range_vals,
      scales = scales, 
      axis = axis
    )
    # ax$x$ax_opts[[waxis]][[2]] <- set_scale_axis(
    #   this_axis[[2]],
    #   range_vals = range_vals, 
    #   scales = scales,
    #   axis = axis
    # )
  } else {
    ax$x$ax_opts[[waxis]] <- set_scale_axis(
      this_axis,
      range_vals = range_vals,
      scales = scales, 
      axis = axis
    )
  }
  
  return(ax)
}


scale_fmt <- function(x, time = inherits(x, c("Date", "POSIXt"))) {
  if (is.null(x))
    return(NULL)
  if (time)
    x <- format_date(x)
  x
}


set_scale_axis <- function(this_axis,
                           range_vals, 
                           scales = c("fixed", "free", "free_y", "free_x"),
                           axis = c("x", "y")) {
  scales <- match.arg(scales)
  axis <- match.arg(axis)
  if (scales == "fixed") {
    this_axis$min <- this_axis$min %||% scale_fmt(range_vals[1])
    this_axis$max <- this_axis$max %||% scale_fmt(range_vals[2])
  } else if (scales == "free") {
    this_axis$min <- NULL
    this_axis$max <- NULL
  } else if (scales == "free_x") {
    if (axis == "y") {
      this_axis$min <- this_axis$min %||% scale_fmt(range_vals[1])
      this_axis$max <- this_axis$max %||% scale_fmt(range_vals[2])
    } else {
      this_axis$min <- NULL
      this_axis$max <- NULL
    }
  } else if (scales == "free_y") {
    if (axis == "x") {
      this_axis$min <- this_axis$min %||% scale_fmt(range_vals[1])
      this_axis$max <- this_axis$max %||% scale_fmt(range_vals[2])
    } else {
      this_axis$min <- NULL
      this_axis$max <- NULL
    }
  }
  return(this_axis)
}


get_option <- function(ax, opt1, opt2 = NULL) {
  if (is.null(opt2)) {
    ax$x$ax_opts[[opt1]]
  } else {
    ax$x$ax_opts[[opt1]][[opt2]]
  }
}
remove_option <- function(ax, opt1, opt2 = NULL) {
  if (is.null(opt2)) {
    ax$x$ax_opts[[opt1]] <- NULL
  } else {
    ax$x$ax_opts[[opt1]][[opt2]] <- NULL
  }
  ax
}


get_yaxis_serie <- function(ax, which = 1) {
  series <- ax$x$ax_opts$series
  yaxis <- ax$x$ax_opts$yaxis
  if (inherits(yaxis, c("yaxis", "yaxis2"))) {
    yaxis <- yaxis[[which]]
    name <- yaxis$serieName
    if (!is.null(name)) {
      series_names <- vapply(series, FUN = `[[`, "name", FUN.VALUE = character(1))
      indice <- which(name == series_names)
    } else {
      indice <- which
    }
    unlist(lapply(series[[indice]]$data, FUN = `[[`, "y"))
  } else {
    unlist(lapply(
      X = seq_along(series), 
      FUN = function(indice) {
        unlist(lapply(series[[indice]]$data, FUN = `[[`, "y"))
      }
    ))
  }
}


has_yaxis2 <- function(ax) {
  inherits(ax$x$ax_opts$yaxis, "yaxis2")
}
