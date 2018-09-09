
#  ------------------------------------------------------------------------
#
# Title : Heatmap
#    By : Victor
#  Date : 2018-09-03
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(apexcharter)
library(highcharter) # data
library(dplyr)
library(tidyr)




# Mtcars heatmap ----------------------------------------------------------

mtcars_long <- mtcars %>% 
  tibble::rownames_to_column(var = "model") %>% 
  gather(variable, value, -model)


apexchart() %>% 
  ax_chart(type = "heatmap") %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series2(lapply(
    X = unique(mtcars_long$model),
    FUN = function(x) {
      list(
        name = x,
        data = parse_df(mtcars_long[mtcars_long$model == x, c("variable", "value")])
      )
    }
  )) %>% 
  ax_xaxis(type = "category", categories = unique(mtcars_long$variable))






# Large Heatmap -----------------------------------------------------------

# pretty slow

# trying to recreate "The Impact of Vaccines" (http://jkunst.com/highcharter/showcase.html)

data("vaccines", package = "highcharter")

apexchart() %>% 
  ax_chart(type = "heatmap", animations = list(enabled = FALSE)) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series2(lapply(
    X = unique(vaccines$state),
    FUN = function(x) {
      list(
        name = x,
        data = parse_df(vaccines[vaccines$state == x, c("year", "count")])
      )
    }
  )) %>% 
  # ax_colors("#008FFB") %>% 
  ax_plotOptions(
    heatmap = heatmapOpts(
      colorScale = list(
        ranges = list(
          list(
            from = 0,
            to = 4,
            name = "low",
            color = "#000004"
          ),
          list(
            from = 4,
            to = 70,
            name = "mid-low",
            color = "#781C6D"
          ),
          list(
            from = 70,
            to = 290,
            name = "mid-high",
            color = "#ED6925"
          ),
          list(
            from = 290,
            to = 3000,
            name = "high",
            color = "#FCFFA4"
          )
        )
      )
    )
  ) %>% 
  ax_xaxis(type = "category", categories = unique(vaccines$year))








