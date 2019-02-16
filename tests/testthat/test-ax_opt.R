context("test-ax_opt")

test_that("ax_opt works", {
  
  opts <- structure(list(
    x = list(ax_opts = list(
      chart = list(type  ="bar")
    ))
  ), class = c("list", "apexcharter"))
  
  new_opts <- .ax_opt(opts, "series", data = 1:3)
  
  expect_length(new_opts$x$ax_opts, 2)
  expect_named(new_opts$x$ax_opts, c("chart", "series"))
  expect_identical(new_opts$x$ax_opts$series$data, 1:3)
})


test_that("ax_opt update existing parameter", {
  
  opts <- structure(list(
    x = list(ax_opts = list(
      chart = list(type  ="bar")
    ))
  ), class = c("list", "apexcharter"))
  
  new_opts <- .ax_opt(opts, "chart", type = "line")
  
  expect_length(new_opts$x$ax_opts, 1)
  expect_named(new_opts$x$ax_opts, c("chart"))
  expect_identical(new_opts$x$ax_opts$chart$type, "line")
})

test_that("ax_opt2 works", {
  
  opts <- structure(list(
    x = list(ax_opts = list(
      chart = list(type  ="bar")
    ))
  ), class = c("list", "apexcharter"))
  
  new_opts <- .ax_opt2(opts, "series", list(data = 1:3))
  new_opts <- .ax_opt2(new_opts, "chart", list(type = "line"))
  
  expect_length(new_opts$x$ax_opts, 2)
  expect_named(new_opts$x$ax_opts, c("chart", "series"))
  expect_identical(new_opts$x$ax_opts$series$data, 1:3)
  expect_identical(new_opts$x$ax_opts$chart$type, "line")
})

