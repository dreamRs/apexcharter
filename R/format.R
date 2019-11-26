
#' Format numbers (with D3)
#'
#' @param format Format for numbers, currency, percentage, e.g. \code{".0\%"} for rounded percentage.
#'  See online documentation : \url{https://github.com/d3/d3-format}.
#' @param locale Localization to use, for exemple \code{"fr-FR"} for french,
#'  see possible values here: \url{https://github.com/d3/d3-format/tree/master/locale}.
#'
#' @return a \code{JS} function
#' @export
#' 
#' @importFrom htmlwidgets JS
#'
#' @example examples/format.R
format_num <- function(format, locale = "en-US") {
  check_locale(locale)
  path <- system.file(file.path("htmlwidgets/lib/d3-format/locale", paste0(locale, ".json")), package = "apexcharter")
  if (path != "") {
    locale <- paste(readLines(con = path, encoding = "UTF-8"), collapse = "")
  }
  JS(sprintf(
    "function(value) {var locale = d3.formatLocale(JSON.parse('%s')); return locale.format('%s')(value);}", 
    locale, format
  ))
}


check_locale <- function(x) {
  json <- list.files(system.file("htmlwidgets/lib/d3-format/locale", package = "apexcharter"))
  njson <- gsub("\\.json", "", json)
  if (!x %in% njson) {
    stop(paste(
      "Invalid D3 locale, must be one of:",
      paste(njson, collapse = ", ")
    ), call. = FALSE)
  }
}

