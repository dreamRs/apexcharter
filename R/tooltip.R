
#' Fixed tooltip
#'
#' @template ax-default
#' @param position Predefined position: \code{"topLeft"}, \code{"topRight"},
#'  \code{"bottomLeft"} or \code{"bottomRight"}.
#' @param offsetX Sets the left offset for the tooltip container in fixed position.
#' @param offsetY Sets the top offset for the tooltip container in fixed position.
#'
#' @export
#'
#' @example examples/set_tooltip_fixed.R
set_tooltip_fixed <- function(ax, 
                              position = c("topLeft", "topRight", "bottomLeft", "bottomRight"),
                              offsetX = NULL, 
                              offsetY = NULL) {
  position <- match.arg(position)
  ax_tooltip(ax = ax, fixed = list(
    enabled = TRUE, position = position,
    offsetX = offsetX, offsetY = offsetY
  ))
}
