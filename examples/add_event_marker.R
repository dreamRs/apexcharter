library(apexcharter)
data("consumption")

# add a marker
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event_marker(when = "2020-01-22", y = 1805)

# with a label
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event_marker(when = "2020-01-22", y = 1805, label = "Consumption peak")

# add several markers
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event_marker(
    when = c("2020-01-02", "2020-01-06", "2020-01-13", 
             "2020-01-22", "2020-01-28", "2020-02-06",
             "2020-02-13", "2020-02-19", "2020-02-27"),
    y = c(1545, 1659, 1614,
          1805, 1637, 1636, 
          1597, 1547, 1631),
    size = 10,
    color = "firebrick"
  )
