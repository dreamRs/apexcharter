
library(apexcharter)
library(shiny)

ui <- fluidPage(
  tags$h2("Real time charts with {apexcharter}"),
  tags$hr(),
  fluidRow(
    column(
      width = 4,
      # verbatimTextOutput("res"),
      apexchartOutput(outputId = "gauge")
    ),
    column(
      width = 4,
      apexchartOutput(outputId = "bar")
    ),
    column(
      width = 4,
      apexchartOutput(outputId = "line")
    )
  )
)

server <- function(input, output, session) {
  
  rv <- reactiveValues(x = data.frame(
    time = sort(Sys.Date() - 1:20),
    value = round(rnorm(20, mean = 10)),
    groups = sample(LETTERS, 20, TRUE), 
    hits = round(runif(20, 1, 100)),
    stringsAsFactors = FALSE
  ))
  
  r <- reactive({
    invalidateLater(1000)
    rv$x <- rbind(
      isolate(rv$x),
      data.frame(
        time = isolate(tail(rv$x$time, 1) + 1),
        value = round(rnorm(1, mean = 10)),
        groups = sample(LETTERS, 1, TRUE),
        hits = round(runif(1, 1, 100))
      )
    )
  })
  
  output$res <- renderPrint({
    tail(r(), 20)
  })
  
  output$line <- renderApexchart({
    apex(data = tail(r(), 20), mapping = aes(x = time, y = value), type = "spline") %>% 
      ax_chart(animations = list(
        enabled = TRUE, easing = "linear", dynamicAnimation = list(enabled = FALSE)
      )) %>% 
      ax_xaxis(range = 777600000)
  })
  
  output$bar <- renderApexchart({
    apex(
      data = table(groups = r()$groups),
      mapping = aes(x = groups, y = Freq), 
      type = "column"
    )
  })
  
  output$gauge <- renderApexchart({
    apex(
      data = NULL, 
      type = "radialBar", 
      mapping = aes(x = "Last value", y = tail(r()$hits, 1))
    ) %>% 
      ax_plotOptions(
        radialBar = radialBar_opts(
          startAngle = -135,
          endAngle = 135,
          dataLabels = list(
            name = list(
              fontSize = "16px",
              offsetY = 120
            ),
            value = list(
              offsetY = 76,
              fontSize = "22px",
              formatter = JS("function (val) {return val + ' hits';}")
            )
          )
        )
      ) %>% 
      ax_stroke(dashArray = 4)
  })

}

if (interactive())
  shinyApp(ui, server)
