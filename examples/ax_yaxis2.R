library(apexcharter)
library(dplyr)
data("economics_long", package = "ggplot2")

eco <- economics_long %>%
  filter(variable %in% c("pce", "pop")) %>% 
  mutate(value = round(value))

# add second y-axis
apex(eco, aes(x = date, y = value, color = variable), type = "line") %>%
  ax_yaxis(title = list(text = "Pce")) %>%
  ax_yaxis2(opposite = TRUE, title = list(text = "Pop"))

# Customize axis a bit more
apex(eco, aes(x = date, y = value, color = variable), type = "line") %>%
  ax_yaxis(
    title = list(text = "Pce"),
    axisBorder = list(
      show = TRUE,
      color = "#008FFB"
    ),
    labels = list(
      style = list(
        colors = "#008FFB"
      )
    ),
    tooltip = list(
      enabled = TRUE
    )
  ) %>%
  ax_yaxis2(
    opposite = TRUE, 
    min = 160000,
    forceNiceScale = TRUE,
    title = list(text = "Pop"),
    axisBorder = list(
      show = TRUE,
      color = "#00E396"
    ),
    labels = list(
      style = list(
        colors = "#00E396"
      )
    ),
    tooltip = list(
      enabled = TRUE
    )
  )
