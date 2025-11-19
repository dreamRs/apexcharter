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

{"x":{"ax_opts":{"series":[{"name":"rnorm","data":[0.7244334519512985,2.353944770689133,-0.281449684750734,-0.4810464361743014,0.07922592451094837,0.7698603301565562,0.5633369597055415,-0.3739875238520353,-0.6013055590774279,-0.4241750346400814]}]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
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

{"x":{"ax_opts":{"series":[{"name":"rnorm 1","data":[-0.8723158810813945,0.1066846148710722,-0.5870139852536841,-0.327853587243666,-0.08536101311654855,-2.052403886558835,0.1507482487054995,-0.2928727373503494,0.2549975903292815,-0.5532381891373644]},{"name":"rnorm 2","data":[1.40510887982263,-0.7954609493377846,-1.566514465235918,-1.040579110913482,1.019933742774586,-0.7020819780360608,0.9733157769613821,-0.07681765263310057,0.8929249244775755,-0.7775030884578271]}]},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false},"evals":[],"jsHooks":[]}
```
