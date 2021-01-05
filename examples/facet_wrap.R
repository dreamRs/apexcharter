### Wrap --------
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
  ax_facet_wrap(vars(year, drv), ncol = 2, nrow = 3)

apex(mpg, aes(displ, cty), type = "scatter") %>% 
  ax_chart(toolbar = list(show = FALSE)) %>% 
  ax_facet_wrap(
    vars(year, drv),
    labeller = function(x) {
      paste(x, collapse = " / ")
    }
  )



# Lines ----

data("unhcr_ts")
refugees <- unhcr_ts %>% 
  subset(population_type == "Refugees (incl. refugee-like situations)") %>% 
  transform(date = as.Date(paste0(year, "-01-01")))


apex(refugees, aes(date, n), type = "line") %>% 
  ax_yaxis(tickAmount = 5) %>% 
  ax_facet_wrap(vars(continent_origin))
  


# Free y-axis and synchronize
apex(refugees, aes(date, n), type = "line", synchronize = "my-id") %>% 
  ax_yaxis(tickAmount = 5) %>% 
  ax_xaxis(tooltip = list(enabled = FALSE)) %>% 
  ax_tooltip(x = list(format = "yyyy")) %>% 
  ax_facet_wrap(vars(continent_origin), scales = "free_y")
  


# Bars ----

data("unhcr_ts")
refugees <- unhcr_ts %>% 
  subset(year == 2017)

apex(refugees, aes(continent_origin, n), type = "column") %>% 
  ax_yaxis(
    labels = list(
      formatter = format_num("~s")
    ),
    tickAmount = 5
  ) %>% 
  ax_facet_wrap(vars(population_type), ncol = 2)


