library(apexcharter)
library(shiny)

ui <- fluidPage(
  tags$h2("Spark box"),
  actionButton("update", "Update"),
  tags$br(), tags$br(),
  fluidRow(
    column(
      width = 4,
      sparkBoxOutput("spark1")
    ),
    column(
      width = 4,
      sparkBoxOutput("spark2")
    ),
    column(
      width = 4,
      sparkBoxOutput("spark3")
    )
  )
)

server <- function(input, output, session) {
  
  r <- reactive({
    input$update
    data.frame(
      date = Sys.Date() + 1:20,
      var1 = round(rnorm(20, 50, 10)),
      var2 = round(rnorm(20, 50, 10)),
      var3 = round(rnorm(20, 50, 10))
    )
  })
  
  output$spark1 <- renderSparkBox({
    spark_box(
      data = r()[, c("date", "var1")],
      title = mean(r()$var1), 
      subtitle = "Variable 1"
    )
  })
  
  output$spark2 <- renderSparkBox({
    spark_box(
      data = r()[, c("date", "var2")],
      title = mean(r()$var2), 
      subtitle = "Variable 2"
    )
  })
  
  output$spark3 <- renderSparkBox({
    spark_box(
      data = r()[, c("date", "var3")],
      title = mean(r()$var3), 
      subtitle = "Variable 3",
      color = "#FFF", background = "#2E93fA",
      title_style = list(color = "#FFF"),
      subtitle_style = list(color = "#FFF")
    )
  })
  
}

shinyApp(ui, server)
