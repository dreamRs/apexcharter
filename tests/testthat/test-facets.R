test_that("get_facets works for wrap 1 variable", {
  
  facet <- get_facets(mtcars, vars(cyl), NULL)
  
  expect_is(facet, "list")
  expect_length(facet, 5)
  expect_is(facet$facets, "list")
  expect_length(facet$facets, length(unique(mtcars$cyl)))
})

test_that("get_facets works for wrap 2 variables", {
  
  facet <- get_facets(mtcars, vars(cyl, vs), NULL)
  
  expect_is(facet, "list")
  expect_length(facet, 5)
  expect_is(facet$facets, "list")
  expect_length(facet$facets, length(unique(mtcars$cyl)) * length(unique(mtcars$vs)))
})

test_that("get_facets works for grid 2 variables", {
  
  facet <- get_facets(mtcars, vars(cyl), vars(vs), "grid")
  
  expect_is(facet, "list")
  expect_length(facet, 5)
  expect_is(facet$facets, "list")
  expect_length(facet$facets, length(unique(mtcars$cyl)) * length(unique(mtcars$vs)))
  expect_identical(facet$nrow, length(unique(mtcars$cyl)))
  expect_identical(facet$ncol, length(unique(mtcars$vs)))
  expect_identical(facet$label_row, as.character(sort(unique(mtcars$cyl))))
  expect_identical(facet$label_col, as.character(sort(unique(mtcars$vs))))
})



test_that("set_scale works", {
  
  ax <- set_scale(apexchart(), 1:100, scales = "fixed", axis = "x")
  expect_true(!is.null(ax$x$ax_opts$xaxis))
  expect_true(!is.null(ax$x$ax_opts$xaxis$min))
  expect_true(!is.null(ax$x$ax_opts$xaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "free", axis = "x")
  expect_true(is.null(ax$x$ax_opts$xaxis))
  expect_true(is.null(ax$x$ax_opts$xaxis$min))
  expect_true(is.null(ax$x$ax_opts$xaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "free_x", axis = "x")
  expect_true(is.null(ax$x$ax_opts$xaxis))
  expect_true(is.null(ax$x$ax_opts$xaxis$min))
  expect_true(is.null(ax$x$ax_opts$xaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "fixed", axis = "y")
  expect_true(!is.null(ax$x$ax_opts$yaxis))
  expect_true(!is.null(ax$x$ax_opts$yaxis$min))
  expect_true(!is.null(ax$x$ax_opts$yaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "free", axis = "y")
  expect_true(is.null(ax$x$ax_opts$yaxis))
  expect_true(is.null(ax$x$ax_opts$yaxis$min))
  expect_true(is.null(ax$x$ax_opts$yaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "free_y", axis = "y")
  expect_true(is.null(ax$x$ax_opts$yaxis))
  expect_true(is.null(ax$x$ax_opts$yaxis$min))
  expect_true(is.null(ax$x$ax_opts$yaxis$max))
})



test_that("ax_facet_wrap works", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_wrap(vars(cyl))
  
  expect_is(ax, "apex")
  expect_is(ax, "apex_facet")
  expect_true(!is.null(ax$x$facet))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_identical(facet$type, "wrap")
  expect_length(facet$facets, length(unique(mtcars$cyl)))
  
  TAG <- build_facet_tag(ax)
  expect_is(TAG, "shiny.tag")
})


test_that("ax_facet_grid works with row", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_grid(vars(cyl))
  
  expect_is(ax, "apex")
  expect_is(ax, "apex_facet")
  expect_true(!is.null(ax$x$facet))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_identical(facet$type, "grid")
  expect_length(facet$facets, length(unique(mtcars$cyl)))
  
  TAG <- build_facet_tag(ax)
  expect_is(TAG, "shiny.tag")
})


test_that("ax_facet_grid works with row and col", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_grid(vars(cyl), vars(carb))
  
  expect_is(ax, "apex")
  expect_is(ax, "apex_facet")
  expect_true(!is.null(ax$x$facet))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_identical(facet$type, "grid")
  expect_length(facet$facets, length(unique(mtcars$cyl)) * length(unique(mtcars$carb)))
  
  TAG <- build_facet_tag(ax)
  expect_is(TAG, "shiny.tag")
})



test_that("global title and subtitle works", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_grid(vars(cyl), vars(carb))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_null(facet$title)
  expect_null(facet$subtitle)
  
  ax <- ax  %>%
    ax_labs(
      title = "this is a title",
      subtitle = "this is a subtitle"
    )
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_is(facet$title, "list")
  expect_is(facet$subtitle, "list")
  
  TAG <- build_facet_tag(ax)
  TAG <- htmltools::doRenderTags(TAG)
  expect_true(grepl(pattern = "apexcharter-facet-subtitle", x = TAG))
  expect_true(grepl(pattern = "apexcharter-facet-title", x = TAG))
})


test_that("axis title works (grid)", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_grid(vars(cyl), vars(carb))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_null(facet$xaxis_title)
  expect_null(facet$yaxis_title)
  
  ax <- ax  %>%
    ax_labs(
      x = "x axis title",
      y = "y axis title"
    )
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_is(facet$xaxis_title, "list")
  expect_is(facet$yaxis_title, "list")
  
  TAG <- build_facet_tag(ax)
  TAG <- htmltools::doRenderTags(TAG)
  expect_true(grepl(pattern = "apexcharter-facet-yaxis-title", x = TAG))
  expect_true(grepl(pattern = "apexcharter-facet-xaxis-title", x = TAG))
})


