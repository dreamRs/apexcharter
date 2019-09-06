


library(apexcharter)
library(dplyr)





# Bar ---------------------------------------------------------------------

data("mpg", package = "ggplot2")

count(mpg, class) %>% 
  mutate(pct = n/sum(n)) %>% 
  apex(mapping = aes(class, pct), type = "column") %>% 
  ax_colors("#617a89")%>% 
  ax_yaxis(
    title = list(text = "Weight (tons)"),
    labels = list(
      formatter = JS(
        "function(value) {return Math.round(value * 100) + '%';}"
      )
    ), 
    tickAmount = 6
  ) %>% 
  ax_xaxis(
    title = list(text = "Fuel efficiency (mpg)")
  ) %>% 
  ax_tooltip(
    y = list(
      title = list(
        formatter = JS("function() {return 'Percentage';}")
      )
    )
  ) %>% 
  ax_labs(
    title = "Seminal ggplot2 column chart example with percents",
    subtitle = "Example taken from {hrbrthemes} readme"
  )  %>% 
  ax_title(
    style = list(fontSize = "22px")
  ) %>% 
  ax_subtitle(
    style = list(fontSize = "16px", color = "#BDBDBD")
  )






# Line --------------------------------------------------------------------


data("unhcr_ts")

unhcr_ts %>% 
  filter(population_type == "Refugees (incl. refugee-like situations)") %>% 
  mutate(date = as.Date(paste0(year, "-01-01"))) %>% 
  apex(aes(date, n, group = continent_origin), type = "line") %>% 
  ax_legend(position = "bottom") %>% 
  ax_stroke(width = 2) %>% 
  ax_colors("#440154", "#414487", "#2A788E",
            "#22A884", "#7AD151", "#FDE725") %>%
  ax_yaxis(
    labels = list(
      formatter = JS("function(val) {return (val/1e6).toFixed(0);}")
    ),
    title = list(text = "Number of refugees (in million)")
  ) %>% 
  ax_xaxis(labels = list(format = "yyyy")) %>% 
  ax_tooltip(
    x = list(format = "yyyy"),
    y = list(
      formatter = JS(
        # thousand separator in javascript
        "function(value) {return value.toString().replace(/\\B(?=(\\d{3})+(?!\\d))/g, \",\");}"
      )
    )
  ) %>% 
  ax_annotations(
    points = list(
      list(
        x = JS("new Date('1994').getTime()"),
        y = 6935296,
        label = list(text = "Great Lakes refugee crisis", offsetY = 0),
        marker = list(size = 6)
      )
    )
  ) %>% 
  ax_labs(
    title = "Continent of origin for refugees population",
    subtitle = "Data from the UN Refugee Agency"
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
    pop = sqrt(pop / pi) / 1500
  ) %>% 
  apex(mapping = aes(gdpPercap, lifeExp, z = pop, group = continent, label = country), type = "scatter") %>% 
  ax_chart(zoom = list(
    enabled = TRUE, type = "xy"
  )) %>% 
  ax_yaxis(
    decimalsInFloat = 0, 
    axisBorder = list(show = TRUE),
    axisTicks = list(show = TRUE),
    title = list(text = "life expectancy at birth (in years)")
  ) %>% 
  ax_xaxis(
    tickAmount = 8,
    labels = list(
      formatter = JS("function(val) {return val.toFixed(2);}")
    ),
    tooltip = list(enabled = FALSE),
    title = list(text = "GDP per capita (log-scale)")
  ) %>% 
  ax_grid(xaxis = list(lines = list(show = TRUE))) %>% 
  ax_legend(position = "right", offsetY = 70) %>% 
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
  ))) %>% 
  ax_labs(
    title = "Life expectancy, GDP and population",
    subtitle = "gapminder dataset from {gapminder}"
  ) %>% 
  ax_title(
    style = list(fontSize = "22px")
  ) %>% 
  ax_subtitle(
    style = list(fontSize = "16px", color = "#BDBDBD")
  )







# Heatmap -----------------------------------------------------------------

data("vaccines", package = "highcharter")

apex(vaccines, aes(year, state, fill = count), type = "heatmap") %>% 
  ax_chart(animations = list(enabled = FALSE)) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
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
  ax_legend(
    formatter = JS(
      "function(seriesName, opts) {
      if (seriesName == 'Missing') return null; else return seriesName;
      }"
    )
  ) %>% 
  ax_yaxis(
    labels = list(
      style = list(fontSize = "8px"),
      offsetY = -20
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

