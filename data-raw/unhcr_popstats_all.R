
#  ------------------------------------------------------------------------
#
# Title : UNHCR - Persons of concerns (All)
#    By : Victor
#  Date : 2018-10-29
#
#  ------------------------------------------------------------------------




# Package -----------------------------------------------------------------

library("data.table")
library("janitor")
library("ggplot2")




# Data --------------------------------------------------------------------

# http://popstats.unhcr.org/en/persons_of_concern/https://goo.gl/rcTJPz

unhcr_popstats <- fread(
  input = "data-raw/unhcr_popstats_export_time_series_all_data.csv", 
  skip = 3, 
  na.strings = "*", 
  encoding = "UTF-8"
)
unhcr_popstats <- clean_names(unhcr_popstats)
unhcr_popstats





# Get Continent -----------------------------------------------------------

wrld <- rnaturalearth::countries110@data
setDT(wrld)

continents <- merge(
  x = unique(rbind(
    unique(unhcr_popstats[, list(country = country_territory_of_asylum_residence)]),
    unique(unhcr_popstats[, list(country = origin)])
  )),
  y = wrld[, list(country = name_long, iso_a2, iso_a3, continent)],
  all.x = TRUE
)

table(continents$continent, useNA = "a")

# Missing ones
cat(
  paste(sprintf(
    "continents[country == \"%s\", `:=`(iso_a2 = \"\", iso_a3 = \"\", continent = \"\")]", 
    continents$country[is.na(continents$continent)]
  ), collapse = "\n")
)

