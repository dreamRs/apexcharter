test_that("add_line only works with apex and certain type", {
  
  expect_error(apexchart() %>% add_line(aes(month, temperature)))
  expect_error(apexchart() %>% add_smooth_line())
  
  expect_error(apex(mtcars, aes(x = cyl), type = "pie") %>% add_line(aes(month, temperature)))
  expect_error(apex(mtcars, aes(x = cyl), type = "pie") %>% add_smooth_line())
})


test_that("add_line works with column chart", {
  
  ax <- apex(climate_paris, aes(month, precipitation), type = "column") %>% 
    add_line(aes(month, temperature))
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$series, "list")
  expect_length(ax$x$ax_opts$series, 2)
})


test_that("add_line works with scatter chart", {
  
  ax <- apex(cars, aes(speed, dist), type = "scatter") %>% 
    add_line(aes(x, y), data = lowess(cars), serie_name = "lowess")
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$series, "list")
  expect_length(ax$x$ax_opts$series, 2)
})


test_that("add_smooth_line works with scatter chart", {
  
  ax <- apex(cars, aes(speed, dist), type = "scatter") %>% 
    add_smooth_line(model = "loess", span = 1)
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$series, "list")
  expect_length(ax$x$ax_opts$series, 2)
  
  ax <- apex(cars, aes(speed, dist), type = "scatter") %>% 
    add_smooth_line(model = "lm")
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$series, "list")
  expect_length(ax$x$ax_opts$series, 2)
})

