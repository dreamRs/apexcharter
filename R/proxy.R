
#' @title Proxy for \code{apexchart}
#'
#' @description Allow to update a chart in Shiny application.
#'
#' @param shinyId single-element character vector indicating the output ID of the
#'   chart to modify (if invoked from a Shiny module, the namespace will be added
#'   automatically)
#' @param session the Shiny session object to which the chart belongs; usually the
#'   default value will suffice
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
apexchartProxy <- function(shinyId, session = shiny::getDefaultReactiveDomain()) {

  if (is.null(session)) {
    stop("apexchartProxy must be called from the server function of a Shiny app")
  }

  if (!is.null(session$ns) && nzchar(session$ns(NULL)) && substring(shinyId, 1, nchar(session$ns(""))) != session$ns("")) {
    shinyId <- session$ns(shinyId)
  }

  structure(
    list(
      session = session,
      id = shinyId,
      x = list()
    ),
    class = "apexchart_Proxy"
  )
}


#' Call a proxy method
#'
#' @param proxy  A \code{apexchartProxy} \code{htmlwidget} object.
#' @param name Proxy method.
#' @param ... Arguments passed to method.
#'
#' @return A \code{apexchartProxy} \code{htmlwidget} object.
#' @noRd
.ax_proxy <- function(proxy, name, ...) {
  if (!"apexchart_Proxy" %in% class(proxy))
    stop("This function must be used with a apexchartProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("update-apexchart-%s", name),
    message = list(id = proxy$id, data = list(...))
  )
  proxy
}
.ax_proxy2 <- function(proxy, name, l) {
  if (!"apexchart_Proxy" %in% class(proxy))
    stop("This function must be used with a apexchartProxy object", call. = FALSE)
  proxy$session$sendCustomMessage(
    type = sprintf("update-apexchart-%s", name),
    message = list(id = proxy$id, data = l)
  )
  proxy
}




#' @title Proxy for updating series.
#'
#' @description Allows you to update the series array overriding the existing one.
#'
#' @param proxy A \code{apexchartProxy} \code{htmlwidget} object.
#' @param newSeries The series array to override the existing one.
#' @param animate Should the chart animate on re-rendering.
#'
#' @export
#'
#' @examples
#'
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     fluidRow(
#'       column(
#'         width = 8, offset = 2,
#'         tags$h2("Real time chart"),
#'         apexchartOutput(outputId = "chart")
#'       )
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     rv <- reactiveValues()
#'     rv$df <- data.frame(
#'       date = Sys.Date() + 1:20,
#'       values = sample(10:90, 20, TRUE)
#'     )
#'
#'     observe({
#'       invalidateLater(1000, session)
#'       df <- isolate(rv$df)
#'       # Append new line of data
#'       df <- rbind(
#'         df, data.frame(
#'           date = df$date[length(df$date)] + 1,
#'           values = sample(10:90, 1, TRUE)
#'         )
#'       )
#'       rv$df <- df
#'     })
#'
#'     output$chart <- renderApexchart({
#'       # Generate chart once
#'       apex(isolate(rv$df), aes(date, values), "spline") %>%
#'         ax_xaxis(
#'           range = 10 * 24 * 60 * 60 * 1000
#'           # Fixed range for x-axis : 10 days
#'           # days*hours*minutes*seconds*milliseconds
#'         )
#'     })
#'
#'     observe({
#'       # Update chart to add new data
#'       apexchartProxy("chart") %>%
#'         ax_proxy_series(
#'           parse_df(rv$df),
#'           T
#'         )
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
ax_proxy_series <- function(proxy, newSeries, animate = TRUE) {
  .ax_proxy2(
    proxy = proxy,
    name = "series",
    l = list(newSeries = newSeries, animate = animate)
  )
}



#' @title Proxy for updating options
#'
#' @description Allows you to update the configuration object.
#'
#' @param proxy A \code{apexchartProxy} \code{htmlwidget} object.
#' @param options New options to set.
#'
#' @export
#'
#' @importFrom htmlwidgets JSEvals
#'
#' @examples
#'
#' if (interactive()) {
#'   library(shiny)
#'
#'   ui <- fluidPage(
#'     fluidRow(
#'       column(
#'         width = 8, offset = 2,
#'         tags$h2("Update options"),
#'         apexchartOutput(outputId = "chart"),
#'         checkboxInput(
#'           inputId = "show_label_xaxis",
#'           label = "Show x-axis labels"
#'         ),
#'         textInput(
#'           inputId = "yaxis_title",
#'           label = "Y-axis title"
#'         )
#'       )
#'     )
#'   )
#'   server <- function(input, output, session) {
#'
#'     output$chart <- renderApexchart({
#'       apexchart() %>%
#'         ax_chart(type = "bar") %>%
#'         ax_series(list(
#'           name = "Example",
#'           data = c(23, 43, 76, 31)
#'         )) %>%
#'         ax_xaxis(
#'           categories = c("Label A", "Label B",
#'                          "Label C", "Label D")
#'         )
#'     })
#'
#'     observe({
#'       apexchartProxy("chart") %>%
#'         ax_proxy_options(list(
#'           xaxis = list(
#'             labels = list(show = input$show_label_xaxis)
#'           ),
#'           yaxis = list(
#'             title = list(text = input$yaxis_title)
#'           )
#'         ))
#'     })
#'
#'   }
#'
#'   shinyApp(ui, server)
#' }
#'
ax_proxy_options <- function(proxy, options) {
  .ax_proxy2(
    proxy = proxy,
    name = "options",
    l = list(options = options, evals = JSEvals(options))
  )
}





#' @title Toggle series with proxy
#'
#' @description This method allows you to toggle the visibility of series programmatically.
#'  Useful when you have a custom legend.
#'
#' @param proxy A \code{apexchartProxy} \code{htmlwidget} object.
#' @param series_name The series name which you want to toggle visibility for.
#'
#' @noRd
#'
#' @example examples/proxy-toggle.R
ax_proxy_toggle_series <- function(proxy, series_name) {
  .ax_proxy2(
    proxy = proxy,
    name = "toggle-series",
    l = list(seriesName = list1(series_name))
  )
}