continents[country == "Anguilla", `:=`(iso_a2 = "AI", iso_a3 = "AIA", continent = "South America")]
continents[country == "Antigua and Barbuda", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Aruba", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "Bahrain", `:=`(iso_a2 = "BH", iso_a3 = "BHR", continent = "Asia")]
continents[country == "Barbados", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Bolivia (Plurinational State of)", `:=`(iso_a2 = "BO", iso_a3 = "", continent = "South America")]
continents[country == "Bonaire", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "British Virgin Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Cabo Verde", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Cayman Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Central African Rep.", `:=`(iso_a2 = "CF", iso_a3 = "CAF", continent = "Africa")]
continents[country == "China, Hong Kong SAR", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "China, Macao SAR", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Comoros", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Congo", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "CuraÃ§ao", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "Curaçao", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "Czech Rep.", `:=`(iso_a2 = "CZ", iso_a3 = "CZE", continent = "Europe")]
continents[country %like% "Ivoire", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Dem. People's Rep. of Korea", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Dem. Rep. of the Congo", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Dominican Rep.", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "French Guiana", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "Gambia", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Grenada", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Iran (Islamic Rep. of)", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Lao People's Dem. Rep.", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Liechtenstein", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Malta", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Mauritius", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Micronesia (Federated States of)", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Monaco", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Montserrat", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Nauru", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Palau", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Rep. of Korea", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Rep. of Moldova", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Saint Kitts and Nevis", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Saint Lucia", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Saint Vincent and the Grenadines", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Samoa", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Serbia and Kosovo (S/RES/1244 (1999))", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Seychelles", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
continents[country == "Singapore", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Sint Maarten (Dutch part)", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "State of Palestine", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Syrian Arab Rep.", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "The former Yugoslav Republic of Macedonia", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Tonga", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Turks and Caicos Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "United Rep. of Tanzania", `:=`(iso_a2 = "TZ", iso_a3 = "", continent = "Africa")]
continents[country == "United States of America", `:=`(iso_a2 = "US", iso_a3 = "USA", continent = "North America")]
continents[country == "Venezuela (Bolivarian Republic of)", `:=`(iso_a2 = "", iso_a3 = "", continent = "South America")]
continents[country == "Viet Nam", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]

continents[country == "American Samoa", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Andorra", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Bermuda", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Cook Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Dominica", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "French Polynesia", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Gibraltar", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Guadeloupe", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Guam", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
# continents[country == "Holy See (the)", `:=`(iso_a2 = "", iso_a3 = "", continent = "")]
continents[country == "Kiribati", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Maldives", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Marshall Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Martinique", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "Niue", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Norfolk Island", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
continents[country == "Palestinian", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Saint-Pierre-et-Miquelon", `:=`(iso_a2 = "", iso_a3 = "", continent = "North America")]
continents[country == "San Marino", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Sao Tome and Principe", `:=`(iso_a2 = "", iso_a3 = "", continent = "Africa")]
# continents[country == "Stateless", `:=`(iso_a2 = "", iso_a3 = "", continent = "")]
continents[country == "Svalbard and Jan Mayen", `:=`(iso_a2 = "", iso_a3 = "", continent = "Europe")]
continents[country == "Tibetan", `:=`(iso_a2 = "", iso_a3 = "", continent = "Asia")]
continents[country == "Tuvalu", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]
# continents[country == "Various/Unknown", `:=`(iso_a2 = "", iso_a3 = "", continent = "")]
continents[country == "Wallis and Futuna Islands", `:=`(iso_a2 = "", iso_a3 = "", continent = "Oceania")]

table(continents$continent, useNA = "a")

# origin
unique(unhcr_popstats$origin)[!unique(unhcr_popstats$origin) %in% continents$country]



unhcr_popstats <- merge(
  x = unhcr_popstats, y = continents[, list(country, continent_residence = continent)],
  by.x = "country_territory_of_asylum_residence", by.y = "country"
)

unhcr_popstats <- merge(
  x = unhcr_popstats, y = continents[, list(country, continent_origin = continent)],
  by.x = "origin", by.y = "country"
)






# Timeserie by continent --------------------------------------------------

unhcr_ts <- unhcr_popstats[!is.na(continent_origin), list(
  n = sum(value, na.rm = TRUE)
), by = list(year, population_type, continent_origin)]

setorder(unhcr_ts, continent_origin, population_type, year)



unhcr_ts[, population_type := stringi::stri_trans_general(str = population_type, id = "ASCII-Latin")]
unhcr_ts[, continent_origin := stringi::stri_trans_general(str = continent_origin, id = "ASCII-Latin")]


unhcr_ts <- as.data.frame(unhcr_ts)

usethis::use_data(unhcr_ts, overwrite = TRUE)





# Use data 2017 -----------------------------------------------------------


setnames(unhcr_popstats, "origin", "country_origin")
setnames(unhcr_popstats, "country_territory_of_asylum_residence", "country_residence")

unhcr_popstats[, country_residence := stringi::stri_trans_general(str = country_residence, id = "ASCII-Latin")]
unhcr_popstats[, country_origin := stringi::stri_trans_general(str = country_origin, id = "ASCII-Latin")]


unhcr_popstats_2017 <- unhcr_popstats[year == 2017, -c("year")]

# head(unhcr_popstats_2017)

# utils::promptData(object = unhcr_popstats_2017, filename = "tmp.Rd")

unhcr_popstats_2017[, country_origin := stringi::stri_trans_general(str = country_origin, id = "ASCII-Latin")]
unhcr_popstats_2017[, country_residence := stringi::stri_trans_general(str = country_residence, id = "ASCII-Latin")]
unhcr_popstats_2017[, population_type := stringi::stri_trans_general(str = population_type, id = "ASCII-Latin")]
unhcr_popstats_2017[, continent_residence := stringi::stri_trans_general(str = continent_residence, id = "ASCII-Latin")]
unhcr_popstats_2017[, continent_origin := stringi::stri_trans_general(str = continent_origin, id = "ASCII-Latin")]

unhcr_popstats_2017 <- as.data.frame(unhcr_popstats_2017)
usethis::use_data(unhcr_popstats_2017, overwrite = TRUE)




# Explo -------------------------------------------------------------------


unhcr_popstats[year == 2017, list(total_population = sum(value, na.rm = TRUE)), by = continent_residence]
unhcr_popstats[year == 2017, list(total_population = sum(value, na.rm = TRUE)), by = continent_origin]
unhcr_popstats[year == 2017, list(total_population = sum(value, na.rm = TRUE)), by = list(continent_origin, continent_residence)]

ggplot(data = unhcr_popstats[year == 2017, list(total_population = sum(value, na.rm = TRUE)), by = continent_residence]) +
  geom_col(aes(x = continent_residence, y = total_population))

ggplot(data = unhcr_popstats[year == 2017, list(total_population = sum(value, na.rm = TRUE)), by = continent_origin]) +
  geom_col(aes(x = continent_origin, y = total_population))



ggplot(data = rbind(
  unhcr_popstats[year == 2017 & population_type %like% "^Refugees",
                 list(total_population = sum(value, na.rm = TRUE), type = "from"), 
                 by = list(continent = continent_origin)],
  unhcr_popstats[year == 2017 & population_type %like% "^Refugees", 
                 list(total_population = sum(value, na.rm = TRUE), type = "to"), 
                 by = list(continent = continent_residence)]
)) +
  geom_col(aes(x = continent, y = total_population, fill = type), position = "dodge")




unhcr_popstats[year == 2017, list(value = sum(value, na.rm = TRUE)), by = population_type]
ggplot(data = unhcr_popstats[year == 2017, list(value = sum(value, na.rm = TRUE)), by = population_type]) + 
  geom_col(aes(x = population_type, y = value))


unhcr_popstats[year == 2017, list(value = sum(value, na.rm = TRUE)), by = list(population_type, continent_residence)]



