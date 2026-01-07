#  ------------------------------------------------------------------------
#
# temperature data for France
# https://opendata.enedis.fr/datasets/donnees-de-temperature-et-de-pseudo-rayonnement/
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(data.table)
library(fasttime)


# Data --------------------------------------------------------------------

temperatures <- fread(file = "data-raw/inputs/donnees-de-temperature-et-de-pseudo-rayonnement.csv")
temperatures <- temperatures[, c(6, 7, 8, 2)]
setnames(temperatures, c("year", "month", "day", "temperature"))
temperatures <- temperatures[year > 2017]
temperatures <- temperatures[, list(temperature = round(mean(temperature, na.rm = TRUE), 1)), by = c("year", "month", "day")]
temperatures <- dcast(data = temperatures, formula = month + day ~ year, value.var = "temperature")
temperatures <- temperatures[!(month == 2 & day == 29)]

temperatures[, low := do.call(pmin, c(as.list(.SD), na.rm = TRUE)), .SDcols = as.character(2018:2021)]
temperatures[, high := do.call(pmax, c(as.list(.SD), na.rm = TRUE)), .SDcols = as.character(2018:2021)]
temperatures[, average := rowMeans(.SD, na.rm = TRUE), .SDcols = as.character(2018:2021)]
temperatures[, (as.character(2018:2021)) := NULL]
# setnames(temperatures, "2022", "temperature")

temperatures[, date := as.Date("2022-01-01") + (seq_len(.N) - 1)]
temperatures[, (c("month", "day")) := NULL]
setcolorder(temperatures, "date")

temperatures[]


# Save --------------------------------------------------------------------

setDF(temperatures)
usethis::use_data(temperatures, internal = FALSE, overwrite = TRUE, compress = "xz")



# Test example ------------------------------------------------------------


pkgload::load_all()

apex(temperatures, aes(x = date, ymin = low, ymax = high), type = "rangeArea", serie_name = "Low/High (2018-2021)") %>%
  add_line(aes(date, `2023`)) %>%
  ax_chart(animations = list(enabled = FALSE)) %>%
  ax_yaxis(tickAmount = 7, labels = list(formatter = format_num("~", suffix = "°C"))) %>%
  ax_colors(c("#8485854D", "#FF0000")) %>%
  ax_stroke(width = c(1, 2)) %>%
  ax_fill(opacity = 1, type = "solid") %>%
  ax_labs(
    title = "Temperatures in 2023 with range from 2018 to 2021",
    subtitle = "Data from ENEDIS"
  )



