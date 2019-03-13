
#  ------------------------------------------------------------------------
#
# Title : Colors
#    By : Victor
#  Date : 2019-02-20
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(apexcharter)
library(dplyr)



# Data --------------------------------------------------------------------

data("diamonds", package = "ggplot2")
dcc <- count(diamonds, cut, color)



# Colors ------------------------------------------------------------------

ax <- apex(data = dcc, type = "column", mapping = aes(cut, n, fill = color))
ax

ax %>% ax_theme(palette = "palette3")


ax %>% ax_theme(monochrome = list(
  enabled = TRUE,
  color = "#112446",
  shadeTo = "light",
  shadeIntensity = 1
))


ax %>% ax_colors("#1B9E77", "#D95F02", "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D")
ax %>% ax_colors(RColorBrewer::brewer.pal(n = 7, name = "Dark2"))



ax %>% ax_fill(colors = RColorBrewer::brewer.pal(n = 7, name = "Dark2"))








