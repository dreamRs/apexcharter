# Proxy for updating options

Allows you to update the configuration object.

## Usage

``` r
ax_proxy_options(proxy, options)
```

## Arguments

- proxy:

  A `apexchartProxy` `htmlwidget` object.

- options:

  New options to set.

## Examples

``` r
if (interactive()) {
  library(shiny)

  ui <- fluidPage(
    fluidRow(
      column(
        width = 8, offset = 2,
        tags$h2("Update options"),
        apexchartOutput(outputId = "chart"),
        checkboxInput(
          inputId = "show_label_xaxis",
          label = "Show x-axis labels"
        ),
        textInput(
          inputId = "yaxis_title",
          label = "Y-axis title"
        )
      )
    )
  )
  server <- function(input, output, session) {

    output$chart <- renderApexchart({
      apexchart() %>%
        ax_chart(type = "bar") %>%
        ax_series(list(
          name = "Example",
          data = c(23, 43, 76, 31)
        )) %>%
        ax_xaxis(
          categories = c("Label A", "Label B",
                         "Label C", "Label D")
        )
    })

    observe({
      apexchartProxy("chart") %>%
        ax_proxy_options(list(
          xaxis = list(
            labels = list(show = input$show_label_xaxis)
          ),
          yaxis = list(
            title = list(text = input$yaxis_title)
          )
        ))
    })

  }

  shinyApp(ui, server)
}
```
