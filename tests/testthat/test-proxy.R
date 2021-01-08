test_that("apexchartProxy works", {
  proxy <- apexchartProxy("chart", session = list(ns = identity))
  
  expect_is(proxy, "apexchart_Proxy")
  
  expect_error(apexchartProxy("chart", NULL))
})


test_that(".ax_proxy & .ax_proxy2  works", {
  
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage = list(type = type, message = message)
    }
  ))
  
  proxy <- apexchartProxy("chart", session = session) %>% 
    .ax_proxy(name = "TEST", a = 1)
  
  expect_is(session$lastCustomMessage, "list")
  expect_identical(session$lastCustomMessage$type, "update-apexchart-TEST")
  expect_identical(session$lastCustomMessage$message$id, "chart")
  
  expect_error(.ax_proxy(apexchart(), name = "TEST", a = 1))
  
  proxy <- apexchartProxy("chart", session = session) %>% 
    .ax_proxy2(name = "TEST", list(a = 1))
  
  expect_is(session$lastCustomMessage, "list")
  expect_identical(session$lastCustomMessage$type, "update-apexchart-TEST")
  expect_identical(session$lastCustomMessage$message$id, "chart")
  
  expect_error(.ax_proxy2(apexchart(), name = "TEST", a = 1))
})


test_that("ax_proxy_series works", {
  
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage = list(type = type, message = message)
    }
  ))
  
  proxy <- apexchartProxy("chart", session = session) %>% 
    ax_proxy_series(1:10)
  
  expect_is(session$lastCustomMessage, "list")
  expect_identical(session$lastCustomMessage$type, "update-apexchart-series")
  expect_identical(session$lastCustomMessage$message$id, "chart")
})


test_that("ax_proxy_options works", {
  
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage = list(type = type, message = message)
    }
  ))
  
  proxy <- apexchartProxy("chart", session = session) %>% 
    ax_proxy_options(list(
      xaxis = list(
        labels = list(show = TRUE)
      ),
      yaxis = list(
        title = list(text = FALSE)
      )
    ))
  
  expect_is(session$lastCustomMessage, "list")
  expect_identical(session$lastCustomMessage$type, "update-apexchart-options")
  expect_identical(session$lastCustomMessage$message$id, "chart")
})


test_that("ax_proxy_toggle_series works", {
  
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage = list(type = type, message = message)
    }
  ))
  
  proxy <- apexchartProxy("chart", session = session) %>% 
    ax_proxy_toggle_series("serie1")
  
  expect_is(session$lastCustomMessage, "list")
  expect_identical(session$lastCustomMessage$type, "update-apexchart-toggle-series")
  expect_identical(session$lastCustomMessage$message$id, "chart")
})
