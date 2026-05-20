# Add data to a chart

Add data to a chart

## Usage

``` r
ax_series(ax, ...)

ax_series2(ax, l)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- ...:

  Lists containing data to plot, typically list with two items: `name`
  and `data`.

- l:

  A list.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Examples

``` r

# One serie
apexchart() %>% 
  ax_series(list(
    name = "rnorm",
    data = rnorm(10)
  ))

{"x":{"ax_opts":{"series":[{"name":"rnorm","data":[1.969424843410351,0.463174706888703,-0.8561524259895877,0.6480432853289468,0.07580395979082789,0.4917614404956936,-0.7535407057758068,0.3490273528349259,-0.1708489717643287,1.631206007177528]}]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
# Two series
apexchart() %>% 
  ax_series(
    list(
      name = "rnorm 1",
      data = rnorm(10)
    ),
    list(
      name = "rnorm 2",
      data = rnorm(10)
    )
  )

{"x":{"ax_opts":{"series":[{"name":"rnorm 1","data":[-0.7827060412768373,-0.002893626081960659,0.4132392923107007,0.7244334519512985,2.353944770689133,-0.281449684750734,-0.4810464361743014,0.07922592451094837,0.7698603301565562,0.5633369597055415]},{"name":"rnorm 2","data":[-0.3739875238520353,-0.6013055590774279,-0.4241750346400814,-0.8723158810813945,0.1066846148710722,-0.5870139852536841,-0.327853587243666,-0.08536101311654855,-2.052403886558835,0.1507482487054995]}]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
```
