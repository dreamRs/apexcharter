context("test-apex-options")

test_that("events_opts works", {
  
  opts <- events_opts(click = "", beforeMount = "", mounted = "")
  
  expect_is(opts, "list")
  expect_named(opts)
})

test_that("bar_opts works", {
  
  opts <- bar_opts(horizontal = TRUE, endingShape = "flat")
  
  expect_is(opts, "list")
  expect_named(opts)
})

test_that("heatmap_opts works", {
  
  opts <- heatmap_opts(radius = 20, enableShades = TRUE)
  
  expect_is(opts, "list")
  expect_named(opts)
})

test_that("pie_opts works", {
  
  opts <- pie_opts(size = 4, donut = TRUE)
  
  expect_is(opts, "list")
  expect_named(opts)
})

test_that("radialBar_opts works", {
  
  opts <- radialBar_opts(size = 4, inverseOrder = TRUE)
  
  expect_is(opts, "list")
  expect_named(opts)
})

