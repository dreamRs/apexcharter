
#  ------------------------------------------------------------------------
#
# Title : UNCHR - Persons of concerns (France)
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

unhcr_popstats_fr <- fread(
  input = "data-raw/unhcr_popstats_export_persons_of_concern_2018_10_29_143107.csv", 
  skip = 3, 
  na.strings = "*"
)
unhcr_popstats_fr <- clean_names(unhcr_popstats_fr)
unhcr_popstats_fr





# Origin countries of refugees in 2017 ------------------------------------


# excluding "Various/Unknown"
unhcr_fr_2017 <- unhcr_popstats_fr[origin != "Various/Unknown" & year == 2017, list(
  origin, 
  refugees = refugees_incl_refugee_like_situations,
  asylum_seekers = asylum_seekers_pending_cases,
  total_population
)]


unhcr_fr_2017[order(total_population, decreasing = TRUE)][1:10]
ggplot(data = unhcr_fr_2017[order(total_population, decreasing = TRUE)][1:10]) +
  geom_col(aes(x = origin, y = total_population))









