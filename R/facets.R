

#' @importFrom rlang eval_tidy is_null is_function
build_facets <- function(chart) {
  data <- chart$x$data
  mapall <- lapply(chart$x$mapping, eval_tidy, data = data)
  labeller <- chart$x$facet$labeller
  title <- get_option(chart, "title")
  chart <- remove_option(chart, "title")
  subtitle <- get_option(chart, "subtitle")
  chart <- remove_option(chart, "subtitle")
  xaxis_title <- get_option(chart, "xaxis", "title")
  chart <- remove_option(chart, "xaxis", "title")
  yaxis_title <- get_option(chart, "yaxis", "title")
  chart <- remove_option(chart, "yaxis", "title")
  facets_list <- get_facets(
    data = data,
    rows = chart$x$facet$facets_row,
    cols = chart$x$facet$facets_col,
    type = chart$x$facet$type
  )
  facets_data <- facets_list$facets
  nrow_ <- facets_list$nrow %||% chart$x$facet$nrow
  ncol_ <- facets_list$ncol %||% chart$x$facet$ncol
  nums <- seq_along(facets_data)
  dims <- get_grid_dims(nums, nrow = nrow_, ncol = ncol_)
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
  facet_data_add_line <- if (!is.null(chart$x$add_line)) {
    get_facets(
      data = chart$x$add_line$data,
      rows = chart$x$facet$facets_row,
      cols = chart$x$facet$facets_col,
      type = chart$x$facet$type
    )$facets
  }
  facets <- lapply(
    X = nums,
    FUN = function(i) {
      new <- chart
      facet <- facets_data[[i]]
      if (identical(chart$x$facet$type, "wrap") && !is_null(labeller) && is_function(labeller)) {
        keys <- attr(facet, "keys")
        text <- labeller(keys)
        new <- ax_title(new, text = text, margin = 0, floating = length(text) <= 1)
      }
      mapdata <- lapply(chart$x$mapping, eval_tidy, data = facet)
      if (chart$x$facet$scales %in% c("fixed", "free_y") & chart$x$type %in% c("bar")) {
        mapdata <- complete_mapdata(mapdata, mapall)
      }
      if (chart$x$facet$scales %in% c("fixed", "free_x") & chart$x$type %in% c("column")) {
        mapdata <- complete_mapdata(mapdata, mapall)
      }
      new$x$ax_opts$series <- make_series(mapdata, chart$x$mapping, chart$x$type, chart$x$serie_name)
      new <- set_scale(new, mapall$x, scales = chart$x$facet$scales, axis = "x")
      new <- set_scale(new, mapall$y, scales = chart$x$facet$scales, axis = "y")
      if (chart$x$facet$scales %in% c("fixed", "free_x")) {
        new <- ax_yaxis(new, show = i %in% grid[, 1])
      }
      # if (chart$x$facet$scales %in% c("fixed", "free_y")) {
      #   new <- ax_xaxis(new, labels = list(show = i %in% lrow), axisTicks = list(show = TRUE))
      # }
      if (chart$x$facet$scales %in% c("fixed", "free_y") & chart$x$type %in% c("bar", "column")) {
        new <- ax_xaxis(new, labels = list(show = i %in% lrow))
      }
      if (!is.null(new$x$colors_manual)) {
        new <- ax_colors_manual(ax = new, values = new$x$colors_manual)
      }
      if (!is.null(facet_data_add_line)) {
        maplinedata <- lapply(chart$x$add_line$mapping, eval_tidy, data = facet_data_add_line[[i]])
        if (chart$x$facet$scales %in% c("fixed", "free_y") & chart$x$type %in% c("bar")) {
          maplinedata <- complete_mapdata(maplinedata, mapall)
        }
        if (chart$x$facet$scales %in% c("fixed", "free_x") & chart$x$type %in% c("column")) {
          maplinedata <- complete_mapdata(maplinedata, mapall)
        }
        new$x$ax_opts$series <- c(
          new$x$ax_opts$series,
          make_series(
            mapdata = maplinedata,
            mapping = chart$x$add_line$mapping,
            type = chart$x$add_line$type,
            serie_name = chart$x$add_line$serie_name,
            force_datetime_names = c("x", "y")
          )
        )
        # new <- add_line(
        #   ax = new,
        #   mapping = chart$x$add_line$mapping,
        #   data = facet_data_add_line[[i]],
        #   type = chart$x$add_line$type,
        #   serie_name = chart$x$add_line$serie_name
        # )
      }
      if (has_yaxis2(new)) {
        values <- get_yaxis_serie(chart, 2)
        new <- set_scale(new, values, scales = chart$x$facet$scales, axis = "y2")
      }
      new$height <- chart$height %||% chart$x$facet$chart_height
      new$x$facet <- NULL
      class(new) <- setdiff(class(new), "apex_facet")
      return(new)
    }
  )
  list(
    facets = facets,
    type = chart$x$facet$type,
    nrow = facets_list$nrow,
    ncol = facets_list$ncol,
    label_row = facets_list$label_row,
    label_col = facets_list$label_col,
    title = title,
    subtitle = subtitle,
    xaxis_title = xaxis_title,
    yaxis_title = yaxis_title
  )
}


