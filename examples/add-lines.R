
library(apexcharter)

# On a column chart
apex(
  data = table(unhcr_popstats_2017$continent_residence),
  aes(Var1, Freq),
  "column"
) %>% 
  add_hline(value = 2100)


# On a scatter chart
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) %>% 
  add_hline(value = mean(iris$Sepal.Width)) %>% 
  add_vline(value = mean(iris$Sepal.Length))

# With labels
apex(
  data = iris,
  aes(Sepal.Length, Sepal.Width),
  "scatter"
) %>% 
  add_hline(
    value = mean(iris$Sepal.Width),
    label = "Mean of Sepal.Width"
  ) %>% 
  add_vline(
    value = mean(iris$Sepal.Length),
    label = "Mean of Sepal.Length"
  )
