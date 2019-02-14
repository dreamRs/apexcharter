
#' @title Convert a \code{data.frame} to a \code{list}
#' 
#' @description Convert data to a format suitable for ApexCharts.js
#'
#' @param data A \code{data.frame} or an object coercible to \code{data.frame}.
#' @param add_names Use names of columns in output. Can be logical to
#'  reuse \code{data} names or a character vector of new names.
#'
#' @export
#' @importFrom stats setNames
#'
parse_df <- function(data, add_names = FALSE) {
  data <- as.data.frame(data)
  names_ <- names(data)
  l <- lapply(
    X = data[],
    FUN = function(x) {
      if (inherits(x, "Date") & identical(add_names, FALSE)) {
        as.numeric(x) * 86400000
      } else if (inherits(x, "POSIXt") & identical(add_names, FALSE)) {
        as.numeric(x)
      } else if (inherits(x, "factor")) {
        as.character(x)
      } else {
        if (!identical(add_names, FALSE)) {
          formatNoSci(x)
        } else {
          x
        }
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
