
#  ------------------------------------------------------------------------
#
# Title : Radial charts
#    By : Victor
#  Date : 2018-09-07
#
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library(apexcharter)






# Basic -------------------------------------------------------------------

apexchart() %>% 
  ax_chart(type = "radialBar") %>% 
  ax_plotOptions(
    radialBar = radialBar_opts(
      hollow = list(size = "70%")
    )
  ) %>% 
  ax_series(70) %>% 
  ax_labels("Indicator")




# Stroked gauge -----------------------------------------------------------

apexchart() %>% 
  ax_chart(type = "radialBar") %>% 
  ax_plotOptions(
    radialBar = radialBar_opts(
      startAngle = -135,
      endAngle = 135,
      dataLabels = list(
        name = list(
          fontSize = "16px",
          # color = undefined,
          offsetY = 120
        ),
        value = list(
          offsetY = 76,
          fontSize = "22px",
          # color = undefined,
          formatter = htmlwidgets::JS("function (val) {return val + '%';}")
        )
      )
    )
  ) %>% 
  ax_stroke(dashArray = 4) %>% 
  ax_series(70) %>% 
  ax_labels("Indicator")





apexchart() %>% 
  ax_chart(type = "radialBar") %>% 
  # ax_plotOptions(
  #   radialBar = radialBarOpts(
  #     startAngle = -135,
  #     endAngle = 135,
  #     dataLabels = list(
  #       name = list(
  #         fontSize = "16px",
  #         # color = undefined,
  #         offsetY = 120
  #       ),
  #       value = list(
  #         offsetY = 76,
  #         fontSize = "22px",
  #         # color = undefined,
  #         formatter = htmlwidgets::JS("function (val) {return val + '%';}")
  #       )
  #     )
  #   )
  # ) %>% 
  # ax_stroke(dashArray = 4) %>% 
  ax_series(70) %>% 
  ax_labels("Indicator")
