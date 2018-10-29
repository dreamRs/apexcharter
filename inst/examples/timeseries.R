
#  ------------------------------------------------------------------------
#
# Title : Timeseries with apexcharter
#    By : Victor
#  Date : 2018-09-03
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(apexcharter)
library(ggplot2) # data



# Data --------------------------------------------------------------------

data("economics", package = "ggplot2")




# One serie (class Date) --------------------------------------------------


apexchart() %>% 
  ax_chart(type = "area", zoom = list(enabled = TRUE)) %>% 
  # ax_stroke(curve = "smooth") %>% 
  ax_plotOptions(line = list(curve = "smooth")) %>%
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series(list(
    name = "personal savings rate",
    data = parse_df(economics[, c("date", "psavert")])
  )) %>% 
  ax_markers(size = 0, style = "full") %>%
  ax_title(text = "US economic time series", align = "left") %>% 
  ax_subtitle(text = "Data from ggplot2") %>% 
  ax_fill(gradient = list(
    enabled = TRUE,
    shadeIntensity = 1,
    inverseColors = FALSE,
    opacityFrom = 0,
    opacityTo = 1,
    stops = c(0, 2000)
  )) %>%
  ax_yaxis(
    min = 0, max = 20,
    tickAmount = 4,
    labels = list(
      formatter = htmlwidgets::JS("function(val) {return val.toFixed(0);}")
    ),
    title = list(text = "Personal savings rate")
  ) %>%
  ax_xaxis(type = "datetime", labels = list(format = "dd MMM yyyy")) %>% 
  ax_tooltip(x = list(format = "dd MMM yyyy"))





# Two series (Date) -------------------------------------------------------

apexchart() %>% 
  ax_chart(type = "line", zoom = list(enabled = TRUE)) %>% 
  ax_plotOptions(line = list(curve = "smooth")) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series(
    list(
      name = "personal savings rate",
      data = parse_df(economics[, c("date", "psavert")])
    ),
    list(
      name = "median duration of unemployment (in weeks)",
      data = parse_df(economics[, c("date", "uempmed")])
    )
  ) %>% 
  ax_markers(size = 0, style = "full") %>% 
  ax_title(text = "US economic time series", align = "left") %>% 
  ax_subtitle(text = "Data from ggplot2") %>% 
  ax_yaxis(
    min = 0, max = 30,
    tickAmount = 6,
    labels = list(
      formatter = htmlwidgets::JS("function(val) {return val.toFixed(0);}")
    ),
    title = list(text = "Personal savings rate")
  ) %>% 
  ax_xaxis(type = "datetime", labels = list(format = "d MMM yy")) %>% 
  ax_tooltip(x = list(format = "dd MMM yyyy"))






# Scroller (zoom) ---------------------------------------------------------

# doesn't work since 2.0.0

apexchart() %>% 
  ax_chart(type = "area", scroller = list(enabled = TRUE)) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series(list(
    name = "personal savings rate",
    data = parse_df(economics[, c("date", "psavert")])
  )) %>% 
  ax_title(text = "US economic time series", align = "left") %>% 
  ax_subtitle(text = "Data from ggplot2") %>% 
  ax_yaxis(
    min = 0, max = 20,
    tickAmount = 4,
    labels = list(
      formatter = htmlwidgets::JS("function(val) {return val.toFixed(0);}")
    ),
    title = list(text = "Personal savings rate")
  ) %>% 
  ax_xaxis(type = "datetime", labels = list(format = "d MMM yy"))




