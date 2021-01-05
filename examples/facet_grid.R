library(apexcharter)

# Scatter ----

data("mpg", package = "ggplot2")

# Only rows
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_grid(rows = vars(drv), chart_height = "200px")

# Only cols
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_grid(cols = vars(year))

# Rows and Cols
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_grid(rows = vars(drv), cols = vars(year))

apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_grid(vars(drv), vars(cyl))
