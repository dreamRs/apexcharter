## code to prepare `elec-data` dataset goes here



# Packages ----------------------------------------------------------------

library(data.table)
library(lubridate)
library(rte.data)
library(apexcharter)




# Consumption & forecast --------------------------------------------------

consumption <- get_consumption(
  resource = "short_term", 
  type = c("REALISED", "D-1"), 
  start_date = "2020-01-01",
  end_date = "2020-03-01"
)

apex(consumption, aes(start_date, value, group = type), "line")


consumption <- consumption[, list(value = round(sum(value) / 4000)), by = list(date = as_date(start_date), type)]
consumption[type == "REALISED", type := "Realised"]
consumption[type == "D-1", type := "Forecast D-1"]

apex(consumption, aes(date, value, group = type), "line")

consumption <- as.data.frame(consumption)
usethis::use_data(consumption, overwrite = TRUE)





# Actual generation -------------------------------------------------------

actual_generation <- get_actual_generation(
  resource = "actual_generations_per_production_type", 
  start_date = "2017-06-12",
  end_date = "2017-06-13"
)