get_last_row <- function(mat) {
  apply(X = mat, MARGIN = 2, FUN = function(x) {
    x <- x[!is.na(x)]
    x[length(x)]
  })
}



#' @title Facets for ApexCharts
#'
#' @description Create matrix of charts by row and column faceting variable (`ax_facet_grid`),
#'  or by specified number of row and column for faceting variable(s) (`ax_facet_wrap`).
#'
#' @param ax An [apexchart()] `htmlwidget` object.
#' @param facets Variable(s) to use for facetting, wrapped in `vars(...)`.
#' @param nrow,ncol Number of row and column in output matrix.
#' @param scales Should scales be fixed (`"fixed"`, the default),
#'  free (`"free"`), or free in one dimension (`"free_x"`, `"free_y"`)?
#' @param labeller A function with one argument containing for each facet the value of the faceting variable.
#' @param chart_height Individual chart height, ignored if an height is defined in `apex()` or `apexcharter()`.
#' @param grid_width Total width for the grid, regardless of the number of column.
#'
#' @return An [apexchart()] `htmlwidget` object with an additionnal class `"apex_facet"`.
#'
#' @details # Warning
#' To properly render in Shiny applications, use [apexfacetOutput()] (in UI) and [renderApexfacet()] (in Server).
#'
#' @export
#'
#' @name apex-facets
#'
#' @importFrom rlang quos syms
#'
#' @example examples/facet_wrap.R
ax_facet_wrap <- function(ax,
                          facets,
                          nrow = NULL,
                          ncol = NULL,
                          scales = c("fixed", "free", "free_y", "free_x"),
                          labeller = label_value,
                          chart_height = "300px",
                          grid_width = "100%") {
  if (!inherits(ax, "apex"))
    stop("ax_facet_wrap only works with charts generated with apex()", call. = FALSE)
  scales <- match.arg(scales)
  if (is.character(facets))
    facets <- quos(!!!syms(facets))
  ax$x$facet <- list(
    facets_row = facets,
    nrow = nrow,
    ncol = ncol,
    scales = scales,
    labeller = labeller,
    chart_height = chart_height,
    grid_width = grid_width,
    type = "wrap"
  )
  class(ax) <- c("apex_facet", class(ax))
  return(ax)
}


