
#' @importFrom shiny registerInputHandler
.onLoad <- function(...) {
  shiny::registerInputHandler("apex_click", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      n <- names(data)
      if (!is.null(n) && all(nzchar(n))) {
        data <- lapply(
          X = data, 
          FUN = function(x) {
            n <- names(x)
            if (!is.null(n) && all(nzchar(n))) {
              lapply(x, unlist)
            } else {
              unlist(x)
            }
          }
        )
      } else {
        data <- unlist(data)
      }
      data
    }
  })
  shiny::registerInputHandler("apex_datetime", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      to_posix <- function(x) {
        if (!is.null(x)) {
          x <- as.POSIXct(x/1000, origin = "1970-01-01", tz = "UTC")
        }
        x
      }
      result <- try({
        data$x <- list(
          min = to_posix(data$x$min),
          max = to_posix(data$x$max)
        )
        data
      }, silent = TRUE)
      if (inherits(result, "try-error")) {
        warning("apexcharter: Failed to parse dates!", call. = FALSE)
        data
      } else {
        result
      }
    }
  }, force = TRUE)
}
