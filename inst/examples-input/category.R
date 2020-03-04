
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
  
}

shinyApp(ui, server)