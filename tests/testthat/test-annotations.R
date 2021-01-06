test_that("add_shade works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_shade(from = "2020-01-06", to = "2020-01-20")
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$xaxis, "list")
})


test_that("add_shade_weekend works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_shade_weekend()
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$xaxis, "list")
})


test_that("add_event works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_event(when = c("2020-01-11", "2020-01-29"))
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$xaxis, "list")
})


test_that("add_event_marker works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_event_marker(when = "2020-01-22", y = 1805)
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$points, "list")
})


test_that("add_hline works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_hline(value = 2100)
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$yaxis, "list")
})


test_that("add_vline works", {
  
  ax <- apex(consumption, aes(date, value, group = type), "spline") %>% 
    add_vline(value = 2100)
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$xaxis, "list")
})


test_that("add_point works", {
  
  ax <- apex(
    data = iris,
    aes(Sepal.Length, Sepal.Width),
    "scatter"
  ) %>% 
    add_point(
      x = mean(iris$Sepal.Length),
      y = mean(iris$Sepal.Width)
    )
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$annotations, "list")
  expect_is(ax$x$ax_opts$annotations$points, "list")
})



test_that("label & marker works", {
  
  expect_is(label(), "list")
  expect_is(marker(), "list")
})

