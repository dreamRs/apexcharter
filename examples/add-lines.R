
library(apexcharter)

# On a column chart
unhcr_ts %>%
  subset(year == 2017 & population_type == "Asylum-seekers") %>%
  apex(
    aes(continent_origin, n),
    "column"
  ) %>%
  add_hline(value = 5e5)


# On a scatter chart
apex(
  data = cars,
  aes(speed, dist),
  "scatter"
) %>%
  add_hline(value = mean(cars$dist)) %>%
  add_vline(value = mean(cars$speed))

# With labels
apex(
  data = cars,
  aes(speed, dist),
  "scatter"
) %>%
  add_hline(
    value = mean(cars$dist),
    label = "Mean of dist"
  ) %>%
  add_vline(
    value = mean(cars$speed),
    label = label(
      text = "Mean of speed",
      borderColor = "red"
    )
  )
