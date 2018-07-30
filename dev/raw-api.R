

# apexcharts.js raw api ---------------------------------------------------


library(apexcharter)
library(ggplot2) # for data
library(dplyr)


# bar ----

data(mpg)
dat <- count(mpg, manufacturer)

apexcharter(ax_opts = list(
  chart = list(type = "bar"),
  plotOptions = list(
    bar = list(
      horizontal = FALSE,
      endingShape = "flat",
      columnWidth = "70%",
      dataLabels = list(
        position = "top"
      )
    )
  ),
  colors = list("#112446"),
  grid = list(
    show = TRUE,
    position = "front"
  ),
  series = list(list(
    name = "Count",
    data = dat$n
  )),
  xaxis = list(categories = dat$manufacturer)
))



# line ----

# recreating (mostly): https://apexcharts.com/javascript-chart-demos/line-charts/data-labels/

apexcharter(ax_opts = list(
  chart = list(
    type = "line"
  ),
  stroke = list(
    curve = "smooth"
  ),
  grid = list(
    borderColor = "#e7e7e7",
    row = list(
      colors = c("#f3f3f3", "transparent"),
      opacity = 0.5
    )
  ),
  dataLabels = list(
    enabled = TRUE
  ),
  markers = list(style = "inverted", size = 6),
  series = list(
    list(
      name = "High",
      data = c(28, 29, 33, 36, 32, 32, 33)
    ),
    list(
      name = "Low",
      data = c(12, 11, 14, 18, 17, 13, 13)
    )
  ),
  title = list(
    text = "Average High & Low Temperature",
    align = "left"
  ),
  xaxis = list(
    categories = month.abb[1:7]
  ),
  yaxis = list(
    title = list(text = "Temperature"),
    labels = list(
      formatter = htmlwidgets::JS("function(value) {return value + '°C';}")
    )
  )
))