test_that("axis title works (wrap)", {
  
  ax <- apex(mtcars, aes(disp, wt), type = "scatter") %>% 
    ax_facet_wrap(vars(cyl, carb))
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_null(facet$xaxis_title)
  expect_null(facet$yaxis_title)
  
  ax <- ax  %>%
    ax_labs(
      x = "x axis title",
      y = "y axis title"
    )
  
  facet <- build_facets(ax)
  expect_is(facet, "list")
  expect_is(facet$xaxis_title, "list")
  expect_is(facet$yaxis_title, "list")
  
  TAG <- build_facet_tag(ax)
  TAG <- htmltools::doRenderTags(TAG)
  expect_true(grepl(pattern = "apexcharter-facet-yaxis-title", x = TAG))
  expect_true(grepl(pattern = "apexcharter-facet-xaxis-title", x = TAG))
})



test_that("complete_mapdata works", {
  
  cmd <- complete_mapdata(
    mapdata = list(x = c("April", "June", "September"), y = 1:3),
    mapall = list(x = month.name)
  )
  
  expect_is(cmd, "list")
  expect_length(cmd$x, 12)
  expect_identical(cmd$x, month.name)
})

test_that("complete_data works", {
  
  cd <- complete_data(
    data = data.frame(
      var1 = c("a", "a", "b", "b", "c"),
      var2 = c("A", "B", "A", "C", "A"),
      value = 1:5
    ),
    vars = c("var1", "var2"),
    fill_var = "value",
    fill_value = 0
  )
  
  expect_is(cd, "data.frame")
})



test_that("apexfacetOutput works", {
  
  TAG <- apexfacetOutput("facet")
  
  expect_is(TAG, "shiny.tag.list")
  expect_true(length(htmltools::findDependencies(TAG)) > 0)
})



test_that("get_yaxis_serie works", {
  mydata <- data.frame(
    x = 1:10,
    y = c(1:5, (16:20) * 10),
    fill = rep(c("a", "b"), each = 5)
  )
  ax <- apex(mydata, aes(x, y), "line")
  expect_equal(get_yaxis_serie(ax, 1), c(1:5, (16:20) * 10))
  
  ax <- apex(mydata, aes(x, y, fill = fill), "line")
  expect_equal(get_yaxis_serie(ax, 1), c(1:5, (16:20) * 10))
  
  ax <- apex(mydata, aes(x, y, fill = fill), "line") %>% 
    ax_yaxis(title = list(text = "Y1")) %>% 
    ax_yaxis2(title = list(text = "Y2"))
  expect_equal(get_yaxis_serie(ax, 1), c(1:5))
  expect_equal(get_yaxis_serie(ax, 2), c((16:20) * 10))
})