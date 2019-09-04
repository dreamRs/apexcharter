
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

mtcars_long$value <- round(mtcars_long$value)

test <- apexchart() %>% 
  ax_chart(type = "heatmap") %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series2(lapply(
    X = unique(mtcars_long$model),
    FUN = function(x) {
      list(
        name = tolower(gsub(pattern = "\\s", replacement = "", x = x)),
        data = parse_df(
          data = mtcars_long[mtcars_long$model == x, c("variable", "value")], 
          add_names = c("x", "y")
        )
      )
    }
  )) %>% 
  ax_xaxis(type = "category", categories = unique(mtcars_long$variable))


apexchart() %>% 
  ax_chart(type = "heatmap") %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series2(l = list(
    list(
      name = "A",
      data = list(
        list(x = "a", y = "4"), list(x = "b", y = "2"), list(x = "c", y = "7")
      )
    ),
    list(
      name = "B",
      data = list(
        list(x = "a", y = "5"), list(x = "b", y = "4"), list(x = "c", y = "1")
      )
    )
  ))



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
  ax_legend(
    formatter = JS(
      "function(seriesName, opts) {
      if (seriesName == 'Missing') return null; else return seriesName;
      }"
    )
  ) %>% 
  # ax_colors("#008FFB") %>%
  ax_plotOptions(
    heatmap = heatmap_opts(
      radius = 0,
      enableShades = FALSE,
      colorScale = list(
        ranges = list(
          list(
            from = 0,
            to = 0.001,
            name = "Missing",
            color = "#FFF"
          ),
          list(
            from = 0.001,
            to = 4,
            name = "low",
            # color = "#000004"
            color = "#FDE725"
          ),
          list(
            from = 4,
            to = 70,
            name = "mid-low",
            # color = "#781C6D",
            color = "#35B779"
          ),
          list(
            from = 70,
            to = 290,
            name = "mid-high",
            # color = "#ED6925",
            color = "#31688E"
          ),
          list(
            from = 290,
            to = 3000,
            name = "high",
            # color = "#FCFFA4",
            color = "#440154"
          )
        )
      )
    )
  ) %>%
  ax_xaxis(type = "category", categories = unique(vaccines$year))








