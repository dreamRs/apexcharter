
#  ------------------------------------------------------------------------
#
# Title : Quick ApexCharts Examples
#    By : Victor
#  Date : 2019-02-14
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(apexcharter)
library(ggplot2)
library(dplyr)




# Bar & Column ------------------------------------------------------------

data("mpg")
n_manufac <- count(mpg, manufacturer)

apex(data = n_manufac, type = "bar", mapping = aes(x = manufacturer, y = n))
apex(data = n_manufac, type = "column", mapping = aes(x = manufacturer, y = n))


n_manufac_year <- count(mpg, manufacturer, year)

apex(data = n_manufac_year, type = "bar", mapping = aes(x = manufacturer, y = n, fill = year))
apex(data = n_manufac_year, type = "column", mapping = aes(x = manufacturer, y = n, fill = year))

apex(data = n_manufac_year, type = "column", mapping = aes(x = manufacturer, y = n, fill = year)) %>% 
  ax_chart(stacked = TRUE)




# Line, Spline & Area -----------------------------------------------------

data("economics")
economics <- tail(economics, 100)

economics_long <- economics_long %>% 
  group_by(variable) %>% 
  slice(1:100)


apex(data = economics, type = "line", mapping = aes(x = date, y = uempmed))
apex(data = economics, type = "spline", mapping = aes(x = date, y = uempmed))
apex(data = economics, type = "area", mapping = aes(x = date, y = uempmed))


apex(data = economics_long, type = "line", mapping = aes(x = date, y = value01, group = variable))
apex(data = economics_long, type = "spline", mapping = aes(x = date, y = value01, fill = variable))
apex(data = economics_long, type = "area", mapping = aes(x = date, y = value01, fill = variable))

apex(data = economics_long, type = "area", mapping = aes(x = date, y = value01, fill = variable)) %>% 
  ax_chart(stacked = TRUE) %>% 
  ax_dataLabels(enabled = FALSE)

library(rte.data)


consumption <- get_consumption(type = c("REALISED", "D-1"))
apex(data = consumption, type = "line", mapping = aes(x = start_date, y = value, fill = type))






# Scatter & Bubble --------------------------------------------------------

apex(data = iris, type = "scatter", mapping = aes(x = Sepal.Length, y = Sepal.Width))

apex(data = iris, type = "scatter", mapping = aes(x = Sepal.Length, y = Sepal.Width, fill = Species)) %>% 
  ax_yaxis(min = min(iris$Sepal.Width))

apex(data = iris, type = "scatter", mapping = aes(x = Sepal.Length, y = Sepal.Width, fill = Species, z = scales::rescale(Petal.Length))) %>% 
  ax_yaxis(min = min(iris$Sepal.Width))



apex(data = mtcars, type = "scatter", mapping = aes(x = wt, y = mpg))
apex(data = mtcars, type = "scatter", mapping = aes(x = wt, y = mpg, fill = cyl))
apex(data = mtcars, type = "scatter", mapping = aes(x = wt, y = mpg, z = scales::rescale(qsec)))





# Pie ---------------------------------------------------------------------

fruits <- data.frame(
  name = c('Apples', 'Oranges', 'Bananas', 'Berries'),
  value = c(44, 55, 67, 83)
)
apex(data = fruits, type = "pie", mapping = aes(x = name, y = value))




# Radial ------------------------------------------------------------------

apex(data = NULL, type = "radialBar", mapping = aes(x = "My value", y = 65))

apex(data = NULL, type = "radialBar", mapping = aes(x = "My value", y = 65)) %>% 
  ax_plotOptions(radialBar = radialBar_opts(
    startAngle = -90, endAngle = 90,
    dataLabels = list(
      name = list(offsetY = -50, fontSize = "32px"),
      value = list(offsetY = -30, fontSize = "26px")
    )
  ))

fruits <- data.frame(
  name = c('Apples', 'Oranges', 'Bananas', 'Berries'),
  value = c(44, 55, 67, 83)
)
apex(data = fruits, type = "radialBar", mapping = aes(x = name, y = value))





# Radar -------------------------------------------------------------------

data("avengers", package = "billboarder")

apex(data = avengers, type = "radar", mapping = aes(x = axis, y = value, group = group))


apex(data = avengers_wide, type = "radar", mapping = aes(x = axis, y = `Captain America`))

apex(data = head(msleep), type = "radar", mapping = aes(x = name, y = sleep_total))


mtcars$model <- rownames(mtcars)
apex(data = head(mtcars), type = "radar", mapping = aes(x = model, y = qsec))

new_mtcars <- reshape(
  data = head(mtcars), 
  idvar = "model", 
  varying = list(c("drat", "wt")),
  times = c("drat", "wt"),
  direction = "long",
  v.names = "value",
  drop = c("mpg", "cyl", "hp", "dist", "qsec", "vs", "am", "gear", "carb")
)
apex(data = new_mtcars, type = "radar", mapping = aes(x = model, y = value, group = time))





# Heatmap -----------------------------------------------------------------

txhousing2 <- txhousing %>% 
  filter(city %in% head(unique(city)), year %in% c(2000, 2001)) %>% 
  # mutate(date = paste(year, month, sep = "-")) %>% 
  rename(val_med = median)

apex(data = txhousing2, type = "heatmap", mapping = aes(x = date, y = scales::rescale(val_med), group = city)) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_colors("#008FFB")



