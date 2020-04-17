context("test-apex-config")

test_that("config_bar works", {
  
  column <- config_bar()
  
  expect_is(column, "list")
  expect_false(column$plotOptions$bar$horizontal)
  
  bar <- config_bar(horizontal = TRUE)
  
  expect_is(bar, "list")
  expect_true(bar$plotOptions$bar$horizontal)
})


test_that("config_line works", {
  
  line <- config_line()
  
  expect_is(line, "list")
  expect_identical(line$stroke$curve, "straight")
  
  spline <- config_line(curve = "spline")
  
  expect_is(spline, "list")
  expect_identical(spline$stroke$curve, "spline")
  
  datetime <- config_line(datetime = TRUE)
  
  expect_is(spline, "list")
  expect_identical(datetime$xaxis$type, "datetime")
})


test_that("config_scatter works", {
  
  scatter <- config_scatter(NULL, NULL)
  
  expect_is(scatter, "list")
  expect_identical(scatter$xaxis$type, "numeric")
})


test_that("config_timeline works", {
  
  timeline <- config_timeline()
  
  expect_is(timeline, "list")
  expect_identical(timeline$xaxis$type, "datetime")
})



test_that("choose_config works", {
  
  mapdata <- list(
    x = c(Sys.Date(), Sys.Date() + 10),
    y = c(1, 10)
  )
  
  expect_identical(choose_config("bar", mapdata), config_bar(horizontal = TRUE))
  expect_identical(choose_config("column", mapdata), config_bar(horizontal = FALSE, datetime = TRUE))
  
  expect_identical(choose_config("line", mapdata), config_line(datetime = TRUE))
  expect_identical(choose_config("area", mapdata), config_line(datetime = TRUE))
  expect_identical(choose_config("spline", mapdata), config_line(curve = "smooth", datetime = TRUE))
  
  expect_identical(choose_config("scatter", mapdata), config_scatter(range_num(mapdata$x), range_num(mapdata$y), datetime = TRUE))
  expect_identical(choose_config("bubble", mapdata), config_scatter(range_num(mapdata$x), range_num(mapdata$y), datetime = TRUE))
  
  expect_identical(choose_config("timeline", mapdata), config_timeline())
  
  expect_identical(choose_config("plop", mapdata), list())
})


