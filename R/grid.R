
get_grid_dims <- function(content, nrow = NULL, ncol = NULL) {
  n <- length(content)
  if (is.null(nrow) & !is.null(ncol))
    nrow <- ceiling(n / ncol)
  if (!is.null(nrow) & is.null(ncol))
    ncol <- ceiling(n / nrow)
  if (is.null(nrow) & is.null(ncol)) {
    if (n %% 3 < 1) {
      ncol <- 3
      nrow <- ceiling(n / ncol)
    } else {
      ncol <- 2
      nrow <- ceiling(n / ncol)
    }
  }
  list(nrow = nrow, ncol = ncol)
}


#' @importFrom htmltools tags css
build_grid <- function(content,
                       nrow = NULL,
                       ncol = NULL,
                       row_gap = "5px",
                       col_gap = "0px",
                       row_before = NULL,
                       row_after = NULL,
                       col_before = NULL,
                       col_after = NULL,
                       height = NULL,
                       width = NULL) {
  d <- get_grid_dims(content, nrow, ncol)
  tags$div(
    class = "apexcharter-grid-container",
    style = css(
      height = height,
      width = width,
      display = "grid",
      gridTemplateColumns = paste(col_before, sprintf("repeat(%s, 1fr)", d$ncol), col_after),
      gridTemplateRows = paste(row_before, sprintf("repeat(%s, 1fr)", d$nrow), row_after),
      gridColumnGap = col_gap,
      gridRowGap = row_gap
    ),
    content
  )
}



#' Create a grid of ApexCharts
#'
#' @param ... Several \code{apexcharts} \code{htmlwidget} objects.
#' @param nrow,ncol Number of rows and columns.
#' @param row_gap,col_gap Gap between rows and columns.
#' @param grid_area Custom grid area to make elements take more than a single
#'  cell in grid, see \url{https://cssgrid-generator.netlify.app/} for examples.
#' @param height,width Height and width of the main grid.
#' @param .list A list of \code{apexcharts} \code{htmlwidget} objects.
#'
#' @return Custom \code{apex_grid} object.
#'
#' @note You have to provide either height for the grid or individual chart height to make it work.
#'
#' @export
#'
#' @importFrom htmltools tags
#'
#' @example examples/apex_grid.R
apex_grid <- function(...,
                      nrow = NULL,
                      ncol = NULL,
                      row_gap = "10px",
                      col_gap = "0px",
                      grid_area = NULL,
                      height = NULL,
                      width = NULL,
                      .list = NULL) {
  content <- c(list(...), .list)
  if (!is.null(grid_area)) {
    stopifnot(length(grid_area) == length(content))
    content <- lapply(
      X = seq_along(content),
      FUN = function(i) {
        tags$div(
          style = paste0("grid-area:", grid_area[i]),
          content[i]
        )
      }
    )
  }
  grid <- list(
    content = content,
    nrow = nrow,
    ncol = ncol,
    col_gap = col_gap,
    row_gap = row_gap,
    height = height,
    width = width
  )
  class(grid) <- c("apex_grid", class(grid))
  return(grid)
}



# Shiny -------------------------------------------------------------------


#' @title Shiny bindings for grid with apexcharter
#'
#' @description Output and render functions for using apexcharter grid within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#'
#' @return An Apexcharts output that can be included in the application UI.
#' @export
#'
#' @name apexcharter-shiny-grid
#'
#' @importFrom htmltools tagList
#' @importFrom shiny uiOutput
#' @importFrom htmlwidgets getDependency
#'
#' @example examples/grid-shiny.R
apexgridOutput <- function(outputId) {
  tagList(
    uiOutput(outputId = outputId),
    getDependency(name = "apexcharter", package = "apexcharter")
  )
}

#' @param expr An expression that generates a apexcharter grid.
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @export
#'
#' @rdname apexcharter-shiny-grid
#'
#' @importFrom shiny exprToFunction createRenderFunction createWebDependency
#' @importFrom htmltools renderTags resolveDependencies
renderApexgrid <- function(expr, env = parent.frame(), quoted = FALSE) { # nocov start
  func <- exprToFunction(expr, env, quoted)
  createRenderFunction(
    func = func,
    transform = function(result, shinysession, name, ...) {
      if (is.null(result) || length(result) == 0)
        return(NULL)
      if (!inherits(result, "apex_grid")) {
        stop(
          "renderApexgrid: 'expr' must return an apexcharter grid object.",
          call. = FALSE
        )
      }
      TAG <- build_grid(
        result$content,
        nrow = result$nrow,
        ncol = result$ncol,
        col_gap = result$col_gap,
        row_gap = result$row_gap,
        height = result$height,
        width = result$width
      )
      rendered <- renderTags(TAG)
      deps <- lapply(
        X = resolveDependencies(rendered$dependencies),
        FUN = createWebDependency
      )
      list(
        html = rendered$html,
        deps = deps
      )
    }, apexgridOutput, list()
  )
} # nocov end





# Print methods -----------------------------------------------------------
# nocov start
#' @export
print.apex_grid <- function(x, ...) {
  TAG <- build_grid(
    x$content,
    nrow = x$nrow,
    ncol = x$ncol,
    col_gap = x$col_gap,
    row_gap = x$row_gap,
    height = x$height,
    width = x$width
  )
  print(htmltools::browsable(TAG))
}

knit_print.apex_grid <- function(x, ..., options = NULL) {
  TAG <- build_grid(
    x$content,
    nrow = x$nrow,
    ncol = x$ncol,
    col_gap = x$col_gap,
    row_gap = x$row_gap,
    height = x$height,
    width = x$width
  )
  knitr::knit_print(htmltools::browsable(TAG), options = options, ...)
}
# nocov end









