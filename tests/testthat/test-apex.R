context("test-apex")

test_that("apex works", {
  
  meteo <- data.frame(
    month = month.name,
    tmax = c(7, 8, 12, 15, 19, 23, 25, 25, 21, 16, 11, 8),
    tmin = c(3, 3, 5, 7, 11, 14, 16, 16, 13, 10, 6, 3)
  )
  
  column <- apex(data = meteo, mapping = aes(x = month, y = tmax), type = "column")
  expect_is(column, "apexcharter")
  expect_identical(column$x$ax_opts$chart$type, "bar")
  expect_false(is.null(column$x$ax_opts$series))
  
  line <- apex(data = meteo, mapping = aes(x = month, y = tmax), type = "line")
  expect_is(line, "apexcharter")
  expect_identical(line$x$ax_opts$chart$type, "line")
  expect_false(is.null(line$x$ax_opts$series))
  
  pie <- apex(data = meteo, mapping = aes(x = month, y = tmax), type = "pie")
  expect_is(pie, "apexcharter")
  expect_identical(pie$x$ax_opts$chart$type, "pie")
  expect_false(is.null(pie$x$ax_opts$series))
})
