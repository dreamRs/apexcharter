# Use in Shiny application

``` r
library(apexcharter)
```

## Charts

### Create and update (or destroy and re-create)

When a graph has been generated in Shiny, if the values change (via a
reactive function), the graph is *not regenerated*, only the data is
*updated*. If you have changed specific options in the graphic (such as
maximum y axis value, chart’s title, …) these will not be updated. This
behavior can be controlled with `auto_update` argument (available in
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
and [`apex()`](https://dreamrs.github.io/apexcharter/reference/apex.md))
:

By default, `auto_update` is `TRUE` :

``` r
apex(..., auto_update = TRUE)
```

If you want to re-create the whole chart, set the option to `FALSE`:

``` r
apex(..., auto_update = FALSE)
```

You can also use
[`config_update()`](https://dreamrs.github.io/apexcharter/reference/config_update.md)
to specify what to update :

``` r
apex(..., auto_update = config_update(update_options = TRUE))
```

### Proxy

A proxy is also implemented to update charts manually server-side. You
can update data:

``` r
output$my_chart <- renderApexchart({
  apex(data = isolate(data_reactive()), ..., auto_update = FALSE)
})

observeEvent(input$update, {
  apexchartProxy("my_chart") %>% 
    ax_proxy_series(data_reactive())
})
```

Be sure to use
[`shiny::isolate()`](https://rdrr.io/pkg/shiny/man/isolate.html) to
block any reactivity in `renderApexchart` function and to set
`auto_update` to FALSE to prevent updating twice. Then you can use in an
observe function (or any reactive function)
[`apexchartProxy()`](https://dreamrs.github.io/apexcharter/reference/apexchartProxy.md)
with the output id to get the chart instance and
[`ax_proxy_series()`](https://dreamrs.github.io/apexcharter/reference/ax_proxy_series.md)
to update data.

If you want to update chart’s options, use :

``` r
observeEvent(input$update, {
  apexchartProxy("my_chart") %>% 
    ax_proxy_options(list(
      title = list(
        text = "New title"
      ),
      xaxis = list(
        max = NEW_VALUE
      )
    ))
})
```

## Interactions

### Click

Click on a chart to select a data point and retrieve value server side
with
[`set_input_click()`](https://dreamrs.github.io/apexcharter/reference/set_input_click.md)
:

``` r
data.frame(
  month = month.abb,
  value = sample(1:100, 12)
) %>% 
  apex(aes(month, value), height = "250px") %>% 
  ax_title("Click a bar:") %>% 
  set_input_click("click")
```

Value server-side will be available through `input$click`.

Depending on the type of graphic, you can retrieve :

- **bar and column:** category (x-axis).
- **pie and donut:** label.
- **time-series:** retrieve x-axis value, you have to display markers
  with size \> 0 and set tooltip’s options `intersect = TRUE` and
  `shared = FALSE`.
- **scatter:** retrieve XY coordinates.

Multiple selection is possible and you can change the darken effect of
selected bars :

``` r
data.frame(
  month = month.abb,
  value = sample(1:100, 12)
) %>% 
  apex(aes(month, value), height = "250px") %>% 
  ax_title("Click several bars:") %>% 
  set_input_click(
    inputId = "click", 
    multiple = TRUE, 
    effect_value = 0.1
  )
```

More examples are available with:

``` r
run_demo_input("click")
```

### Zoom

Retrieve the coordinates of the axes when the graph is zoomed in:

``` r
data("economics", package = "ggplot2")
apex(economics, aes(date, psavert), type = "line", height = "250px") %>% 
  set_input_zoom("zoom")
```

Value server-side will be available through `input$zoom` under the form
:

    #> $x
    #> $x$min
    #> [1] "1981-10-24 15:41:16 UTC"
    #> 
    #> $x$max
    #> [1] "1992-01-24 06:40:22 UTC"
    #> 
    #> 
    #> $y
    #> $y$min
    #> NULL
    #> 
    #> $y$max
    #> NULL

Here values for `y` are `NULL` because zoom is only possible on x-axis,
but for a scatter chart for example you can zoom on both axis.

More examples are available with:

``` r
run_demo_input("zoom")
```

### Selection

Retrieve the coordinates of the axes when user select an area on a chart
(without zooming):

``` r
apex(economics, aes(date, psavert), type = "line", height = "250px") %>% 
  set_input_selection("selection")
```

Value server-side will be available through `input$selection` under the
form :

    #> $x
    #> $x$min
    #> [1] "1981-10-24 15:41:16 UTC"
    #> 
    #> $x$max
    #> [1] "1992-01-24 06:40:22 UTC"

You can define a selected area at start:

``` r
apex(economics, aes(date, psavert), type = "line", height = "250px") %>% 
  set_input_selection(
    inputId = "selection", 
    xmin = format_date("1980-01-01"), 
    xmax = format_date("1985-01-01")
  )
```

Above selection is only made possible on x-axis, but in case of scatter
chart for example, you can select a rectangle (both axis):

``` r
apex(iris, aes(Sepal.Length, Sepal.Width), type = "scatter", height = "250px") %>% 
  set_input_selection("selection_scatter", type = "xy")
```

In this case, input value will look like this:

    #> $x
    #> $x$min
    #> [1] 5.130187
    #> 
    #> $x$max
    #> [1] 5.541228
    #> 
    #> 
    #> $y
    #> $y$min
    #> [1] 2.959623
    #> 
    #> $y$max
    #> [1] 3.860357

More examples are available with:

``` r
run_demo_input("selection")
```
