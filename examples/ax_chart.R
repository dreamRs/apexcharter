library(dplyr)
data("diamonds", package = "ggplot2")

# Stack bar type
apex(
  data = count(diamonds, cut, color),
  mapping = aes(x = cut, y = n, fill = color)
) %>%
  ax_chart(stacked = TRUE)

apex(
  data = count(diamonds, cut, color),
  mapping = aes(x = cut, y = n, fill = color)
) %>%
  ax_chart(stacked = TRUE, stackType = "100%")


# Toolbar
apex(
  data = count(diamonds, cut, color),
  mapping = aes(x = cut, y = n, fill = color)
) %>%
  ax_chart(toolbar = list(show = FALSE))

  
  