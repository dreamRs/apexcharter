
library(shiny)
library(apexcharter)

ui <- fluidPage(
  tags$h2("Retrieve click information"),
  fluidRow(
    column(
      width = 6,
      tags$b("Single selection"),
      apexchartOutput("chart1"),
      verbatimTextOutput("result1")
    ),
    column(
      width = 6,
      tags$b("Multiple selection"),
      apexchartOutput("chart2"),
      verbatimTextOutput("result2")
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
  )
)

server <- function(input, output, session) {
  
  output$chart1 <- renderApexchart({
    data.frame(
      month = month.abb,
      value = sample(1:100, 12)
    ) %>% 
      apex(aes(month, value)) %>% 
      set_input_click("month_click")
  })
  output$result1 <- renderPrint({
    input$month_click
  })
  
  output$chart2 <- renderApexchart({
    data.frame(
      month = month.abb,
      value = sample(1:100, 12)
    ) %>% 
      apex(aes(month, value)) %>% 
      set_input_click("month_click_mult", multiple = TRUE)
  })
  output$result2 <- renderPrint({
    input$month_click_mult
  })
  
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
  
}

shinyApp(ui, server)
