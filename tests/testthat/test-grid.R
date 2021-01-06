test_that("apex_grid works", {
  
  ax <- apex_grid(
    apexchart(), 
    apexchart(), 
    apexchart(), 
    apexchart(), 
    grid_area = c("1 / 1 / 3 / 2", "1 / 2 / 2 / 4", "2 / 2 / 3 / 4", "2 / 2 / 3 / 4"),
    ncol = 2, nrow = 2,
    height = "600px"
  )
  expect_is(ax, "apex_grid")
})
