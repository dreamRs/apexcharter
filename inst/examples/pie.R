
#  ------------------------------------------------------------------------
#
# Title : Pie charts
#    By : Victor
#  Date : 2018-09-07
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(apexcharter)





# Simple pie --------------------------------------------------------------

apexcharter() %>% 
  ax_chart(type = "pie") %>% 
  ax_series(23, 45, 56) %>% 
  ax_labels("A", "B", "C")




# Donut -------------------------------------------------------------------


apexcharter() %>% 
  ax_chart(type = "donut") %>% 
  ax_series2(c(23, 45, 56)) %>% 
  ax_labels2(c("A", "B", "C"))

