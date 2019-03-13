context("test-parse_df")

test_that("parse_df works", {
  
  x <- head(iris)
  res <- parse_df(x)
  
  expect_is(res, "list")
  expect_length(res, nrow(x))
  expect_length(res[[1]], ncol(x))
  expect_named(res[[1]], NULL)
})

test_that("parse_df works with names", {
  
  x <- head(iris)
  res <- parse_df(x, add_names = TRUE)
  
  expect_is(res, "list")
  expect_length(res, nrow(x))
  expect_length(res[[1]], ncol(x))
  expect_named(res[[1]], names(x))
})


test_that("parse_df works with custom names", {
  
  x <- head(iris)
  custom <- LETTERS[1:5]
  res <- parse_df(x, add_names = custom)
  
  expect_is(res, "list")
  expect_length(res, nrow(x))
  expect_length(res[[1]], ncol(x))
  expect_named(res[[1]], custom)
})


test_that("parse_df works with Date/POSIXt", {
  
  x <- data.frame(
    date = Sys.Date() + 1:5,
    datetime = Sys.time() + 1:5
  )
  res <- parse_df(x, add_names = TRUE)
  
  expect_is(res[[1]]$date, "character")
  expect_is(res[[1]]$datetime, "numeric")
  
  res <- parse_df(x, add_names = FALSE)
  expect_is(res[[1]][[1]], "character")
  expect_is(res[[1]][[2]], "numeric")
})


