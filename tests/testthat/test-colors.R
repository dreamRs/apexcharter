test_that("ax_colors_manual works", {
  ax1 <- apex(
    data = mtcars, 
    type = "scatter",
    mapping = aes(x = wt, y = mpg, fill = cyl)
  ) %>% 
    ax_colors_manual(list(
      "4" = "steelblue",
      "6" = "firebrick",
      "8" = "forestgreen"
    ))
  ax2 <- apex(
    data = mtcars, 
    type = "scatter",
    mapping = aes(x = wt, y = mpg, fill = cyl)
  ) %>% 
    ax_colors_manual(list(
      "4" = "steelblue",
      "8" = "forestgreen",
      "6" = "firebrick"
    ))
  expect_is(ax1$x$ax_opts$colors, "list")
  expect_length(ax1$x$ax_opts$colors, 3)
  expect_identical(ax1$x$ax_opts$colors, ax2$x$ax_opts$colors)
  
  
  ax <- apex(
    data = mtcars, 
    type = "scatter",
    mapping = aes(x = wt, y = mpg, fill = cyl)
  )
  expect_error(ax_colors_manual(ax, c("red", "blue", "green")))
  expect_error(ax_colors_manual(ax, c(a = "red", b = "blue", "green")))
  expect_error(ax_colors_manual(apexchart(), list(a = "red", b = "blue", b = "green")))
  expect_error(ax_colors_manual(list(), list(a = "red", b = "blue", b = "green")))
})
