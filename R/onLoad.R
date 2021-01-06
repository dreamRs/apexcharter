
#' @importFrom shiny registerInputHandler
.onLoad <- function(...) { # nocov start
  shiny::registerInputHandler("apex_click", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      value <- ununlist(data$value)
      if (isTRUE(data$datetime)) {
        if (is.list(value)) {
          value <- rapply(value, to_posix, how = "replace")
        } else {
          value <- to_posix(value)
        }
      }
      return(value)
    }
  }, force = TRUE)
  shiny::registerInputHandler("apex_datetime", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
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
  register_s3_method("knitr", "knit_print", "apex_facet")
  register_s3_method("knitr", "knit_print", "apex_grid")
} # nocov end
