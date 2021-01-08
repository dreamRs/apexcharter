test_that("set_tooltip_fixed works", {
  ax <- apex(
    data = mtcars, 
    mapping = aes(x = cyl),
    type = "column"
  ) %>% 
    set_tooltip_fixed()
  
  expect_is(ax, "apex")
  expect_is(ax$x$ax_opts$tooltip$fixed, "list")
  expect_true(ax$x$ax_opts$tooltip$fixed$enabled)
})
