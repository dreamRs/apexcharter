library(apexcharter)


# Bar ----

data("climate_paris")

# Add a line on a column's chart
apex(climate_paris, aes(month, precipitation), type = "column") %>% 
  add_line(aes(month, temperature))

# Add secondary axis
apex(climate_paris, aes(month, precipitation), type = "column") %>% 
  add_line(aes(month, temperature)) %>%
  ax_yaxis(
    title = list(text = "Precipitation (in mm)")
  ) %>% 
  ax_yaxis2(
    opposite = TRUE,
    decimalsInFloat = 0,
    title = list(text = "Temperature (in degree celsius)")
  ) %>% 
  ax_dataLabels(
    enabled = TRUE, enabledOnSeries = list(1)
  )



# Scatter ----

# add smooth line on scatter plot
apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_line(aes(x, y), data = lowess(cars), serie_name = "lowess")


# or directly
apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_smooth_line()

apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_smooth_line(model = "loess", span = 1)

apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_smooth_line(model = "loess", degree = 1)


apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_smooth_line(formula = y ~ poly(x, 2))

apex(cars, aes(speed, dist), type = "scatter") %>% 
  add_smooth_line(model = "lm", serie_name = "lm") %>% 
  add_smooth_line(model = "loess", serie_name = "loess")





