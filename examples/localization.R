# Use included localization config
dat <- data.frame(
  x = Sys.Date() + 1:20,
  y = sample.int(20, 20)
)

# French
apex(dat, aes(x, y), "line") %>% 
  ax_chart(defaultLocale = "fr")

# Italian
apex(dat, aes(x, y), "line") %>% 
  ax_chart(defaultLocale = "it")



# Custom config
apex(dat, aes(x, y), "line") %>% 
  ax_chart(locales = list(
    list(
      name = "en", # override en locale
      options = list(
        toolbar = list(
          exportToSVG = "GET SVG",
          exportToPNG = "GET PNG"
        )
      )
    )
  ))

