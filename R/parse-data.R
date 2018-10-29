
#' @title Convert a \code{data.frame} to a \code{list}
#' 
#' @description Convert data to a format suitable for ApexCharts.js
#'
#' @param data A \code{data.frame} or an object coercible to \code{data.frame}.
#'
#' @export
#' @importFrom data.table transpose
#'
parse_df <- function(data) {
  data <- as.data.frame(data)
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
  data.table::transpose(l)
}
