
#' @importFrom rlang eval_tidy
get_facets <- function(data, vars) {
  byvars <- lapply(X = vars, FUN = eval_tidy, data = data)
  facets <- split(x = data, f = byvars, sep = "|__|")
  lapply(
    X = seq_along(facets),
    FUN = function(i) {
      facet <- facets[[i]]
      attr(facet, "keys") <- strsplit(
        x = names(facets)[i], 
        split = "|__|", fixed = TRUE
      )[[1]]
      facet
    }
  )
}

set_scale <- function(ax, values, scales = c("fixed", "free", "free_y", "free_x"), axis = c("x", "y")) {
  scales <- match.arg(scales)
  axis <- match.arg(axis)
  if (is.null(values))
    return(ax)
  if (inherits(values, c("numeric", "integer", "Date", "POSIXt"))) {
    range_vals <- range(pretty(values), na.rm = TRUE)
  } else {
    range_vals <- NULL
  }
  
  fmt <- function(x, time = inherits(values, c("Date", "POSIXt"))) {
    if (is.null(x))
      return(NULL)
    if (time)
      x <- format_date(x)
    x
  }
  
  fun_axis <- switch(
    axis,
    "x" = ax_xaxis,
    "y" = ax_yaxis
  )
  
  if (scales == "fixed") {
    ax <- fun_axis(
      ax = ax,
      min = fmt(range_vals[1]), 
      max = fmt(range_vals[2])
    )
  } else if (scales == "free") {
    ax <- fun_axis(
      ax = ax,
      min = character(0), 
      max = character(0)
    )
  } else {
    ax <- fun_axis(
      ax = ax,
      min = fmt(range_vals[1]), 
      max = fmt(range_vals[2])
    )
    if (scales == "free_x" & axis == "x") {
      ax <- fun_axis(
        ax = ax,
        min = character(0), 
        max = character(0)
      )
    }
    if (scales == "free_y" & axis == "y") {
      ax <- fun_axis(
        ax = ax,
        min = character(0), 
        max = character(0)
      )
    }
  }
  
  return(ax)
}

#' @importFrom rlang eval_tidy is_null is_function
build_facets <- function(chart) {
  data <- chart$x$data
  mapall <- lapply(chart$x$mapping, eval_tidy, data = data)
  labeller <- chart$x$facet$labeller
  facets_data <- get_facets(data, chart$x$facet$facets)
  nums <- seq_along(facets_data)
  dims <- get_grid_dims(nums, nrow = chart$x$facet$nrow, ncol = chart$x$facet$ncol)
  grid <- matrix(
    data = c(
      nums,
      rep(NA, times = (dims$nrow * dims$ncol) - length(nums))
    ), 
    nrow = dims$nrow, 
    ncol = dims$ncol, 
    byrow = TRUE
  )
  lrow <- get_last_row(grid)
  lapply(
    X = nums,
    FUN = function(i) {
      new <- chart
      facet <- facets_data[[i]]
      if (!is_null(labeller) && is_function(labeller)) {
        keys <- attr(facet, "keys")
        # browser()
        new <- ax_title(new, text = labeller(keys))
      }
      mapdata <- lapply(chart$x$mapping, eval_tidy, data = facet)
      new$x$ax_opts$series <- make_series(mapdata, chart$x$mapping, chart$x$type, chart$x$serie_name)
      new <- set_scale(new, mapall$x, scales = chart$x$facet$scales, axis = "x")
      new <- set_scale(new, mapall$y, scales = chart$x$facet$scales, axis = "y")
      if (chart$x$facet$scales %in% c("fixed", "free_x")) {
        new <- ax_yaxis(new, show = i %in% grid[, 1])
      }
      # if (chart$x$facet$scales %in% c("fixed", "free_y")) {
      #   new <- ax_xaxis(new, labels = list(show = i %in% lrow), axisTicks = list(show = TRUE))
      # }
      new$height <- chart$x$facet$chart_height
      new$x$facet <- NULL
      class(new) <- setdiff(class(new), "apex_facet")
      return(new)
    }
  )
}


