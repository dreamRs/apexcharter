

# Package -----------------------------------------------------------------

library(data.table)
library(gapminder)



# Data --------------------------------------------------------------------

life_expec <- as.data.table(gapminder::gapminder)
life_expec <- life_expec[year %in% c(1972, 2007), list(country, year, lifeExp)]

# life_expec <- life_expec[country %in% sample(unique(country), 10)]
life_expec <- life_expec[country %in% c("Botswana", "Ghana", "Iran", "Liberia", "Malaysia", "Mexico", 
                                        "Nigeria", "Pakistan", "Philippines", "Zambia")]
life_expec <- dcast(life_expec, country ~ year, value.var = "lifeExp")
life_expec[, type := fifelse(`1972` > `2007`, "decreased", "increased")]



# Use data ----------------------------------------------------------------

setDF(life_expec)
usethis::use_data(life_expec, internal = FALSE, overwrite = TRUE, compress = "xz")





# Test example ------------------------------------------------------------


pkgload::load_all()

apex(life_expec, aes(country, x = `1972`, xend = `2007`), type = "dumbbell") %>% 
  ax_plotOptions(
    bar = bar_opts(
      dumbbellColors = list(list("#3d85c6", "#fb6003"))
    )
  ) %>% 
  ax_colors("#BABABA") %>% 
  ax_labs(
    title = "Life expectancy : 1972 vs. 2007",
    subtitle = "Data from Gapminder dataset",
    x = "Life expectancy at birth, in years"
  )



apex(life_expec, aes(country, x = `1972`, xend = `2007`, group = type), type = "dumbbell") %>% 
  ax_xaxis(type = "category", categories = unique(life_expec$country)) %>%
  ax_plotOptions(
    bar = bar_opts(
      dumbbellColors = list(list("#3d85c6", "#fb6003"), list("#3d85c6", "#fb6003"))
    )
  ) %>% 
  ax_colors(c("#3d85c6", "#fb6003")) %>% 
  ax_labs(
    title = "Life expectancy : 1972 vs. 2007",
    subtitle = "Data from Gapminder dataset",
    x = "Life expectancy at birth, in years"
  )

