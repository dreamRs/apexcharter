## scatter

apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "6" = "firebrick",
    "8" = "forestgreen"
  ))

# If missing level, colors are recycled
apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "8" = "forestgreen"
  ))

# Ignore levels not present in data
apex(
  data = mtcars, 
  type = "scatter",
  mapping = aes(x = wt, y = mpg, fill = cyl)
) %>% 
  ax_colors_manual(list(
    "4" = "steelblue",
    "6" = "firebrick",
    "8" = "forestgreen",
    "99" = "yellow"
  ))



## Bar

tab <- table(sample(letters[1:5], 100, TRUE), sample(LETTERS[1:5], 100, TRUE))
dat <- as.data.frame(tab)

apex(
  data = dat,
  type = "column",
  mapping = aes(x = Var1, y = Freq, group = Var2)
) %>% 
  ax_colors_manual(list(
    A = "steelblue",
    C = "firebrick",
    D = "forestgreen",
    B = "peachpuff",
    E = "chartreuse"
  ))