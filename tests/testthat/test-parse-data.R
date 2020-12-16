context("parse-data")

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
  
  expect_is(res[[1]]$date, "numeric")
  expect_is(res[[1]]$datetime, "numeric")
  
  res <- parse_df(x, add_names = FALSE)
  expect_is(res[[1]][[1]], "numeric")
  expect_is(res[[1]][[2]], "numeric")
})




test_that("parse_timeline_data work", {
  
  timeline1 <- data.frame(
    x = LETTERS,
    start = Sys.Date() + 1:26,
    end = Sys.Date() + 10 + 1:26
  )
  t1 <- parse_timeline_data(timeline1)
  
  expect_is(t1, "list")
  expect_length(t1, 26)
  
  timeline2 <- data.frame(
    x = LETTERS,
    start = Sys.Date() + 1:26,
    end = Sys.Date() + 10 + 1:26,
    group = rep(c("gr1", "gr2"), each = 13)
  )
  t2 <- parse_timeline_data(timeline2)
  
  expect_is(t2, "list")
  expect_length(t2, 2)
  expect_length(t2[[1]]$data, 13)
})



