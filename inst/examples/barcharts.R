
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

apexchart() %>% 
  ax_chart(type = "bar") %>% 
  ax_plotOptions(bar = bar_opts(
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

apexchart() %>% 
  ax_chart(type = "bar") %>% 
  ax_plotOptions(bar = bar_opts(
    horizontal = TRUE,
    dataLabels = list(
      position = "center"
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






# Stacked bar -------------------------------------------------------------

stacked <- count(mpg, manufacturer, year)

apexchart() %>% 
  ax_chart(type = "bar", stacked = TRUE) %>% 
  ax_series(
    list(
      name = "1999", 
      data = filter(stacked, year == 1999) %>% pull(n)
    ),
    list(
      name = "2008", 
      data = filter(stacked, year == 2008) %>% pull(n)
    )
  ) %>% 
  ax_xaxis(categories = unique(stacked$manufacturer)) %>% 
  ax_legend(
    position = "right",
    verticalAlign = "top",
    offsetX = 0,
    offsetY = 50
  )




# Grouped bar -------------------------------------------------------------

stacked <- count(mpg, manufacturer, year)

apexchart() %>% 
  ax_chart(type = "bar", stacked = FALSE) %>% 
  ax_plotOptions(bar = bar_opts(
    endingShape = "rounded"
  )) %>% 
  ax_series(
    list(
      name = "1999", 
      data = filter(stacked, year == 1999) %>% pull(n)
    ),
    list(
      name = "2008", 
      data = filter(stacked, year == 2008) %>% pull(n)
    )
  ) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_xaxis(categories = unique(stacked$manufacturer))







