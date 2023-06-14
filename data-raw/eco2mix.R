#  ------------------------------------------------------------------------
#
# eCO2mix data
# https://www.rte-france.com/eco2mix
#
#  ------------------------------------------------------------------------


# Packages ----------------------------------------------------------------

library(data.table)
library(fasttime)


complete <- function(data, vars, fill = list()) {
  data <- data[do.call(CJ, c(
    lapply(
      X = mget(vars),
      FUN = function(var) {
        if (inherits(var, "factor")) {
          if (anyNA(var)) {
            factor(c(levels(var), NA_character_), levels = levels(var), ordered = is.ordered(var))
          } else {
            factor(levels(var), levels = levels(var), ordered = is.ordered(var))
          }
        } else {
          unique(var)
        }
      }
    ),
    list(sorted = FALSE)
  )), on = vars]
  if (length(fill) > 0 && all(nzchar(names(fill)))) {
    for (fillvar in names(fill)) {
      data[is.na(get(fillvar)), (fillvar) := fill[[fillvar]]]
    }
  }
  data[]
}



# Download data -----------------------------------------------------------

# Source: https://odre.opendatasoft.com/explore/dataset/eco2mix-national-cons-def/
# and https://odre.opendatasoft.com/explore/dataset/eco2mix-national-tr


# Read & transform data ---------------------------------------------------

# eco2mix <- fread(file = "data-raw/inputs/eco2mix-national-cons-def.csv")
# eco2mix <- eco2mix[, c(5, 6, 9:17)]
# setnames(eco2mix, c("datetime", "consumption", "fuel", "coal", "gas", "nuclear", "wind", "solar", "hydraulic", "pumping", "bioenergies"))

eco2mix_tr <- fread(file = "data-raw/inputs/eco2mix-national-tr.csv")
eco2mix_tr <- eco2mix_tr[, c(5, 6, 9:17)]
setnames(eco2mix_tr, c("datetime", "consumption", "fuel", "coal", "gas", "nuclear", "wind", "solar", "hydraulic", "pumping", "bioenergies"))

eco2mix <- copy(eco2mix_tr)
# eco2mix <- rbind(eco2mix, eco2mix_tr)

eco2mix <- eco2mix[!is.na(consumption)]
eco2mix[, consumption := NULL]
# eco2mix[, date := as.Date(format(datetime, format = "%Y-%m-%d"))]
# eco2mix[, datetime := NULL]
# setcolorder(eco2mix, "date")
eco2mix <- eco2mix[minute(datetime) != 15]
eco2mix <- eco2mix[minute(datetime) != 45]
eco2mix <- eco2mix[datetime >= (max(datetime) - 24*60*60*7)]
eco2mix <- melt(
  data = eco2mix, 
  id.vars = 1, 
  variable.name = "source",
  value.name = "production", 
  na.rm = TRUE, 
  variable.factor = FALSE
)
eco2mix <- eco2mix[, list(production = round(mean(production))), by = list(datetime, source)]
eco2mix[, source := factor(
  x = source,
  levels = c("pumping", "wind", "solar", "nuclear", "hydraulic", "gas", "coal", "fuel", "bioenergies"),
  ordered = TRUE
)]
eco2mix <- complete(eco2mix, c("datetime", "source"), list(production = 0))
setorder(eco2mix, source, datetime)

eco2mix[]


# Use data ----------------------------------------------------------------

setDF(eco2mix)
usethis::use_data(eco2mix, internal = FALSE, overwrite = TRUE, compress = "xz")





# Test example ------------------------------------------------------------

apex(eco2mix[source == "consumption"], aes(date, production), type = "line")

# data("eco2mix", package = "apexcharter")
apex(eco2mix, aes(datetime, production, fill = source), type = "area") %>% 
  ax_chart(animations = list(enabled = FALSE), stacked = TRUE) %>% 
  ax_stroke(width = 1) %>% 
  ax_fill(opacity = 1, type = "solid") %>% 
  ax_tooltip(x = list(format = "dd MMM, HH:mm")) %>% 
  ax_yaxis(labels = list(formatter = format_num("~", suffix = "MW"))) %>% 
  ax_colors_manual(
    list(
      "bioenergies" = "#156956",
      "fuel" = "#80549f",
      "coal" = "#a68832",
      "solar" = "#d66b0d",
      "gas" = "#f20809",
      "wind" = "#72cbb7",
      "hydraulic" = "#2672b0",
      "nuclear" = "#e4a701",
      "pumping" = "#0e4269"
    )
  ) %>% 
  ax_labs(
    title = "Electricity generation by sector in France",
    subtitle = "Data from \u00e9CO\u2082mix"
  )





