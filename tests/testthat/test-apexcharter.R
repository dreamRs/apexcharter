context("apexcharter")

test_that("apexchart works", {
  
  ax <- apexchart(list())
  expect_is(ax, "apexcharter")
})


test_that("add_locale_apex works", {
  
  ax <- apexchart(list(chart = list(defaultLocale = "fr"))) %>% 
    add_locale_apex
  expect_is(ax, "apexcharter")
  expect_is(ax$x$ax_opts$chart$locales, "list")
})

