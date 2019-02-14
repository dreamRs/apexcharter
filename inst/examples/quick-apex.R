
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





# Line, Spline & Area -----------------------------------------------------

data("economics")
economics <- tail(economics, 100)

economics_long <- economics_long %>% 
  group_by(variable) %>% 
  slice(1:100)


apex(data = economics, type = "line", mapping = aes(x = date, y = uempmed))
apex(data = economics, type = "spline", mapping = aes(x = date, y = uempmed))
apex(data = economics, type = "area", mapping = aes(x = date, y = uempmed))


apex(data = economics_long, type = "line", mapping = aes(x = date, y = value01, fill = variable))
apex(data = economics_long, type = "spline", mapping = aes(x = date, y = value01, fill = variable))
apex(data = economics_long, type = "area", mapping = aes(x = date, y = value01, fill = variable))




# Scatter & Bubble --------------------------------------------------------


apex(data = iris, type = "scatter", mapping = aes(x = Sepal.Length, y = Sepal.Width, fill = Species)) %>% 
  ax_yaxis(min = min(iris$Sepal.Width))



