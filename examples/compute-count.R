library(apexcharter)

data("mpg", package = "ggplot2")

### No grouping

# Both charts should be equivalent
n_manufac <- as.data.frame(table(
  manufacturer = mpg$manufacturer
))
apex(data = n_manufac, type = "column", mapping = aes(x = manufacturer, y = Freq))

apex(data = mpg, type = "column", mapping = aes(x = manufacturer))


### With groups

# Both charts should be equivalent
n_manufac_year <- as.data.frame(table(
  manufacturer = mpg$manufacturer,
  year = mpg$year
))
apex(
  data = n_manufac_year,
  type = "column", 
  mapping = aes(x = manufacturer, y = n, fill = year)
)

apex(
  data = mpg, 
  type = "column",
  mapping = aes(x = manufacturer, fill = year)
)

