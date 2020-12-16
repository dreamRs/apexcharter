
#' @title Convert a \code{data.frame} to a \code{list}
#' 
#' @description Convert data to a format suitable for ApexCharts.js
#'
#' @param data A \code{data.frame} or an object coercible to \code{data.frame}.
#' @param add_names Use names of columns in output. Can be logical to
#'  reuse \code{data} names or a character vector of new names.
#'  
#' @return A \code{list} that can be used to specify data in \code{\link{ax_series}} for example.
#'
#' @export
#' @importFrom stats setNames
#' 
#' @examples 
#' 
#' # All iris dataset
#' parse_df(iris)
#' 
#' # Keep variables names
#' parse_df(iris[, 1:2], add_names = TRUE)
#' 
#' # Use custom names
#' 
#' parse_df(iris[, 1:2], add_names = c("x", "y"))
#'
parse_df <- function(data, add_names = FALSE) {
  data <- as.data.frame(data)
  names_ <- names(data)
  l <- lapply(
    X = data[],
    FUN = function(x) {
      if (inherits(x, "Date")) {
        # js_date(x)
        as.numeric(x) * 1000 * 60*60*24
      } else if (inherits(x, "POSIXt")) {
        # js_date(x)
        as.numeric(x) * 1000
      } else if (inherits(x, "factor")) {
        as.character(x)
      } else {
        # if (!identical(add_names, FALSE)) {
        #   formatNoSci(x)
        # } else {
        #   x
        # }
        x
      }
    }
  )
  ll <- lapply(
    X = seq_len(nrow(data)),
    FUN = function(i) {
      res <- lapply(l, `[[`, i)
      if (identical(add_names, FALSE)) {
        res <- unname(res)
      }
      if (is.character(add_names) & length(add_names) == length(names_)) {
        res <- setNames(res, nm = add_names)
      }
      return(res)
    }
  )
  return(ll)
}



#' @importFrom htmlwidgets JS
js_date <- function(x) {
  if (inherits(x, "POSIXt"))
    x <- format(x, format = "%Y-%m-%d %H:%M:%S")
  lapply(sprintf("new Date('%s').getTime()", x), JS)
}

parse_timeline_data <- function(.list) {
  if (is.null(.list$group)) {
    lapply(
      X = seq_len(length(.list[[1]])),
      FUN = function(i) {
        val <- lapply(.list, `[[`, i)
        l <- list(
          x = as.character(val$x),
          y = js_date(c(val$start, val$end))
        )
        if (!is.null(val$fill)) {
          l$fillColor <- val$fill
        }
        l
      }
    )
  } else {
    grouped <- as.data.frame(.list, stringsAsFactors = FALSE)
    grouped$group <- NULL
    grouped <- split(
      x = grouped,
      f = .list$group
    )
    grouped <- lapply(grouped, as.list)
    lapply(
      X = names(grouped),
      FUN = function(name) {
        list(
          name = name,
          data = parse_timeline_data(grouped[[name]])
        )
      }
    )
  }
}


parse_candlestick_data <- function(.list) {
  list(list(
    type = "candlestick",
    data = lapply(
      X = seq_len(length(.list[[1]])),
      FUN = function(i) {
        val <- lapply(.list, `[[`, i)
        list(
          # x = js_date(val$x)[[1]],
          x = as.numeric(val$x) * 1000,
          y = c(val$open, val$high, val$low, val$close)
        )
      }
    )
  ))
}

