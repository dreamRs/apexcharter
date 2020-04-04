
library(apexcharter)
data("economics", package = "ggplot2")

apex(
  data = tail(economics, 350), 
  mapping = aes(x = date, y = uempmed),
  type = "line"
) %>% 
  set_tooltip_fixed()
