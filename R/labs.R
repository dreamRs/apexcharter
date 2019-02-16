
#' Modify axis, legend, and chart labels
#'
#' @param ax A \code{apexcharts} \code{htmlwidget} object. 
#' @param title Text for the title.
#' @param subtitle Text for the subtitle.
#' @param x Text for the x-axis label.
#' @param y Text for the y-axis label.
#'
#' @export
#' 
#' @examples 
#' meteo_paris <- data.frame(
#'   month = month.name,
#'   tmax = c(7, 8, 12, 15, 19, 23, 25, 25, 21, 16, 11, 8),
#'   tmin = c(3, 3, 5, 7, 11, 14, 16, 16, 13, 10, 6, 3)
#' )
#' 
#' apex(meteo_paris, type = "column", aes(x = month, y = tmin)) %>% 
#'   ax_labs(
#'     title = "Average minimal temperature in Paris",
#'     subtitle = "Data from NOAA",
#'     x = "Month", 
#'     y = "Temperature (°C)"
#'   )
ax_labs <- function(ax, title = NULL, subtitle = NULL, x = NULL, y = NULL) {
  if (!is.null(title)) {
    ax <- ax_title(ax = ax, text = title)
  }
  if (!is.null(subtitle)) {
    ax <- ax_subtitle(ax = ax, text = subtitle)
  }
  if (!is.null(x)) {
    ax <- ax_xaxis(ax = ax, title = list(text = x))
  } 
  if (!is.null(y)) {
    ax <- ax_yaxis(ax = ax, title = list(text = y))
  }
  ax
}





