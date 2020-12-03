
null_or_empty <- function(x) {
  is.null(x) || length(x) == 0
}


dropNullsOrEmpty <- function(x) {
  x[!vapply(x, null_or_empty, FUN.VALUE = logical(1))]
}

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

`%||%` <- function(x, y) {
  if (!is.null(x)) x else y
}

formatNoSci <- function(x) {
  if (is.null(x)) return(NULL)
  format(x, scientific = FALSE, digits = 15)
}


ununlist <- function(x) {
  if (is.null(x))
    return(x)
  n <- names(x)
  if (!is.null(n) && all(nzchar(n))) {
    lapply(x, ununlist)
  } else {
    unlist(x)
  }
}


to_posix <- function(x) {
  if (!is.null(x)) {
    x <- as.POSIXct(x/1000, origin = "1970-01-01", tz = "UTC")
  }
  x
}



#' Utility function to create ApexChart parameters JSON
#'
#' @param ax A \code{apexcharts} \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param ... Arguments for the slot
#'
#' @return A \code{apexcharts} \code{htmlwidget} object.
#' 
#' @importFrom utils modifyList
#'
#' @noRd
.ax_opt <- function(ax, name, ...) {
  
  if (is.null(ax$x$ax_opts[[name]])) {
    ax$x$ax_opts[[name]] <- list(...)
  } else {
    ax$x$ax_opts[[name]] <- utils::modifyList(
      x = ax$x$ax_opts[[name]], 
      val = list(...), 
      keep.null = TRUE
    )
  }
  
  return(ax)
}

#' Utility function to create ApexChart parameters JSON
#'
#' @param ax A \code{apexcharts} \code{htmlwidget} object.
#' @param name Slot's name to edit
#' @param l List of arguments for the slot
#'
#' @return A \code{apexcharts} \code{htmlwidget} object.
#'
#' @noRd
.ax_opt2 <- function(ax, name, l) {
  
  if (is.null(ax$x$ax_opts[[name]])) {
    ax$x$ax_opts[[name]] <- l
  } else {
    ax$x$ax_opts[[name]] <- utils::modifyList(
      x = ax$x$ax_opts[[name]], 
      val = l, 
      keep.null = TRUE
    )
  }
  
  return(ax)
}

# Get parameters from an \code{apexcharts} \code{htmlwidget} object.
.get_ax_opt <- function(ax, name) {
  ax$x$ax_opts[[name]]
}



# From vignette('knit_print', package = 'knitr')
# and https://github.com/rstudio/htmltools/pull/108/files

register_s3_method <- function(pkg, generic, class, fun = NULL) { # nocov start
  stopifnot(is.character(pkg), length(pkg) == 1)
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)
  
  if (is.null(fun)) {
    fun <- get(paste0(generic, ".", class), envir = parent.frame())
  } else {
    stopifnot(is.function(fun))
  }
  
  if (pkg %in% loadedNamespaces()) {
    registerS3method(generic, class, fun, envir = asNamespace(pkg))
  }
  
  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
} # nocov end
