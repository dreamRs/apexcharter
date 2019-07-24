
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
        # as.numeric(x) * 86400000
        format(x)
      } else if (inherits(x, "POSIXt")) {
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
