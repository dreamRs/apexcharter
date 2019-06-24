
#  ------------------------------------------------------------------------
#
# Title : apexcharter examples - UNHCR
#    By : Victor
#  Date : 2018-10-29
#
#  ------------------------------------------------------------------------




# Package -----------------------------------------------------------------

library("apexcharter")
library("dplyr")




# Data --------------------------------------------------------------------

data("unhcr_popstats_2017")
head(unhcr_popstats_2017)




# Categories of people of concerns ----------------------------------------

categories_unhcr <- count(unhcr_popstats_2017, population_type, sort = TRUE)

apexchart() %>% 
  ax_chart(type = "bar") %>% 
  ax_plotOptions(bar = bar_opts(
    horizontal = TRUE,
    dataLabels = list(
      position = "center"
    ))
  ) %>% 
  ax_grid(
    show = TRUE,
    yaxis = list(lines = list(show = FALSE)),
    xaxis = list(lines = list(show = TRUE))
  ) %>% 
  ax_series(list(
    name = "Number of persons of concern",
    data = categories_unhcr$n
  )) %>% 
  ax_colors("#112446") %>% 
  ax_xaxis(categories = categories_unhcr$population_type) %>% 
  ax_xaxis(title = list(text = "Number of persons of concern")) %>% 
  ax_title(text = "UNHCR's populations of concern in 2017") %>% 
  ax_subtitle(text = "Data from the UN Regugee Agency")






# Origin & Residence Refugees ---------------------------------------------

refugees <- unhcr_popstats_2017 %>% 
  filter(
    population_type %in% "Refugees (incl. refugee-like situations)",
    !is.na(continent_origin)
  ) 


apexchart() %>% 
  ax_chart(type = "bar", stacked = FALSE) %>% 
  ax_dataLabels(enabled = FALSE) %>% 
  ax_series(
    list(
      name = "Residence", 
      data = refugees %>% 
        count(continent_residence, wt = value) %>% 
        pull(n)
    ),
    list(
      name = "Origin", 
      data = refugees %>% 
        count(continent_origin, wt = value)
      %>% pull(n)
    )
  ) %>% 
  ax_colors("#58224f", "#b65165") %>% 
  ax_stroke(show = TRUE, width = 1, colors = list("#FFF")) %>% 
  ax_xaxis(
    categories = refugees %>% 
      distinct(continent_origin) %>% 
      arrange(continent_origin) %>% 
      pull(continent_origin)
  ) %>% 
  ax_yaxis(
    labels = list(
      formatter = htmlwidgets::JS(
        "function(val) {return val.toLocaleString();}"
      )
    )
  ) %>% 
  ax_tooltip(shared = TRUE) %>% 
  ax_legend(
    position = "right",
    verticalAlign = "top"
  ) %>% 
  ax_title(text = "Refugees Origin & Residence by continent in 2017") %>% 
  ax_subtitle(text = "Data from the UN Regugee Agency")





# Type of populations of concerns by continent ----------------------------

count(unhcr_popstats_2017, continent = continent_residence, population_type, wt = value)

apexchart() %>% 
  ax_chart(type = "bar", stacked = TRUE, stackType = "100%") %>% 
  ax_plotOptions(bar = barOpts(horizontal = TRUE)) %>% 
  ax_series(
    list(
      name = "Asylum-seekers",
      data = unhcr_popstats_2017 %>% 
        filter(population_type == "Asylum-seekers") %>% 
        count(continent_residence, wt = value) %>% 
        pull(n)
    ),
    list(
      name = "Refugees (incl. refugee-like situations)",
      data = unhcr_popstats_2017 %>% 
        filter(population_type == "Refugees (incl. refugee-like situations)") %>% 
        count(continent_residence, wt = value) %>% 
        pull(n)
    ),
    list(
      name = "Internally displaced persons",
      data = unhcr_popstats_2017 %>% 
        filter(population_type == "Internally displaced persons") %>% 
        count(continent_residence, wt = value) %>% 
        tidyr::complete(continent_residence = unique(unhcr_popstats_2017$continent_residence), fill = list(n = 0)) %>%  # No Oceania !
        pull(n)
    ),
    list(
      name = "Stateless persons",
      data = unhcr_popstats_2017 %>% 
        filter(population_type == "Stateless persons") %>% 
        count(continent_residence, wt = value) %>% 
        pull(n)
    )
  ) %>% 
  ax_xaxis(categories = sort(unique(unhcr_popstats_2017$continent_residence))) %>% 
  ax_yaxis(min = 0, max = 100,
           tickAmount = 4) %>% 
  ax_xaxis(
    labels = list(
      formatter = htmlwidgets::JS(
        "function(val) {return val + '%';}"
      )
    )
  ) %>%
  ax_tooltip(shared = TRUE)












