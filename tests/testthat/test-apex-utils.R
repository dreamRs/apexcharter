context("apex-utils")


test_that("all apex utilities works", {
  
  ax_utils <- c("ax_annotations", "ax_chart", "ax_colors", "ax_dataLabels", 
                "ax_fill", "ax_grid", "ax_labels", "ax_labels2", "ax_legend", 
                "ax_markers", "ax_noData", "ax_plotOptions", "ax_responsive", 
                "ax_series", "ax_series2", "ax_states", "ax_stroke", "ax_subtitle", 
                "ax_theme", "ax_title", "ax_tooltip", "ax_xaxis", "ax_yaxis", 
                "ax_yaxis2")
  
  lapply(
    X = ax_utils,
    FUN = function(fun) {
      ax_fun <- get(fun)
      
      if (grepl("2$", fun)) {
        ax <- apexchart() %>% 
          ax_fun("ARG")
      } else {
        ax <- apexchart() %>% 
          ax_fun()
      }
      
      expect_is(ax, "apexcharter")
      
    }
  )

})



