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
  
  ax <- set_scale(apexchart(), 1:100, scales = "fixed", axis = "y")
  expect_true(!is.null(ax$x$ax_opts$yaxis))
  expect_true(!is.null(ax$x$ax_opts$yaxis$min))
  expect_true(!is.null(ax$x$ax_opts$yaxis$max))
  
  ax <- set_scale(apexchart(), 1:100, scales = "free", axis = "y")
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


test_that("ax_facet_grid works", {
  
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


