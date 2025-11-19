# Set specific color's series

Set specific color's series

## Usage

``` r
ax_colors_manual(ax, values)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- values:

  Named list, names represent data series, values colors to use.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r
## scatter

apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "6" = "firebrick",
    "8" = "forestgreen"
  ))

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"6","type":"scatter","data":[{"x":2.62,"y":21},{"x":2.875,"y":21},{"x":3.215,"y":21.4},{"x":3.44,"y":19.2},{"x":3.44,"y":17.8},{"x":3.46,"y":18.1},{"x":2.77,"y":19.7}]},{"name":"4","type":"scatter","data":[{"x":2.32,"y":22.8},{"x":3.19,"y":24.4},{"x":3.15,"y":22.8},{"x":2.2,"y":32.4},{"x":1.615,"y":30.4},{"x":1.835,"y":33.9},{"x":2.465,"y":21.5},{"x":1.935,"y":27.3},{"x":2.14,"y":26},{"x":1.513,"y":30.4},{"x":2.78,"y":21.4}]},{"name":"8","type":"scatter","data":[{"x":3.44,"y":18.7},{"x":3.57,"y":14.3},{"x":3.57,"y":15},{"x":4.07,"y":16.4},{"x":3.73,"y":17.3},{"x":3.78,"y":15.2},{"x":5.25,"y":10.4},{"x":5.424,"y":10.4},{"x":5.345,"y":14.7},{"x":3.52,"y":15.5},{"x":3.435,"y":15.2},{"x":3.84,"y":13.3},{"x":3.845,"y":19.2},{"x":3.17,"y":15.8}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":1,"max":6,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":10,"max":35,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"colors":["firebrick","steelblue","forestgreen"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":1.513,"max":5.424},"type":"scatter","colors_manual":{"4":"steelblue","6":"firebrick","8":"forestgreen"}},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
# If missing level, colors are recycled
apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "8" = "forestgreen"
  ))
#> Warning: Some groups doesn't have a corresponding color value

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"6","type":"scatter","data":[{"x":2.62,"y":21},{"x":2.875,"y":21},{"x":3.215,"y":21.4},{"x":3.44,"y":19.2},{"x":3.44,"y":17.8},{"x":3.46,"y":18.1},{"x":2.77,"y":19.7}]},{"name":"4","type":"scatter","data":[{"x":2.32,"y":22.8},{"x":3.19,"y":24.4},{"x":3.15,"y":22.8},{"x":2.2,"y":32.4},{"x":1.615,"y":30.4},{"x":1.835,"y":33.9},{"x":2.465,"y":21.5},{"x":1.935,"y":27.3},{"x":2.14,"y":26},{"x":1.513,"y":30.4},{"x":2.78,"y":21.4}]},{"name":"8","type":"scatter","data":[{"x":3.44,"y":18.7},{"x":3.57,"y":14.3},{"x":3.57,"y":15},{"x":4.07,"y":16.4},{"x":3.73,"y":17.3},{"x":3.78,"y":15.2},{"x":5.25,"y":10.4},{"x":5.424,"y":10.4},{"x":5.345,"y":14.7},{"x":3.52,"y":15.5},{"x":3.435,"y":15.2},{"x":3.84,"y":13.3},{"x":3.845,"y":19.2},{"x":3.17,"y":15.8}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":1,"max":6,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":10,"max":35,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"colors":["steelblue","forestgreen"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":1.513,"max":5.424},"type":"scatter","colors_manual":{"4":"steelblue","8":"forestgreen"}},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
# Ignore levels not present in data
apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "6" = "firebrick",
    "8" = "forestgreen",
    "99" = "yellow"
  ))

{"x":{"ax_opts":{"chart":{"type":"scatter"},"series":[{"name":"6","type":"scatter","data":[{"x":2.62,"y":21},{"x":2.875,"y":21},{"x":3.215,"y":21.4},{"x":3.44,"y":19.2},{"x":3.44,"y":17.8},{"x":3.46,"y":18.1},{"x":2.77,"y":19.7}]},{"name":"4","type":"scatter","data":[{"x":2.32,"y":22.8},{"x":3.19,"y":24.4},{"x":3.15,"y":22.8},{"x":2.2,"y":32.4},{"x":1.615,"y":30.4},{"x":1.835,"y":33.9},{"x":2.465,"y":21.5},{"x":1.935,"y":27.3},{"x":2.14,"y":26},{"x":1.513,"y":30.4},{"x":2.78,"y":21.4}]},{"name":"8","type":"scatter","data":[{"x":3.44,"y":18.7},{"x":3.57,"y":14.3},{"x":3.57,"y":15},{"x":4.07,"y":16.4},{"x":3.73,"y":17.3},{"x":3.78,"y":15.2},{"x":5.25,"y":10.4},{"x":5.424,"y":10.4},{"x":5.345,"y":14.7},{"x":3.52,"y":15.5},{"x":3.435,"y":15.2},{"x":3.84,"y":13.3},{"x":3.845,"y":19.2},{"x":3.17,"y":15.8}]}],"dataLabels":{"enabled":false},"xaxis":{"type":"numeric","min":1,"max":6,"tickAmount":5,"crosshairs":{"show":true,"stroke":{"dashArray":0}},"labels":{"style":{"colors":"#848484"}}},"yaxis":{"min":10,"max":35,"tickAmount":5,"labels":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~r')(value) + '';}","style":{"colors":"#848484"}},"tooltip":{"enabled":true}},"grid":{"xaxis":{"lines":{"show":true}}},"colors":["firebrick","steelblue","forestgreen"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":1.513,"max":5.424},"type":"scatter","colors_manual":{"4":"steelblue","6":"firebrick","8":"forestgreen","99":"yellow"}},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}


## Bar

tab <- table(sample(letters[1:5], 100, TRUE), sample(LETTERS[1:5], 100, TRUE))
dat <- as.data.frame(tab)

apex(
  data = dat,
  type = "column",
  mapping = aes(x = Var1, y = Freq, group = Var2)
) %>% 
  ax_colors_manual(list(
    A = "steelblue",
    C = "firebrick",
    D = "forestgreen",
    B = "peachpuff",
    E = "chartreuse"
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"A","type":"bar","data":[{"x":"a","y":3},{"x":"b","y":3},{"x":"c","y":4},{"x":"d","y":1},{"x":"e","y":2}]},{"name":"B","type":"bar","data":[{"x":"a","y":4},{"x":"b","y":2},{"x":"c","y":8},{"x":"d","y":6},{"x":"e","y":7}]},{"name":"C","type":"bar","data":[{"x":"a","y":4},{"x":"b","y":3},{"x":"c","y":2},{"x":"d","y":6},{"x":"e","y":3}]},{"name":"D","type":"bar","data":[{"x":"a","y":5},{"x":"b","y":5},{"x":"c","y":2},{"x":"d","y":5},{"x":"e","y":5}]},{"name":"E","type":"bar","data":[{"x":"a","y":6},{"x":"b","y":5},{"x":"c","y":4},{"x":"d","y":5},{"x":"e","y":0}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"colors":["steelblue","peachpuff","firebrick","forestgreen","chartreuse"]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"type":"column","colors_manual":{"A":"steelblue","C":"firebrick","D":"forestgreen","B":"peachpuff","E":"chartreuse"}},"evals":[],"jsHooks":[]}
```
