test_that("multiplication works", {
  fmt <- format_num("~s")
  expect_is(fmt, "JS_EVAL")
  expect_error(format_num(".0f", locale = "DONT_EXIST"))
})