#' @param rows,cols A set of variables or expressions quoted by `vars()`
#'  and defining faceting groups on the rows or columns dimension.
#' @export
#'
#' @rdname apex-facets
#'
#' @example examples/facet_grid.R
ax_facet_grid <- function(ax,
                          rows = NULL,
                          cols = NULL,
                          scales = c("fixed", "free", "free_y", "free_x"),
                          labeller = label_value,
                          chart_height = "300px",
                          grid_width = "100%") {
  if (!inherits(ax, "apex"))
    stop("ax_facet_wrap only works with charts generated with apex()", call. = FALSE)
  scales <- match.arg(scales)
  if (!is.null(rows) && is.character(rows))
    rows <- quos(!!!syms(rows))
  if (!is.null(cols) && is.character(cols))
    cols <- quos(!!!syms(cols))
  ax$x$facet <- list(
    facets_row = rows,
    facets_col = cols,
    nrow = NULL,
    ncol = NULL,
    scales = scales,
    labeller = labeller,
    chart_height = chart_height,
    grid_width = grid_width,
    type = "grid"
  )
  class(ax) <- c("apex_facet", class(ax))
  return(ax)
}





# Tag ---------------------------------------------------------------------

#' @importFrom rlang %||%
#' @importFrom htmltools tags css validateCssUnit
build_facet_tag <- function(x) {
  facets <- build_facets(x)
  content <- facets$facets
  d <- get_grid_dims(content, x$x$facet$nrow, x$x$facet$ncol)
  row_after <- col_before <- NULL
  if (!is.null(facets$xaxis_title)) {
    if (identical(facets$type, "wrap")) {
      area <- paste(
        d$nrow + 1,
        1,
        d$nrow + 1,
        d$ncol + 2,
        sep = " / "
      )
    } else {
      area <- paste(
        (facets$nrow %||% 1) + 1 + !is.null(facets$ncol),
        1,
        (facets$nrow %||% 1) + 1 + !is.null(facets$ncol),
        (facets$ncol %||% 1) + 2,
        sep = " / "
      )
    }
    TAGX <- tags$div(
      class = "apexcharter-facet-xaxis-title",
      facets$xaxis_title$text,
      style = make_styles(facets$xaxis_title$style),
      style = paste("grid-area:", area, ";")
    )
    content <- c(content, list(TAGX))
    row_after <- "30px"
  }
  if (!is.null(facets$yaxis_title)) {
    if (identical(facets$type, "wrap")) {
      area <- paste(
        1,
        1,
        d$nrow + 1,
        2,
        sep = " / "
      )
    } else {
      area <- paste(
        1,
        1,
        (facets$nrow %||% 1) + 1 + !is.null(facets$ncol),
        2,
        sep = " / "
      )
    }
    TAGY <- tags$div(
      class = "apexcharter-facet-yaxis-title apexcharter-facet-rotate180",
      facets$yaxis_title$text,
      style = make_styles(facets$yaxis_title$style),
      style = paste("grid-area:", area, ";")
    )
    content <- c(content, list(TAGY))
    col_before <- "30px"
  }
  if (identical(facets$type, "wrap")) {
    TAG <- build_grid(
      content = content,
      nrow = d$nrow,
      ncol = d$ncol,
      row_after = row_after,
      col_before = col_before
    )
  } else if (identical(facets$type, "grid")) {
    if (!is.null(facets$nrow)) {
      for (i in seq_along(facets$label_row)) {
        content <- append(
          x = content,
          values = tagList(tags$div(
            class = "apexcharter-facet-row-label",
            x$x$facet$labeller(facets$label_row[i])
          )),
          after = ((facets$ncol %||% 1 + 1) * i) - 1
        )
      }
    }
    if (!is.null(facets$ncol)) {
      content <- tagList(
        lapply(
          X = facets$label_col,
          FUN = function(label_col) {
            tags$div(x$x$facet$labeller(label_col), class = "apexcharter-facet-col-label")
          }
        ),
        if (!is.null(facets$nrow)) tags$div(),
        content
      )
    }
    TAG <- build_grid(
      content,
      nrow = facets$nrow %||% 1,
      ncol = facets$ncol %||% 1,
      row_before = if (!is.null(facets$ncol)) "30px",
      col_after = if (!is.null(facets$nrow)) "30px",
      row_gap = "3px",
      col_gap = "3px",
      row_after = row_after,
      col_before = col_before
    )
  } else {
    stop("Facetting must be wrap or grid", call. = FALSE)
  }
  if (!is.null(facets$subtitle)) {
    TAG <- tagList(
      tags$div(
        class = "apexcharter-facet-subtitle",
        facets$subtitle$text,
        style = make_styles(facets$subtitle$style)
      ),
      TAG
    )
  }
  if (!is.null(facets$title)) {
    TAG <- tagList(
      tags$div(
        class = "apexcharter-facet-title",
        facets$title$text,
        style = make_styles(facets$title$style)
      ),
      TAG
    )
  }
  TAG <- tags$div(
    style = css(width = validateCssUnit(x$x$facet$grid_width)),
    class = "apexcharter-facet",
    TAG
  )
  return(TAG)
}





