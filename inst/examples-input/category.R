
library(shiny)
library(apexcharter)

ui <- fluidPage(
  tags$h2("Retrieve category clicked"),
  fluidRow(
    column(
      width = 6,
      apexchartOutput("chart1"),
      verbatimTextOutput("result1")
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
  
}

shinyApp(ui, server)