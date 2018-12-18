
#' @title Convert a \code{data.frame} to a \code{list}
#' 
#' @description Convert data to a format suitable for ApexCharts.js
#'
#' @param data A \code{data.frame} or an object coercible to \code{data.frame}.
#' @param add_names Use names of columns in output. Can be logical to
#'  reuse \code{data} names or a character vector of new names.
#'
#' @export
#' @importFrom data.table transpose
#' @importFrom stats setNames
#'
parse_df <- function(data, add_names = FALSE) {
  data <- as.data.frame(data)
  names_ <- names(data)
  l <- lapply(
    X = data[],
    FUN = function(x) {
      if (inherits(x, "Date")) {
        as.numeric(x) * 86400000
      } else if (inherits(x, "POSIXt")) {
        as.numeric(x)
      } else if (inherits(x, "factor")) {
        as.character(x)
      } else {
        x
      }
    }
  )
  ll <- data.table::transpose(l)
  if (isTRUE(add_names)) {
    ll <- lapply(ll, as.list)
    ll <- lapply(ll, setNames, nm = names_)
  }
  if (is.character(add_names) & length(add_names) == length(names_)) {
    ll <- lapply(ll, as.list)
    ll <- lapply(ll, setNames, nm = add_names)
  }
  return(ll)
}
