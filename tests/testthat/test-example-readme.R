context("test-example-readme")

test_that("readme exemple works", {
  
  n_manufac <- structure(list(
    manufacturer = c("audi", "chevrolet", "dodge", 
                     "ford", "honda", "hyundai", "jeep", "land rover", "lincoln", 
                     "mercury", "nissan", "pontiac", "subaru", "toyota", "volkswagen"
    ), 
    n = c(18L, 19L, 37L, 25L, 9L, 14L, 8L, 4L, 3L, 4L, 13L, 5L, 14L, 34L, 27L)
  ), row.names = c(NA, -15L), class = c("tbl_df", "tbl", "data.frame"))
  
  ax <- apexchart() %>% 
    ax_chart(type = "bar") %>% 
    ax_plotOptions(bar = bar_opts(
      horizontal = FALSE,
      endingShape = "flat",
      columnWidth = "70%",
      dataLabels = list(
        position = "top"
      ))
    ) %>% 
    ax_grid(
      show = TRUE,
      position = "front",
      borderColor = "#FFF"
    ) %>% 
    ax_series(list(
      name = "Count",
      data = n_manufac$n
    )) %>% 
    ax_colors("#112446") %>% 
    ax_xaxis(categories = n_manufac$manufacturer) %>% 
    ax_title(text = "Number of models") %>% 
    ax_subtitle(text = "Data from ggplot2")
  
  
  expect_is(ax, "apexcharter")
  expect_true(!is.null(ax$x$ax_opts))
})
