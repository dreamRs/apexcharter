
#  ------------------------------------------------------------------------
#
# Title : Barcharts
#    By : Victor
#  Date : 2018-09-03
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(apexcharter)
library(ggplot2) # for data
library(dplyr) # for count




# One serie - vertical ----------------------------------------------------

data(mpg)
dat <- count(mpg, manufacturer)

apexcharter() %>% 
  ax_chart(type = "bar") %>% 
  ax_plotOptions(bar = barOpts(
    horizontal = FALSE,
    endingShape = "flat",
    columnWidth = "70%",
    dataLabels = list(
      position = "top"
    ))
  ) %>% 
  ax_grid(
    show = TRUE,
    position = "front"
  ) %>% 
  ax_series(list(
    name = "Count",
    data = dat$n
  )) %>% 
  ax_colors("#112446") %>% 
  ax_xaxis(categories = dat$manufacturer) %>% 
  ax_title(text = "Number of models") %>% 
  ax_subtitle(text = "Data from ggplot2")


 


# One serie - horizontal --------------------------------------------------

data(mpg)
dat <- count(mpg, manufacturer)

apexcharter() %>% 
  ax_chart(type = "bar") %>% 
  ax_plotOptions(bar = barOpts(
    horizontal = TRUE,
    dataLabels = list(
      position = "top"
    ))
  ) %>% 
  ax_grid(
    show = TRUE,
    yaxis = list(lines = list(show = FALSE)),
    xaxis = list(lines = list(show = TRUE))
  ) %>% 
  ax_series(list(
    name = "Count",
    data = dat$n
  )) %>% 
  ax_colors("#112446") %>% 
  ax_xaxis(categories = dat$manufacturer) %>% 
  ax_title(text = "Number of models") %>% 
  ax_subtitle(text = "Data from ggplot2")










