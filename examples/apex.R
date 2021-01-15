library(ggplot2)
library(apexcharter)

# make a barchart with a frequency table
data("mpg", package = "ggplot2")
apex(mpg, aes(manufacturer), type = "bar")


# timeseries
data("economics", package = "ggplot2")
apex(
  data = economics, 
  mapping = aes(x = date, y = uempmed), 
  type = "line"
)

# you can add option to apex result :
apex(
  data = economics, 
  mapping = aes(x = date, y = uempmed), 
  type = "line"
) %>% 
  ax_stroke(width = 1)


# with group variable
data("economics_long", package = "ggplot2")
apex(
  data = economics_long, 
  mapping = aes(x = date, y = value01, group = variable), 
  type = "line"
)
