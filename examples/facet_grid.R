
### Grid --------
if (interactive()) {
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
    ax_chart(toolbar = list(show = FALSE)) %>% 
    ax_facet_grid(vars(drv), vars(cyl))
  
  
  # Labels
  apex(mpg, aes(displ, cty), type = "scatter") %>% 
    ax_facet_grid(
      vars(drv),
      labeller = function(x) {
        switch(
          x,
          "f" = "front-wheel drive", 
          "r" = "rear wheel drive",
          "4" = "4wd"
        )
      }
    )
  
  
  # Title and subtitle are treated as global
  apex(mpg, aes(displ, cty), type = "scatter") %>% 
    ax_labs(
      title = "Facet grid example",
      subtitle = "mpg data from ggplot2"
    ) %>% 
    ax_facet_grid(rows = vars(drv), cols = vars(year))
  
}