# Shiny -------------------------------------------------------------------


#' @title Shiny bindings for faceting with apexcharter
#'
#' @description Output and render functions for using apexcharter faceting within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#'
#' @return An Apexcharts output that can be included in the application UI.
#' @export
#'
#' @name apexcharter-shiny-facets
#'
#' @importFrom htmltools tagList
#' @importFrom shiny uiOutput
#' @importFrom htmlwidgets getDependency
#'
#' @example examples/facet-wrap-shiny.R
apexfacetOutput <- function(outputId) {
  tagList(
    uiOutput(outputId = outputId),
    getDependency(name = "apexcharter", package = "apexcharter")
  )
}

#' @param expr An expression that generates a apexcharter facet with [ax_facet_wrap()] or [ax_facet_grid()].
#' @param env The environment in which to evaluate `expr`.
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This
#'   is useful if you want to save an expression in a variable.
#'
#' @seealso [ax_facet_wrap()], [ax_facet_grid()]
#'
#' @export
#'
#' @rdname apexcharter-shiny-facets
#'
#' @importFrom shiny exprToFunction createRenderFunction createWebDependency
#' @importFrom htmltools renderTags resolveDependencies
renderApexfacet <- function(expr, env = parent.frame(), quoted = FALSE) { # nocov start
  func <- exprToFunction(expr, env, quoted)
  createRenderFunction(
    func = func,
    transform = function(result, shinysession, name, ...) {
      if (is.null(result) || length(result) == 0)
        return(NULL)
      if (!inherits(result, "apex_facet")) {
        stop(
          "renderApexfacet: 'expr' must return an apexcharter facet object.",
          call. = FALSE
        )
      }
      TAG <- build_facet_tag(result)
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
} # nocov end





# Print methods -----------------------------------------------------------

#' @export
print.apex_facet <- function(x, ...) { # nocov start
  TAG <- build_facet_tag(x)
  print(htmltools::browsable(TAG))
} # nocov end

knit_print.apex_facet <- function(x, ..., options = NULL) { # nocov start
  TAG <- build_facet_tag(x)
  knitr::knit_print(htmltools::browsable(TAG), options = options, ...)
} # nocov end




# Complete ----------------------------------------------------------------

complete_mapdata <- function(mapdata, mapall) {
  data <- as.data.frame(mapdata)
  full_x <- unique(mapall$x)
  full_data <- data.frame(
    xorder = seq_along(full_x),
    x = full_x,
    stringsAsFactors = FALSE
  )
  full_data <- merge(
    x = full_data,
    y = data,
    by = "x",
    all.x = TRUE,
    sort = FALSE
  )
  full_data <- full_data[order(full_data$xorder), ]
  full_data$xorder <- NULL
  full_data$y[is.na(full_data$y)] <- 0
  return(as.list(full_data))
}

complete_data <- function(data, vars, fill_var, fill_value = 0) {
  full_data <- expand.grid(lapply(
    X = data[, vars],
    FUN = unique
  ))
  full_data <- merge(
    x = full_data,
    y = data,
    by = vars,
    all.x = TRUE,
    sort = FALSE
  )
  full_data[[fill_var]][is.na(full_data[[fill_var]])] <- fill_value
  return(full_data)
}

