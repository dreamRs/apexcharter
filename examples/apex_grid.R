library(apexcharter)
data("mpg", package = "ggplot2")

# Two chart side-by-side 
a1 <- mpg %>% 
  dplyr::count(manufacturer) %>%
  apex(aes(manufacturer, n), type = "bar")

a2 <- mpg %>% 
  dplyr::count(trans) %>%
  apex(aes(trans, n), type = "column")

apex_grid(a1, a2, height = "400px")


# More complex layout:
a3 <- mpg %>% 
  dplyr::count(drv) %>%
  apex(aes(drv, n), type = "pie")

apex_grid(
  a1, a2, a3, 
  grid_area = c("1 / 1 / 3 / 2", "1 / 2 / 2 / 4", "2 / 2 / 3 / 4"),
  ncol = 3, nrow = 2,
  height = "600px"
)
