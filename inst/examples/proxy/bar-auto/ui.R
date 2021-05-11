

library(shiny)
library(apexcharter)


fluidPage(
  tags$h2("Update an existing chart"),
  fluidRow(
    column(
      width = 4,
      selectizeInput(
        inputId = "year",
        label = "year :",
        choices = c("1999", "2008"),
        selected = "1999",
        multiple = TRUE, 
        options = list('plugins' = list('remove_button'))
      ),
      sliderInput(
        inputId = "cty", 
        label = "cty >= x :",
        min = 9, 
        max = 35, 
        value = 9
      ),
      checkboxInput(
        inputId = "keepallx", 
        label = "Keep all x", 
        value = FALSE
      )
    ),
    column(
      width = 8,
      apexchartOutput(outputId = "chart")
    )
  )
)


