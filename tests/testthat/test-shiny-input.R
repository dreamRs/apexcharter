context("shiny-input")

test_that("ununlist works", {
  
  bar_single <- list("Aug")
  bar_multiple <- list("May", "Jun")
  bar_series_single <- list(Y = list("Apr"))
  bar_series_multiple <- list(`Y-1` = list("Mar"), Y = list("Apr"))
  pie <- list("Yes")
  ts <- list(-2.97216e+11)
  scatter_single <- list(x = list(5.345), y = list(14.7))
  scatter_multiple <- list(x = list(3.19, 3.845), y = list(24.4, 19.2))
  scatter_series_multiple <- list(
    setosa = list(x = list(5.2), y = list(3.5)),
    versicolor = list(x = list(5.4, 5.2), y = list(3L, 2.7))
  )
  scatter_series_single <- list(virginica = list(x = list(7.2), y = list(3.6)))
  heatmap_single <- list(Lyon = list("Jul"))
  heatmap_multiple <- list(Paris = list("May"), Marseille = list("May"), Lyon = list("Nov"))
  
  
  
  expect_is(ununlist(bar_single), "character")
  expect_length(ununlist(bar_single), 1)
  expect_is(ununlist(bar_multiple), "character")
  expect_length(ununlist(bar_multiple), 2)
  
  expect_is(ununlist(bar_series_single), "list")
  expect_is(ununlist(bar_series_single)[[1]], "character")
  
})

test_that("to_posix works", {
  
  expect_is(to_posix(-2.97216e+11), "POSIXct")
  
})


test_that("set_input_click works", {
  
  ax <- apexchart(list()) %>% 
    set_input_click("ID")
  
  expect_is(ax, "apexcharter")
  expect_is(ax$x$ax_opts$states, "list")
  expect_is(ax$x$shinyEvents$click, "list")
})


test_that("set_input_zoom works", {
  
  ax <- apexchart(list()) %>% 
    set_input_zoom("ID")
  
  expect_is(ax, "apexcharter")
  expect_is(ax$x$shinyEvents$zoomed, "list")
})


test_that("set_input_selection works", {
  
  ax <- apexchart(list()) %>% 
    set_input_selection("ID")
  
  expect_is(ax, "apexcharter")
  expect_is(ax$x$ax_opts$chart$selection, "list")
  expect_is(ax$x$shinyEvents$selection, "list")
})

