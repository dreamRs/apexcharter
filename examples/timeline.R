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
apex(
  presidential,
  aes(x = name, start = start, end = end, group = party),
  "timeline"
)

# With groups but force position
apex(
  presidential,
  aes(x = name, start = start, end = end, group = party),
  "timeline"
) %>%
  ax_plotOptions(
    bar = bar_opts(rangeBarGroupRows = TRUE)
  ) %>%
  ax_xaxis(categories = unique(presidential$name))



# With custom colors

apex(
  presidential,
  aes(x = name, start = start, end = end, group = party),
  "timeline"
) %>%
  ax_plotOptions(
    bar = bar_opts(rangeBarGroupRows = TRUE)
  ) %>%
  ax_xaxis(categories = unique(presidential$name)) %>%
  ax_colors_manual(list(
    Democratic = "#00355f",
    Republican = "#c51c22"
  ))
