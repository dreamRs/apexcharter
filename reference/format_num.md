# Format numbers (with D3)

Format numbers (with D3)

## Usage

``` r
format_num(format, prefix = "", suffix = "", locale = "en-US", na_label = "-")
```

## Arguments

- format:

  Format for numbers, currency, percentage, e.g. `".0%"` for rounded
  percentage. See online documentation :
  <https://github.com/d3/d3-format>.

- prefix:

  Character string to append before formatted value.

- suffix:

  Character string to append after formatted value.

- locale:

  Localization to use, for example `"fr-FR"` for french, see possible
  values here: <https://github.com/d3/d3-format/tree/master/locale>.

- na_label:

  The label to use when value is `NA`.

## Value

a `JS` function

## Examples

``` r
# Use SI prefix
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(1e4, 2e4)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("~s")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values","type":"bar","data":[{"x":"apex","y":10000},{"x":"charts","y":20000}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"},"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~s')(value) + '';}"}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
apex(dat, aes(labels, values * 100), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("~s")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values * 100","type":"bar","data":[{"x":"apex","y":1000000},{"x":"charts","y":2000000}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"},"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('~s')(value) + '';}"}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}

# Percentage
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(0.45, 0.55)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num(".0%")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values","type":"bar","data":[{"x":"apex","y":0.45},{"x":"charts","y":0.55}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"},"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('.0%')(value) + '';}"}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}

# Currency
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(570, 1170)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("$,.2f")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values","type":"bar","data":[{"x":"apex","y":570},{"x":"charts","y":1170}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"},"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format('$,.2f')(value) + '';}"}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}
# Change locale
apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("$,.2f", locale = "fr-FR")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values","type":"bar","data":[{"x":"apex","y":570},{"x":"charts","y":1170}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"},"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \",\",  \"thousands\": \"\\u00a0\",  \"grouping\": [3],  \"currency\": [\"\", \"\\u00a0\\u20ac\"],  \"percent\": \"\\u202f%\"}')); return '' + locale.format('$,.2f')(value) + '';}"}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.yaxis.labels.formatter"],"jsHooks":[]}


# Customize tooltip value
# Use SI prefix
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(1e4, 2e4)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_tooltip(y = list(
    formatter = format_num(",", suffix = " GW/h")
  ))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":"values","type":"bar","data":[{"x":"apex","y":10000},{"x":"charts","y":20000}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true,"y":{"formatter":"function(value) {if (value === null) return '-'; var locale = formatLocale(JSON.parse('{  \"decimal\": \".\",  \"thousands\": \",\",  \"grouping\": [3],  \"currency\": [\"$\", \"\"]}')); return '' + locale.format(',')(value) + ' GW/h';}"}},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"apex","max":"charts"},"type":"column"},"evals":["ax_opts.tooltip.y.formatter"],"jsHooks":[]}
```
