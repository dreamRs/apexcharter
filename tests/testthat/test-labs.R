context("labs")

test_that("ax_labs works", {
  
  title <- apexchart() %>% 
    ax_labs(title = "TITLE")
  
  expect_identical(title$x$ax_opts$title$text, "TITLE")
  
  subtitle <- apexchart() %>% 
    ax_labs(subtitle = "SUBTITLE")
  
  expect_identical(subtitle$x$ax_opts$subtitle$text, "SUBTITLE")
  
  xlab <- apexchart() %>% 
    ax_labs(x = "XLAB")
  
  expect_identical(xlab$x$ax_opts$xaxis$title$text, "XLAB")
  
  ylab <- apexchart() %>% 
    ax_labs(y = "YLAB")
  
  expect_identical(ylab$x$ax_opts$yaxis$title$text, "YLAB")
})
