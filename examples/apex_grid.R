library(apexcharter)
data("mpg", package = "ggplot2")

# Two chart side-by-side 
a1 <- apex(mpg, aes(manufacturer), type = "bar")

a2 <- apex(mpg, aes(trans), type = "column")

apex_grid(a1, a2, height = "400px")


# More complex layout:
a3 <- apex(mpg, aes(drv), type = "pie")

apex_grid(
  a1, a2, a3, 
  grid_area = c("1 / 1 / 3 / 2", "1 / 2 / 2 / 4", "2 / 2 / 3 / 4"),
  ncol = 3, nrow = 2,
  height = "600px"
)
