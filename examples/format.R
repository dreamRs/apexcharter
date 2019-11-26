# Use SI prefix
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(1e4, 2e4)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("~s")
  ))

apex(dat, aes(labels, values * 100), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("~s")
  ))


# Percentage
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(0.45, 0.55)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num(".0%")
  ))


# Currency
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(570, 1170)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("$,.2f")
  ))

# Change locale
apex(dat, aes(labels, values), "column") %>% 
  ax_yaxis(labels = list(
    formatter = format_num("$,.2f", locale = "fr-FR")
  ))



# Customize tooltip value
# Use SI prefix
dat <- data.frame(
  labels = c("apex", "charts"),
  values = c(1e4, 2e4)
)

apex(dat, aes(labels, values), "column") %>% 
  ax_tooltip(y = list(
    formatter = format_num(",", suffix = " GW/h")
  ))

