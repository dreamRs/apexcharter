# Synchronize charts with each other

``` r
library(apexcharter)
data("economics", package = "ggplot2")
```

## Synchronize charts

With [Apexcharts](https://apexcharts.com) you can sync (tooltip, zoom)
several charts together by providing a common id in `synchronize`
argument. This works in Shiny and Markdown. Here an example where we
create two charts, tooltip will be displayed on both charts when you
hover one, and if you zoom on one, the other one will be synced :

``` r
apex(
  data = tail(economics, 150), 
  mapping = aes(x = date, y = pce),
  type = "line", 
  synchronize = "economics"
) %>% 
  ax_yaxis(
    decimalsInFloat = 0,
    labels = list(
      formatter = format_num("~s"),
      minWidth = 40
    )
  ) %>%
  ax_tooltip(x = list(format = "yyyy"))

apex(
  data = tail(economics, 150), 
  mapping = aes(x = date, y = psavert),
  type = "line", 
  synchronize = "economics"
) %>% 
  ax_yaxis(
    decimalsInFloat = 0,
    labels = list(
      formatter = format_num("~s"),
      minWidth = 40
    )
  ) %>%
  ax_tooltip(x = list(format = "yyyy"))
```

Note that you have to set a common `minWidth` for y axis labels.
Different width yaxis in different charts will produce incorrect results
when hovering or interacting.

For an example in Shiny, you can run:

``` r
run_sync_demo()
```

## Brush chart

Create a brush chart to navigate into a synced chart : use the chart
below to navigate in the chart above.

``` r
apex(
  data = economics, 
  mapping = aes(x = date, y = psavert),
  type = "line"
) %>% 
  ax_chart(
    id = "target-chart", # <-- define target id here
    toolbar = list(
      autoSelected = "pan",
      show = FALSE
    )
  )

apex(
  data = economics, 
  mapping = aes(x = date, y = psavert),
  type = "line", 
  height = "130px"
) %>% 
  ax_chart(
    brush = list(
      target = "target-chart", # <-- use target id here
      enabled = TRUE
    ),
    offsetY = -20,
    selection = list(
      enabled = TRUE, # <-- enable selection and define starting range
      xaxis = list(
        min = format_date(economics$date[1]),
        max = format_date(economics$date[100])
      )
    )
  ) %>% 
  ax_xaxis(labels = list(show = FALSE)) %>% 
  ax_yaxis(labels = list(show = FALSE))
```
