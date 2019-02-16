context("test-apex-utils")

test_that("is_x_datetime works", {
  expect_true(is_x_datetime(list(x = Sys.Date())))
  expect_true(is_x_datetime(list(x = Sys.time())))
  expect_false(is_x_datetime(list(x = letters)))
})


test_that("list1 works", {
  expect_is(list1(1), "list")
  expect_is(list1(1:2), "integer")
  expect_length(list1(1:2), 2)
})


test_that("correct_type works", {
  expect_identical(correct_type("bar"), "bar")
  expect_identical(correct_type("column"), "bar")
  expect_identical(correct_type("line"), "line")
  expect_identical(correct_type("spline"), "line")
  expect_identical(correct_type("pie"), "pie")
})


test_that("make_series works", {
  serie <- make_series(iris, aes(x = Sepal.Length, y = Sepal.Width))
  expect_is(serie, "list")
  expect_length(serie, 1)
  expect_length(serie[[1]], 2)
  expect_named(serie[[1]], c("name", "data"))
})

test_that("make_series works with group", {
  mapping <- aes(x = Sepal.Length, y = Sepal.Width, fill = Species)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = iris)
  serie <- make_series(mapdata, mapping)
  expect_is(serie, "list")
  expect_length(serie, 3)
  expect_length(serie[[1]], 2)
  expect_named(serie[[1]], c("name", "data"))
})



