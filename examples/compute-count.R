library(apexcharter)

data("mpg", package = "ggplot2")

### No grouping

# Both charts should be equivalent
n_manufac <- dplyr::count(mpg, manufacturer)
apex(data = n_manufac, type = "column", mapping = aes(x = manufacturer, y = n))

apex(data = mpg, type = "column", mapping = aes(x = manufacturer))


### With groups

# Both charts should be equivalent
n_manufac_year <- dplyr::count(mpg, manufacturer, year)
apex(data = n_manufac_year, type = "column", mapping = aes(x = manufacturer, y = n, fill = year))

apex(data = mpg, type = "column", mapping = aes(x = manufacturer, fill = year))

