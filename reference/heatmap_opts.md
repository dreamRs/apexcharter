# Heatmap options

Use these options in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Usage

``` r
heatmap_opts(
  radius = NULL,
  enableShades = NULL,
  shadeIntensity = NULL,
  colorScale = NULL,
  ...
)
```

## Arguments

- radius:

  Numeric. Radius of the rectangle inside heatmap.

- enableShades:

  Logical. Enable different shades of color depending on the value

- shadeIntensity:

  Numeric `[0,1]`. The intensity of the shades generated for each value.

- colorScale:

  List.

- ...:

  Additional parameters.

## Value

A `list` of options that can be used in
[`ax_plotOptions()`](https://dreamrs.github.io/apexcharter/reference/ax_plotOptions.md).

## Note

See <https://apexcharts.com/docs/options/plotoptions/heatmap/>.

## Examples

``` r
df <- expand.grid(
  month = month.name,
  person = c("Obi-Wan", "Luke", "Anakin", "Leia")
)
df$value <- sample(0:1, nrow(df), TRUE)

apex(
  data = df,
  mapping = aes(x = month, y = person, fill = value),
  type = "heatmap"
) %>% 
  ax_plotOptions(
    heatmap = heatmap_opts(
      enableShades = FALSE,
      colorScale = list(
        ranges = list(
          list(from = 0, to = 0.5, color = "#FF0000"),
          list(from = 0.5, to = 1, color = "#088A08")
        )
      )
    )
  )

{"x":{"ax_opts":{"chart":{"type":"heatmap"},"series":[{"name":"Obi-Wan","data":[{"x":"January","y":0},{"x":"February","y":1},{"x":"March","y":0},{"x":"April","y":0},{"x":"May","y":1},{"x":"June","y":0},{"x":"July","y":1},{"x":"August","y":0},{"x":"September","y":1},{"x":"October","y":1},{"x":"November","y":1},{"x":"December","y":1}]},{"name":"Luke","data":[{"x":"January","y":0},{"x":"February","y":0},{"x":"March","y":1},{"x":"April","y":0},{"x":"May","y":0},{"x":"June","y":0},{"x":"July","y":0},{"x":"August","y":0},{"x":"September","y":1},{"x":"October","y":1},{"x":"November","y":1},{"x":"December","y":0}]},{"name":"Anakin","data":[{"x":"January","y":1},{"x":"February","y":0},{"x":"March","y":0},{"x":"April","y":0},{"x":"May","y":1},{"x":"June","y":0},{"x":"July","y":0},{"x":"August","y":1},{"x":"September","y":0},{"x":"October","y":1},{"x":"November","y":0},{"x":"December","y":0}]},{"name":"Leia","data":[{"x":"January","y":1},{"x":"February","y":0},{"x":"March","y":0},{"x":"April","y":1},{"x":"May","y":1},{"x":"June","y":0},{"x":"July","y":0},{"x":"August","y":1},{"x":"September","y":1},{"x":"October","y":1},{"x":"November","y":1},{"x":"December","y":0}]}],"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}}},"plotOptions":{"heatmap":{"enableShades":false,"colorScale":{"ranges":[{"from":0,"to":0.5,"color":"#FF0000"},{"from":0.5,"to":1,"color":"#088A08"}]}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"April","max":"September"},"type":"heatmap"},"evals":[],"jsHooks":[]}  
```
