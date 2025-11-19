# Proxy for updating series.

Allows you to update the series array overriding the existing one.

## Usage

``` r
ax_proxy_series(proxy, newSeries, animate = TRUE)
```

## Arguments

- proxy:

  A `apexchartProxy` `htmlwidget` object.

- newSeries:

  The series array to override the existing one.

- animate:

  Should the chart animate on re-rendering.

## Examples

``` r
if (interactive()) {
  library(shiny)

  ui <- fluidPage(
    fluidRow(
      column(
        width = 8, offset = 2,
        tags$h2("Real time chart"),
        apexchartOutput(outputId = "chart")
      )
    )
  )

  server <- function(input, output, session) {

    rv <- reactiveValues()
    rv$df <- data.frame(
      date = Sys.Date() + 1:20,
      values = sample(10:90, 20, TRUE)
    )

    observe({
      invalidateLater(1000, session)
      df <- isolate(rv$df)
      # Append new line of data
      df <- rbind(
        df, data.frame(
          date = df$date[length(df$date)] + 1,
          values = sample(10:90, 1, TRUE)
        )
      )
      rv$df <- df
    })

    output$chart <- renderApexchart({
      # Generate chart once
      apex(isolate(rv$df), aes(date, values), "spline") %>%
        ax_xaxis(
          range = 10 * 24 * 60 * 60 * 1000
          # Fixed range for x-axis : 10 days
          # days*hours*minutes*seconds*milliseconds
        )
    })

    observe({
      # Update chart to add new data
      apexchartProxy("chart") %>%
        ax_proxy_series(
          parse_df(rv$df),
          T
        )
    })

  }

  shinyApp(ui, server)
}
```
