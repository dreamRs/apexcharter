test_that("spark_box works", {
  spark_data <- data.frame(
    date = Sys.Date() + 1:20,
    var1 = round(rnorm(20, 50, 10)),
    var2 = round(rnorm(20, 50, 10)),
    var3 = round(rnorm(20, 50, 10))
  )
  
  sb <- spark_box(
    data = spark_data,
    title = mean(spark_data$var1), 
    subtitle = "Variable 1"
  )
  
  expect_is(sb, "apexcharter")
  expect_true(!identical(sb$x$sparkbox, FALSE))
})
