
#  ------------------------------------------------------------------------
#
# Title : Candlestick data
#    By : Victor
#  Date : 2020-06-13
#
#  ------------------------------------------------------------------------


library(jsonlite)

cdle <- read_json(path = "data-raw/candlestick.json")

cdle <- lapply(
  X = cdle,
  FUN = function(x) {
    data.frame(
      datetime = x$x,
      open = x$y[[1]],
      high = x$y[[2]],
      low = x$y[[3]],
      close = x$y[[4]],
      stringsAsFactors = FALSE
    )
  }
)
cdle <- do.call(rbind, cdle)
cdle$datetime <- as.POSIXct(cdle$datetime, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
cdle


apex(cdle, aes(x = datetime, open = open, close = close, low = low, high = high), type = "candlestick")



