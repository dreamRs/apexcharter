library(apexcharter)

# Scatter ----

data("mpg", package = "ggplot2")

# Create facets
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(vars(drv))

# Change number of columns
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(vars(drv), ncol = 2)

# Free axis
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(vars(drv), ncol = 2, scales = "free")

# labels
apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(
    vars(drv), ncol = 2,
    labeller = function(x) {
      switch(
        x,
        "f" = "front-wheel drive", 
        "r" = "rear wheel drive",
        "4" = "4wd"
      )
    }
  )


# Multiple variables

apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(vars(year, drv))

apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_facet_wrap(
    vars(year, drv),
    labeller = function(x) {
      paste(x, collapse = " / ")
    }
  )



# Lines ----

data("unhcr_ts")

unhcr_ts %>% 
  subset(population_type == "Refugees (incl. refugee-like situations)") %>% 
  apex(aes(as.Date(paste0(year, "-01-01")), n), type = "line") %>% 
  ax_yaxis(tickAmount = 5) %>% 
  ax_facet_wrap(vars(continent_origin))



