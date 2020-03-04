
library(shiny)
library(apexcharter)

ui <- fluidPage(
  tags$h2("Retrieve category clicked"),
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
      width = 6
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
      set_input_category("month_click")
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
      set_input_category("month_click_mult", multiple = TRUE)
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
      set_input_category("click_pie")
  })
  output$result3 <- renderPrint({
    input$click_pie
  })
  
}

shinyApp(ui, server)