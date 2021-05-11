
library(shiny)
library(apexcharter)

ui <- fluidPage(
  tags$h2("Retrieve click information"),
  fluidRow(
    column(
      width = 4,
      tags$b("Single selection"),
      apexchartOutput("bar1"),
      verbatimTextOutput("clickbar1")
    ),
    column(
      width = 4,
      tags$b("Multiple selection"),
      apexchartOutput("bar2"),
      verbatimTextOutput("clickbar2")
    ),
    column(
      width = 4,
      tags$b("Several series"),
      apexchartOutput("bar3"),
      verbatimTextOutput("clickbar3")
    )
  ),
  fluidRow(
    column(
      width = 6,
      tags$b("Pie selection"),
      apexchartOutput("chart3"),
      verbatimTextOutput("result3")
    ),
    column(
      width = 6,
      tags$b("Time serie: you must display markers and use"),
      tags$code("ax_tooltip(intersect = TRUE, shared = FALSE)"),
      apexchartOutput("chart4"),
      verbatimTextOutput("result4")
    )
  ),
  fluidRow(
    column(
      width = 6,
      tags$b("Scatter exemple"),
      apexchartOutput("chart5"),
      verbatimTextOutput("result5")
    ),
    column(
      width = 6,
      tags$b("Bubble + color exemple"),
      apexchartOutput("chart6"),
      verbatimTextOutput("result6")
    )
  ),
  fluidRow(
    column(
      width = 6,
      tags$b("Heatmap exemple"),
      apexchartOutput("chart7"),
      verbatimTextOutput("result7")
    ),
    column(
      width = 6
    )
  ),
  tags$br()
)

server <- function(input, output, session) {
  
  # Bar single ----
  output$bar1 <- renderApexchart({
    data.frame(
      month = month.abb,
      value = sample(1:100, 12)
    ) %>% 
      apex(aes(month, value)) %>% 
      set_input_click("month_click")
  })
  output$clickbar1 <- renderPrint({
    input$month_click
  })
  
  # Bar multiple ----
  output$bar2 <- renderApexchart({
    data.frame(
      month = month.abb,
      value = sample(1:100, 12)
    ) %>% 
      apex(aes(month, value)) %>% 
      set_input_click(
        "month_click_mult", 
        multiple = TRUE, 
        effect_value = 0.1
      )
  })
  output$clickbar2 <- renderPrint({
    input$month_click_mult
  })
  
  # Bar several series ----
  output$bar3 <- renderApexchart({
    data.frame(
      month = rep(month.abb, 2),
      value = sample(1:100, 24),
      year = rep(c("Y-1", "Y"), each = 12)
    ) %>% 
      apex(aes(month, value, fill = year)) %>% 
      set_input_click(
        "month_click_series"
      )
  })
  output$clickbar3 <- renderPrint({
    input$month_click_series
  })
  
  # Pie ----
  output$chart3 <- renderApexchart({
    data.frame(
      answer = c("Yes", "No"),
      n = c(254, 238)
    ) %>% 
      apex(type = "pie", mapping = aes(x = answer, y = n)) %>% 
      set_input_click("click_pie")
  })
  output$result3 <- renderPrint({
    input$click_pie
  })
  
  # Time-serie ----
  output$chart4 <- renderApexchart({
    data.frame(
      date = seq(as.Date("1960-01-01"), length.out = 24, by = "month"),
      value = tail(as.vector(AirPassengers), 24)
    ) %>% 
      apex(aes(date, value), "line") %>% 
      ax_markers(size = 5) %>% 
      ax_tooltip(intersect = TRUE, shared = FALSE) %>% 
      set_input_click("click_time")
  })
  output$result4 <- renderPrint({
    input$click_time
  })
  
  # Scatter ----
  output$chart5 <- renderApexchart({
    apex(data = mtcars, type = "scatter", mapping = aes(x = wt, y = mpg)) %>% 
      set_input_click("click_scatter")
  })
  output$result5 <- renderPrint({
    input$click_scatter
  })
  
  # Bubble + color ----
  output$chart6 <- renderApexchart({
    apex(
      data = iris, type = "scatter", 
      aes(Sepal.Length, Sepal.Width, color = Species, size = Petal.Length)
    ) %>% 
      set_input_click("click_bubble", multiple = TRUE)
  })
  output$result6 <- renderPrint({
    input$click_bubble
  })
  
  # heatmap ----
  output$chart7 <- renderApexchart({
    data.frame(
      month = rep(month.abb, times = 5),
      city = rep(c("Paris", "Marseille", "Lyon", "Lille", "Nantes"), each = 12),
      value = sample(1:100, 5*12, TRUE)
    ) %>% 
      apex(
        type = "heatmap", 
        mapping = aes(x = month, y = city, fill = value)
      ) %>% 
      ax_dataLabels(enabled = FALSE) %>% 
      ax_colors("#008FFB") %>% 
      set_input_click("click_heatmap")
  })
  output$result7 <- renderPrint({
    input$click_heatmap
  })
  
}

shinyApp(ui, server)
