
#  ------------------------------------------------------------------------
#
# Title : Paris climate
#    By : Victor
#  Date : 2020-07-24
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(rvest)
library(data.table)
library(janitor)




# Data --------------------------------------------------------------------

tables_list <- read_html(x = "https://fr.wikipedia.org/wiki/Climat_de_Paris") %>%
  html_table(fill = TRUE)


# Temperature
temperature <- tables_list[[1]]
setDT(temperature)
setnames(temperature, make_clean_names)
temperature <- temperature[periode == "1971-2000" & mois == "Température moyenne (°C)"]
temperature[, periode := NULL]
temperature[, annee := NULL]
temperature[, mois := NULL]
setnames(temperature, month.abb)

t_data <- melt(
  data = temperature, 
  measure.vars = names(temperature),
  variable.name = "month",
  value.name = "temperature", 
  variable.factor = FALSE
)
t_data[, temperature := type.convert(temperature, dec = ",")]
t_data


# Precipitation
precipitation <- tables_list[[3]]
setDT(precipitation)
setnames(precipitation, make_clean_names)
precipitation <- precipitation[periode == "1971-2000" & mois == "Précipitations (mm)"]
precipitation[, periode := NULL]
precipitation[, annee := NULL]
precipitation[, mois := NULL]
setnames(precipitation, month.abb)

p_data <- melt(
  data = precipitation, 
  measure.vars = names(precipitation),
  variable.name = "month",
  value.name = "precipitation", 
  variable.factor = FALSE
)
p_data[, precipitation := type.convert(precipitation, dec = ",")]
p_data


climate_paris <- merge(t_data, p_data, by = "month", sort = FALSE)
climate_paris


climate_paris <- as.data.frame(climate_paris)
usethis::use_data(climate_paris, overwrite = TRUE)



# Test chart --------------------------------------------------------------

library(apexcharter)

ax <- apex(climate_paris, aes(month, precipitation), type = "column", serie_name = "Precipitation")
ax$x$ax_opts$series <- c(
  ax$x$ax_opts$series,
  list(list(
    name = "Temperature",
    type = "line",
    data = parse_df(climate_paris[, list(month, temperature)], add_names = c("x", "y"))
  ))
)
ax %>% 
  ax_chart(type = "line") %>% 
  ax_markers(size = c(6, 0)) %>% 
  ax_stroke(width = c(0, 4)) %>% 
  ax_yaxis(
    title = list(text = "Precipitation (in mm)")
  ) %>% 
  ax_yaxis2(
    opposite = TRUE,
    decimalsInFloat = 0,
    title = list(text = "Temperature (in degree celsius)")
  ) %>% 
  ax_dataLabels(
    enabled = TRUE, enabledOnSeries = list(1)
  )




apex(climate_paris, aes(month, precipitation), type = "column", serie_name = "Precipitation") %>% 
  add_line(aes(month, temperature), serie_name = "Temperature")


apex(climate_paris, aes(month, precipitation), type = "column", serie_name = "Precipitation") %>% 
  add_line(aes(month, temperature), data = climate_paris, serie_name = "Temperature") %>% 
  add_line(aes(month, temperature + 5), data = climate_paris, serie_name = "Temperature 2")