get_grid_dims <- function(content, nrow, ncol) {
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

get_last_row <- function(mat) {
  apply(X = mat, MARGIN = 2, FUN = function(x) {
    x <- x[!is.na(x)]
    x[length(x)]
  })
}

build_grid <- function(content, nrow = NULL, ncol = NULL, col_gap = "0px", row_gap = "10px") {
  d <- get_grid_dims(content, nrow, ncol)
  htmltools::tags$div(
    class = "apexcharter-facet-container",
    style = "display: grid;",
    style = sprintf("grid-template-columns: repeat(%s, 1fr);", d$ncol),
    style = sprintf("grid-template-rows: repeat(%s, 1fr);", d$nrow),
    style = sprintf("grid-column-gap: %s;", col_gap),
    style = sprintf("grid-row-gap: %s;", row_gap),
    content
  )
}



#' Facet wrap for ApexCharts
#'
#' @param ax An \code{apexcharts} \code{htmlwidget} object.
#' @param facets Variable(s) to use for facetting, wrapped in \code{vars(...)}.
#' @param nrow,ncol Number of row and column in output matrix.
#' @param chart_height Individual chart height.
#'
#' @return An \code{apexcharts} \code{htmlwidget} object.
#' @export
#' 
#' @importFrom rlang quos syms
#'
#' @examples
ax_facet_wrap <- function(ax, 
                          facets, 
                          nrow = NULL,
                          ncol = NULL,
                          scales = c("fixed", "free", "free_y", "free_x"),
                          labeller = label_value,
                          chart_height = "300px") {
  if (!inherits(ax, "apex"))
    stop("ax_facet_wrap only works with charts generated with apex()", call. = FALSE)
  scales <- match.arg(scales)
  if (is.character(facets))
    facets <- quos(!!!syms(facets))
  ax$x$facet <- list(
    facets = facets,
    nrow = nrow,
    ncol = ncol,
    scales = scales,
    labeller = labeller,
    chart_height = chart_height
  )
  class(ax) <- c("apex_facet", class(ax))
  return(ax)
}





# Shiny -------------------------------------------------------------------

#' @export
apexfacetOutput <- function(outputId) {
  htmltools::tagList(
    shiny::uiOutput(outputId = outputId),
    htmlwidgets::getDependency("apexcharter", "apexcharter")
  )
}

#' @export
#' 
#' @importFrom shiny exprToFunction createRenderFunction createWebDependency
#' @importFrom htmltools renderTags resolveDependencies
renderApexfacet <- function(expr, env = parent.frame(), quoted = FALSE) {
  func <- exprToFunction(expr, env, quoted)
  createRenderFunction(
    func = func,
    transform = function(result, shinysession, name, ...) {
      if (is.null(result) || length(result) == 0)
        return(NULL)
      if (!inherits(result, "apex_facet")) {
        stop(
          "renderApexfacet: 'expr' must return an apexcharter facets.",
          call. = FALSE
        )
      }
      facets_charts <- build_facets(result)
      TAG <- build_grid(
        content = facets_charts,
        nrow = result$x$facet$nrow,
        ncol = result$x$facet$ncol
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
    }, apexfacetOutput, list()
  )
}





# Print methods -----------------------------------------------------------

#' @export
print.apex_facet <- function(x, ...) {
  facets_charts <- build_facets(x)
  TAG <- build_grid(facets_charts, nrow = x$x$facet$nrow, ncol = x$x$facet$ncol)
  print(htmltools::browsable(TAG))
}

knit_print.apex_facet <- function(x, ..., options = NULL) {
  facets_charts <- build_facets(x)
  TAG <- build_grid(facets_charts, nrow = x$x$facet$nrow, ncol = x$x$facet$ncol)
  knitr::knit_print(htmltools::browsable(TAG), options = options, ...)
}






