library(apexcharter)
data("consumption")

# specify from and to date
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event(when = "2020-01-11")

# several events
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event(when = c("2020-01-11", "2020-01-29"))

# Add labels on events
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_event(
    when = c("2020-01-11", "2020-01-29"),
    label = label(text = c("Am", "Ar"))
  )

# can be combined with shade
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(from = "2020-01-06", to = "2020-01-20")%>% 
  add_event(when = c("2020-01-11", "2020-01-29"))
