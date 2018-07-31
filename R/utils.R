

# dropNulls
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


`%||%` <- function(x, y) {
  if (!is.null(x)) x else y
}



#' Utility function to create ApexChart parameters JSON
#'
#' @param ax A \code{apexchart} \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param ... Arguments for the slot
#'
#' @return A \code{apexchart} \code{htmlwidget} object.
#' 
#' @importFrom utils modifyList
#'
#' @noRd
.ax_opt <- function(ax, name, ...) {
  
  if(!any(class(ax) %in% c("apexcharter", "apexcharter_Proxy"))){
    stop("ax must be a apexcharter or a apexcharterProxy object")
  }
  
  if (is.null(ax$x$ax_opts[[name]])) {
    ax$x$ax_opts[[name]] <- list(...)
  } else {
    ax$x$ax_opts[[name]] <- utils::modifyList(x = ax$x$ax_opts[[name]], val = list(...), keep.null = TRUE)
  }
  
  return(ax)
}

#' Utility function to create ApexChart parameters JSON
#'
#' @param ax A \code{apexchart} \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param l List of arguments for the slot
#'
#' @return A \code{apexchart} \code{htmlwidget} object.
#'
#' @noRd
.ax_opt2 <- function(ax, name, l) {
  
  if (is.null(ax$x$ax_opts[[name]])) {
    ax$x$ax_opts[[name]] <- l
  } else {
    ax$x$ax_opts[[name]] <- utils::modifyList(x = ax$x$ax_opts[[name]], val = l, keep.null = TRUE)
  }
  
  return(ax)
}


