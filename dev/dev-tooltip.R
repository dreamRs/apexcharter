
library(htmltools)

tooltip_template <- tags$div(
  style = "font-family: Helvetica, Arial, sans-serif; font-size: 12px;",
  tags$div(
    class = "apexcharts-tooltip-title",
    tags$span(
      style = "height: 15px;width: 15px;border-radius: 50%;display: inline-block; background-color: {{serie_color}};"
    ),
    "Species: {{group}}"
  ),
  tags$div(
    style = "padding: 7px;",
    tags$div(
      class = "apexcharts-tooltip-text",
      tags$div("X: {{x}}"),
      tags$div("Y: {{y}}"),
      tags$div("Custom: {{custom}}")
    )
  )
)


apex(
  data = iris, 
  mapping = aes(
    x = Sepal.Length,
    y = Sepal.Width, 
    color = Species,
    custom = paste(Petal.Length, Petal.Width, sep = " - ")
  ), 
  type = "scatter"
) %>% 
  ax_colors(RColorBrewer::brewer.pal(n = 3, name = "Dark2")) %>% 
  ax_tooltip(custom = JS(sprintf(
    "function({ series, seriesIndex, dataPointIndex, w }) {
    console.log(w.config.series[seriesIndex].rdata);
    var source = '%s';
    var template = Handlebars.compile(source);
    var data = w.config.series[seriesIndex].rdata[dataPointIndex];
    data.serie_color = w.globals.colors[seriesIndex];
    var result = template(data);
    return(result);
    }", gsub(doRenderTags(tooltip_template), pattern = "\\n", replacement = "")
  )))









template <- tags$div(
  style = "font-family: Helvetica, Arial, sans-serif; font-size: 12px;",
  tags$div(
    class = "apexcharts-tooltip-title",
    "Date: {{x}}"
  ),
  tags$div(
    style = "padding: 7px; font-weight: 700; color: {{serie_color}};",
    "{{group}} : {{y}}"
  ),
  tags$div(
    "Custom date: {{date_custom}}"
  )
)

data("economics_long", package = "ggplot2")
economics_long <- economics_long %>% 
  group_by(variable) %>% 
  slice((n()-100):n())

apex(
  data = economics_long,
  type = "line",
  mapping = aes(x = date, y = value01, group = variable, date_custom = format(date, format = "%b %Y"))
) %>% 
  ax_yaxis(decimalsInFloat = 2) %>% 
  ax_tooltip(shared = FALSE, custom = JS(sprintf(
    "function({ series, seriesIndex, dataPointIndex, w }) {
    //console.log(w);
    var source = '%s';
    var template = Handlebars.compile(source);
    var data = w.config.series[seriesIndex].rdata[dataPointIndex];
    data.serie_color = w.globals.colors[seriesIndex];
    var result = template(data);
    return(result);
    }", gsub(doRenderTags(template), pattern = "\\n", replacement = "")
  )))


apex(
  data = economics_long,
  type = "line",
  mapping = aes(x = date, y = value01, group = variable)
) %>% 
  ax_yaxis(decimalsInFloat = 2) %>% 
  ax_tooltip(shared = FALSE, custom = JS(
    "function({ series, seriesIndex, dataPointIndex, w }) {
    console.log(w.config.series[seriesIndex].rdata);
    return 'a';
    }"
  ))



