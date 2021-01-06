context("apex")

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
  
  candlestick <- apex(
    candles, 
    aes(x = datetime, open = open, close = close, low = low, high = high),
    type = "candlestick"
  )
  expect_is(candlestick, "apexcharter")
  expect_identical(candlestick$x$ax_opts$chart$type, "candlestick")
  expect_false(is.null(candlestick$x$ax_opts$series))
  
  tl <- data.frame(
    x = month.abb,
    start = Sys.Date() + 1:12,
    end = Sys.Date() + 1:12 * 3
  )
  timeline <- apex(tl, aes(x = x, start = start, end = end), "timeline")
  expect_is(timeline, "apexcharter")
  expect_identical(timeline$x$ax_opts$chart$type, "rangeBar")
  expect_false(is.null(timeline$x$ax_opts$series))
  
  
  hm <- expand.grid(year = 2000:2010, month = month.name)
  hm$value <- sample.int(1e4, nrow(hm))
  heatmap <- apex(
    data = hm,
    type = "heatmap", 
    mapping = aes(x = year, y = month, fill = value)
  ) %>% 
    ax_dataLabels(enabled = FALSE) %>% 
    ax_colors("#008FFB")
  expect_is(heatmap, "apexcharter")
  expect_identical(heatmap$x$ax_opts$chart$type, "heatmap")
  expect_false(is.null(heatmap$x$ax_opts$series))
})



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

test_that("make_series works with group (iris)", {
  mapping <- aes(x = Sepal.Length, y = Sepal.Width, fill = Species)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = iris)
  serie <- make_series(mapdata, mapping)
  expect_is(serie, "list")
  expect_length(serie, 3)
  expect_length(serie[[1]], 2)
  expect_named(serie[[1]], c("name", "data"))
  
  expect_identical(
    lapply(serie, function(x) {
      length(x$data)
    }),
    as.list(unlist(tapply(mapdata$fill, mapdata$fill, length, simplify = FALSE), use.names = FALSE))
  )
})


test_that("make_series works with group (mtcars)", {
  mapping <- aes(x = mpg, y = disp, fill = cyl)
  mapdata <- lapply(mapping, rlang::eval_tidy, data = mtcars)
  expect_warning(
    serie <- make_series(mapdata, mapping)
  )
  expect_is(serie, "list")
  expect_length(serie, 3)
  expect_length(serie[[1]], 2)
  expect_named(serie[[1]], c("name", "data"))
  
  expect_identical(
    lapply(serie, function(x) {
      length(x$data)
    }),
    as.list(unlist(tapply(mapdata$fill, factor(mapdata$fill, levels = unique(mapdata$fill)), length, simplify = FALSE), use.names = FALSE))
  )
})



test_that("compute count", {
  ax <- apex(data = mtcars, type = "column", mapping = aes(x = vs))
  expect_is(ax, "apex")
  
  ax <- apex(data = mtcars, type = "column", mapping = aes(x = vs, fill = gear))
  expect_is(ax, "apex")
})

