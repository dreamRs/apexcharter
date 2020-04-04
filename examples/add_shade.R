
library(apexcharter)
data("consumption")

# specify from and to date
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(from = "2020-01-06", to = "2020-01-20")

# you can add several shadows
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(from = "2020-01-06", to = "2020-01-20") %>% 
  add_shade(from = "2020-02-04", to = "2020-02-10")

# or use a vector
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(
    from = c("2020-01-06", "2020-02-04"),
    to = c("2020-01-20", "2020-02-10")
  )


# Add a label
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(
    from = "2020-01-06", to = "2020-01-20",
    label = "interesting period"
  )

# add label with more options
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade(
    from = "2020-01-06", to = "2020-01-20",
    color = "firebrick",
    label = label(
      text = "something happened",
      background = "firebrick",
      color = "white", 
      fontWeight = "bold",
      padding = c(3, 5, 3, 5)
    )
  )


# automatically add shadow on week-ends
apex(consumption, aes(date, value, group = type), "spline") %>% 
  add_shade_weekend()



