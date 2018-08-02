



# ApexCharts options ------------------------------------------------------



scrollerOpts <- function(enabled = NULL,
                         height = NULL,
                         track = NULL,
                         thumb = NULL,
                         scrollButtons = NULL,
                         padding = NULL,
                         offsetX = NULL,
                         offsetY = NULL,
                         ...) {
  dropNulls(
    list(
      enabled = enabled,
      height = height,
      track = track,
      thumb = thumb,
      scrollButtons = scrollButtons,
      padding = padding,
      offsetX = offsetX,
      offsetY = offsetY,
      ...
    )
  )
}


eventsOpts <- function(beforeMount = NULL,
                       mounted = NULL,
                       updated = NULL,
                       clicked = NULL,
                       selection = NULL,
                       dataPointSelection = NULL,
                       zoomed = NULL,
                       scrolled = NULL,
                       ...) {
  dropNulls(
    list(
      beforeMount = beforeMount,
      mounted = mounted,
      updated = updated,
      clicked = clicked,
      selection = selection,
      dataPointSelection = dataPointSelection,
      zoomed = zoomed,
      scrolled = scrolled,
      ...
    )
  )
}


selectionOpts <- function(enabled = NULL,
                          type = NULL,
                          selectedPoints = NULL,
                          fill = NULL,
                          stroke = NULL,
                          xaxis = NULL,
                          yaxis = NULL,
                          ...) {
  dropNulls(
    list(
      enabled = enabled,
      type = type,
      selectedPoints = selectedPoints,
      fill = fill,
      stroke = stroke,
      xaxis = xaxis,
      yaxis = yaxis,
      ...
    )
  )
}


barOpts <- function(horizontal = NULL,
                    endingShape = NULL,
                    columnWidth = NULL,
                    barHeight = NULL,
                    distributed = NULL,
                    colors = NULL,
                    dataLabels = NULL,
                    ...) {
  dropNulls(
    list(
      horizontal = horizontal,
      endingShape = endingShape,
      columnWidth = columnWidth,
      barHeight = barHeight,
      distributed = distributed,
      colors = colors,
      dataLabels = dataLabels,
      ...
    )
  )
}


heatmapOpts <- function(radius = NULL,
                        enableShades = NULL,
                        shadeIntensity = NULL,
                        colorScale = NULL,
                        ...) {
  dropNulls(
    list(
      radius = radius,
      enableShades = enableShades,
      shadeIntensity = shadeIntensity,
      colorScale = colorScale,
      ...
    )
  )
}


radialBarOpts <- function(size = NULL,
                          inverseOrder = NULL,
                          startAngle = NULL,
                          endAngle = NULL,
                          offsetX = NULL,
                          offsetY = NULL,
                          hollow = NULL,
                          track = NULL,
                          dataLabels = NULL,
                          ...) {
  dropNulls(
    list(
      size = size,
      inverseOrder = inverseOrder,
      startAngle = startAngle,
      endAngle = endAngle,
      offsetX = offsetX,
      offsetY = offsetY,
      hollow = hollow,
      track = track,
      dataLabels = dataLabels,
      ...
    )
  )
}


pieOpts <- function(size = NULL,
                    donut = NULL,
                    customScale = NULL,
                    offsetX = NULL,
                    offsetY = NULL,
                    dataLabels = NULL,
                    ...) {
  dropNulls(
    list(
      size = size,
      donut = donut,
      customScale = customScale,
      offsetX = offsetX,
      offsetY = offsetY,
      dataLabels = dataLabels,
      ...
    )
  )
}


scrollerOpts <- function(enabled = NULL,
                         height = NULL,
                         track = NULL,
                         thumb = NULL,
                         scrollButtons = NULL,
                         padding = NULL,
                         offsetX = NULL,
                         offsetY = NULL,
                         ...) {
  dropNulls(c(
    list(
      enabled = enabled,
      height = height,
      track = track,
      thumb = thumb,
      scrollButtons = scrollButtons,
      padding = padding,
      offsetX = offsetX,
      offsetY = offsetY
    ),
    list(...)
  ))
}


eventsOpts <- function(beforeMount = NULL,
                       mounted = NULL,
                       updated = NULL,
                       clicked = NULL,
                       selection = NULL,
                       dataPointSelection = NULL,
                       zoomed = NULL,
                       scrolled = NULL,
                       ...) {
  dropNulls(c(
    list(
      beforeMount = beforeMount,
      mounted = mounted,
      updated = updated,
      clicked = clicked,
      selection = selection,
      dataPointSelection = dataPointSelection,
      zoomed = zoomed,
      scrolled = scrolled
    ),
    list(...)
  ))
}


selectionOpts <- function(enabled = NULL,
                          type = NULL,
                          selectedPoints = NULL,
                          fill = NULL,
                          stroke = NULL,
                          xaxis = NULL,
                          yaxis = NULL,
                          ...) {
  dropNulls(c(
    list(
      enabled = enabled,
      type = type,
      selectedPoints = selectedPoints,
      fill = fill,
      stroke = stroke,
      xaxis = xaxis,
      yaxis = yaxis
    ),
    list(...)
  ))
}


barOpts <- function(horizontal = NULL,
                    endingShape = NULL,
                    columnWidth = NULL,
                    barHeight = NULL,
                    distributed = NULL,
                    colors = NULL,
                    dataLabels = NULL,
                    ...) {
  dropNulls(c(
    list(
      horizontal = horizontal,
      endingShape = endingShape,
      columnWidth = columnWidth,
      barHeight = barHeight,
      distributed = distributed,
      colors = colors,
      dataLabels = dataLabels
    ),
    list(...)
  ))
}


heatmapOpts <- function(radius = NULL,
                        enableShades = NULL,
                        shadeIntensity = NULL,
                        colorScale = NULL,
                        ...) {
  dropNulls(c(
    list(
      radius = radius,
      enableShades = enableShades,
      shadeIntensity = shadeIntensity,
      colorScale = colorScale
    ),
    list(...)
  ))
}


radialBarOpts <- function(size = NULL,
                          inverseOrder = NULL,
                          startAngle = NULL,
                          endAngle = NULL,
                          offsetX = NULL,
                          offsetY = NULL,
                          hollow = NULL,
                          track = NULL,
                          dataLabels = NULL,
                          ...) {
  dropNulls(c(
    list(
      size = size,
      inverseOrder = inverseOrder,
      startAngle = startAngle,
      endAngle = endAngle,
      offsetX = offsetX,
      offsetY = offsetY,
      hollow = hollow,
      track = track,
      dataLabels = dataLabels
    ),
    list(...)
  ))
}


pieOpts <- function(size = NULL,
                    donut = NULL,
                    customScale = NULL,
                    offsetX = NULL,
                    offsetY = NULL,
                    dataLabels = NULL,
                    ...) {
  dropNulls(c(
    list(
      size = size,
      donut = donut,
      customScale = customScale,
      offsetX = offsetX,
      offsetY = offsetY,
      dataLabels = dataLabels
    ),
    list(...)
  ))
}
