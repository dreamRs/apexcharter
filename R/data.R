
#' UNHCR data by continent of origin
#'
#' The dataset contains data about UNHCR's populations of concern summarised by continent of origin.
#'
#' @format A data frame with 913 observations and the following 4 variables:
#'   \describe{
#'     \item{\code{year}}{Year concerned.}
#'     \item{\code{population_type}}{Populations of concern : Refugees, Asylum-seekers, Internally displaced persons (IDPs), Returned refugees,
#'     Returned IDPs, Stateless persons, Others of concern.}
#'     \item{\code{continent_origin}}{Continent of residence of population.}
#'     \item{\code{n}}{Number of people concerned.}
#'   }
#' @source UNHCR (The UN Refugee Agency) (\url{https://www.unhcr.org/})
"unhcr_ts"



#' Electricity consumption and forecasting
#'
#' Electricity consumption per day in France for january and february of year 2020.
#'
#' @format A data frame with 120 observations and the following 3 variables:
#'   \describe{
#'     \item{\code{date}}{date.}
#'     \item{\code{type}}{Type of data : realized or forecast.}
#'     \item{\code{value}}{Value in giga-watt per hour.}
#'   }
#' @source Rte (Electricity Transmission Network in France) (\url{https://data.rte-france.com/})
"consumption"


#' Candlestick demo data
#'
#'
#' @format A data frame with 60 observations and the following 5 variables:
#'   \describe{
#'     \item{\code{datetime}}{Timestamp.}
#'     \item{\code{open}}{Open value.}
#'     \item{\code{high}}{Highest value.}
#'     \item{\code{low}}{Lowest value.}
#'     \item{\code{close}}{Close value.}
#'   }
#' @source Apexcharts (\url{https://apexcharts.com/javascript-chart-demos/candlestick-charts/basic/})
"candles"


#' @title Paris Climate
#'
#' @description Average temperature and precipitation in Paris for the period 1971-2000.
#'
#'
#' @format A data frame with 12 observations and the following 3 variables:
#'   \describe{
#'     \item{\code{month}}{Month}
#'     \item{\code{temperature}}{Temperature (in degree celsius).}
#'     \item{\code{precipitation}}{Precipitation (in mm).}
#'   }
#' @source Wikipedia (\url{https://fr.wikipedia.org/wiki/Climat_de_Paris})
"climate_paris"
