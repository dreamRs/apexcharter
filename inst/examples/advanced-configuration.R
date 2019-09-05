


library(apexcharter)
library(dplyr)





# Bar ---------------------------------------------------------------------

data("mpg", package = "ggplot2")

count(mpg, class) %>% 
  mutate(pct = n/sum(n)) %>% 
  apex(mapping = aes(class, pct), type = "column") %>% 
  ax_colors("#617a89") %>% 
  ax_labs(
    title = "Seminal ggplot2 column chart example with percents",
    subtitle = "Example taken from {hrbrthemes} readme"
  ) %>% 
  ax_yaxis(
    title = list(text = "Weight (tons)"),
    labels = list(
      formatter = JS(
        "function(value) {return Math.round(value * 100) + '%';}"
      )
    ), 
    tickAmount = 6
  ) %>% 
  ax_tooltip(
    y = list(
      title = list(
        formatter = JS("function() {return 'Percentage';}")
      )
    )
  ) %>% 
  ax_xaxis(
    title = list(text = "Fuel efficiency (mpg)")
  ) %>% 
  ax_title(
    style = list(fontSize = "22px")
  ) %>% 
  ax_subtitle(
    style = list(fontSize = "16px", color = "#BDBDBD")
  )






# Line --------------------------------------------------------------------

data("economics_long", package = "ggplot2")

economics_long %>% 
  filter(variable %in% c("psavert", "uempmed")) %>% 
  mutate(variable = case_when(
    variable == "psavert" ~ "Personal savings rate",
    variable == "uempmed" ~ "Median duration of unemployment (in weeks)"
  )) %>% 
  apex(aes(date, value, group = variable), type = "line") %>% 
  ax_legend(position = "bottom") %>% 
  ax_stroke(width = 1) %>% 
  ax_colors("firebrick", "forestgreen") %>% 
  ax_yaxis(
    min = 0, max = 30,
    tickAmount = 6,
    labels = list(
      formatter = htmlwidgets::JS("function(val) {return val.toFixed(0);}")
    )
  ) %>% 
  ax_xaxis(type = "datetime", labels = list(format = "d MMM yy")) %>% 
  ax_tooltip(x = list(format = "dd MMM yyyy")) %>% 
  ax_labs(
    title = "US economic time series",
    subtitle = "economics dataset from {ggplot2}"
  ) %>% 
  ax_title(
    style = list(fontSize = "22px")
  ) %>% 
  ax_subtitle(
    style = list(fontSize = "16px", color = "#BDBDBD")
  )





# Scatter -----------------------------------------------------------------

data("gapminder", package = "gapminder")


gapminder %>% 
  filter(year == 2007) %>% 
  mutate(
    gdpPercap = log(gdpPercap),
    pop = sqrt(pop/pi)/1500
  ) %>% 
  apex(mapping = aes(gdpPercap, lifeExp, z = pop, group = continent, label = country), type = "scatter") %>% 
  ax_chart(zoom = list(
    enabled = TRUE, type = "xy"
  )) %>% 
  ax_yaxis(decimalsInFloat = 0, axisBorder = list(show = TRUE), axisTicks = list(show = TRUE)) %>% 
  ax_xaxis(tickAmount = 8, tooltip = list(enabled = FALSE)) %>% 
  ax_grid(xaxis = list(lines = list(show = TRUE))) %>% 
  ax_legend(position = "right") %>% 
  ax_markers(hover = list(sizeOffset = 0, size = 25)) %>% 
  ax_tooltip(custom = JS(paste(
    "function({ series, seriesIndex, dataPointIndex, w }) {",
    "console.log(w); return (",
    "'<div>' +",
    
    "'<div class = \"apexcharts-tooltip-title\">' +",
    "w.config.series[seriesIndex].data[dataPointIndex].label",
    "+ '</div>' +",
    "'<div style = \"padding: 5px;\">' +",
    "'<div class = \"apexcharts-tooltip-y-group\">' +",
    
    "'<span class = \"apexcharts-tooltip-text-label\">' +",
    "'Population: ' +", 
    "'</span>' +",
    "'<span class = \"apexcharts-tooltip-text-value\">' +",
    "Math.round(Math.pow(w.config.series[seriesIndex].data[dataPointIndex].z * 1500, 2) * Math.PI).
    toString().replace(/\\B(?=(\\d{3})+(?!\\d))/g, \",\") +",
    "'</span>' +",
    
    "'</br>' +",
    
    "'<span class = \"apexcharts-tooltip-text-label\">' +",
    "'GDP per capita: ' +", 
    "'</span>' +",
    "'<span class = \"apexcharts-tooltip-text-value\">' +",
    "Math.round(Math.exp(w.config.series[seriesIndex].data[dataPointIndex].x)) +",
    "'</span>' +",
    
    "'</br>' +",
    
    "'<span class = \"apexcharts-tooltip-text-label\">' +",
    "'Life expectancy: ' +", 
    "'</span>' +",
    "'<span class = \"apexcharts-tooltip-text-value\">' +",
    "w.config.series[seriesIndex].data[dataPointIndex].y +",
    "'</span>' +",
    
    
    "'</div>' +",
    "'</div>' +",
    
    "'</div>'",
    ");",
    "}", sep = "\n"
  )))







# Heatmap -----------------------------------------------------------------

data("vaccines", package = "highcharter")

apex(vaccines, aes(year, state, fill = count), type = "heatmap") %>% 
  ax_chart(animations = list(enabled = FALSE)) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_legend(
    formatter = JS(
      "function(seriesName, opts) {
      if (seriesName == 'Missing') return null; else return seriesName;
      }"
    )
  ) %>% 
  ax_stroke(width = 0) %>% 
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
  ax_annotations(
    xaxis = list(
      list(
        x = 1963, x2 = 1963.1,
        strokeDashArray = 0, 
        opacity = 1, 
        borderColor = "firebrick",
        fillColor = "firebrick",
        label = list(
          borderColor = "firebrick",
         
          style = list(color = "#FFF", background = "firebrick"),
          text = "Vaccine Intoduced", 
          orientation = "horizontal",
          position = "bottom",
          offsetY = 10
        )
      )
    )
  ) %>% 
  ax_labs(
    title = "Infectious Diseases and Vaccines",
    subtitle = "vaccines dataset from {highcharter}"
  ) %>% 
  ax_title(
    style = list(fontSize = "22px")
  ) %>% 
  ax_subtitle(
    style = list(fontSize = "16px", color = "#BDBDBD")
  )

