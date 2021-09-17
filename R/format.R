
#' Format numbers (with D3)
#'
#' @param format Format for numbers, currency, percentage, e.g. \code{".0\%"} for rounded percentage.
#'  See online documentation : \url{https://github.com/d3/d3-format}.
#' @param prefix Character string to append before formatted value.
#' @param suffix Character string to append after formatted value.
#' @param locale Localization to use, for example \code{"fr-FR"} for french,
#'  see possible values here: \url{https://github.com/d3/d3-format/tree/master/locale}.
#'
#' @return a \code{JS} function
#' @export
#'
#' @importFrom htmlwidgets JS
#'
#' @example examples/format.R
format_num <- function(format, prefix = "", suffix = "", locale = "en-US") {
  check_locale_d3(locale)
  path <- system.file(file.path("d3-format-locale", paste0(locale, ".json")), package = "apexcharter")
  if (path != "") {
    locale <- paste(readLines(con = path, encoding = "UTF-8"), collapse = "")
  }
  JS(sprintf(
    "function(value) {var locale = formatLocale(JSON.parse('%s')); return '%s' + locale.format('%s')(value) + '%s';}",
    locale, prefix, format, suffix
  ))
}


check_locale_d3 <- function(x) {
  json <- list.files(system.file("d3-format-locale", package = "apexcharter"))
  njson <- gsub("\\.json", "", json)
  if (!x %in% njson) {
    stop(paste(
      "Invalid D3 locale, must be one of:",
      paste(njson, collapse = ", ")
    ), call. = FALSE)
  }
}





#' Format date in JS
#'
#' @param x Date to use in JavaScript
#'
#' @return a JavaScript string
#' @export
#'
format_date <- function(x) {
  stopifnot(length(x) == 1)
  JS(sprintf("new Date('%s').getTime()", x))
}









