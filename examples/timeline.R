library(apexcharter)

data("presidential", package = "ggplot2")

# Basic (with formated date in tooltip)
apex(presidential, aes(x = name, start = start, end = end), "timeline") %>% 
  ax_tooltip(
    x = list(
      format = "yyyy"
    )
  )

# With groups
apex(presidential, 
     aes(x = name, start = start, end = end, group = party),
     "timeline")

# With groups but force position
apex(presidential, 
     aes(x = name, start = start, end = end, group = party),
     "timeline") %>% 
  ax_xaxis(categories = presidential$name)
# Bush appears twice


# With custom colors
presidential$color <- ifelse(presidential$party == "Democratic", "#00355f", "#c51c22")
apex(presidential, 
     aes(x = name, start = start, end = end, fill = color),
     "timeline")
