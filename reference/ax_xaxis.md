# X-axis options

X-axis options

## Usage

``` r
ax_xaxis(
  ax,
  type = NULL,
  categories = NULL,
  labels = NULL,
  axisBorder = NULL,
  axisTicks = NULL,
  tickAmount = NULL,
  min = NULL,
  max = NULL,
  range = NULL,
  floating = NULL,
  position = NULL,
  title = NULL,
  crosshairs = NULL,
  tooltip = NULL,
  ...
)
```

## Arguments

- ax:

  An
  [`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
  `htmlwidget` object.

- type:

  Character. Available Options : `"categories"` and `"datetime"`.

- categories:

  Categories are labels which are displayed on the x-axis.

- labels:

  A list of parameters.

- axisBorder:

  A list of parameters.

- axisTicks:

  A list of parameters.

- tickAmount:

  Number of Tick Intervals to show.

- min:

  Lowest number to be set for the x-axis. The graph drawing beyond this
  number will be clipped off.

- max:

  Highest number to be set for the x-axis. The graph drawing beyond this
  number will be clipped off.

- range:

  Range takes the max value of x-axis, subtracts the provided range
  value and gets the min value based on that. So, technically it helps
  to keep the same range when min and max values gets updated
  dynamically.

- floating:

  Logical. Floating takes x-axis is taken out of normal flow and places
  x-axis on svg element directly, similar to an absolutely positioned
  element. Set the offsetX and offsetY then to adjust the position
  manually

- position:

  Setting this option allows you to change the x-axis position.
  Available options: `"top"` and `"bottom"`.

- title:

  A list of parameters.

- crosshairs:

  A list of parameters.

- tooltip:

  A list of parameters.

- ...:

  Additional parameters.

## Value

An
[`apexchart()`](https://dreamrs.github.io/apexcharter/reference/apexchart.md)
`htmlwidget` object.

## Note

See <https://apexcharts.com/docs/options/xaxis/>

## Examples

``` r
data("mpg", package = "ggplot2")

# X axis title
apex(
  data = mpg,
  mapping = aes(x = manufacturer)
) %>% 
  ax_xaxis(title = list(text = "Car's manufacturer"))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"}},"title":{"text":"Car's manufacturer"}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}
# force labels to rotate and increase height
apex(
  data = mpg,
  mapping = aes(x = manufacturer)
) %>% 
  ax_xaxis(labels = list(rotateAlways = TRUE, maxHeight = 180))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"},"rotateAlways":true,"maxHeight":180}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}
# force to not rotate
apex(
  data = mpg,
  mapping = aes(x = manufacturer)
) %>% 
  ax_xaxis(labels = list(rotate = 0, trim = FALSE))

{"x":{"ax_opts":{"chart":{"type":"bar"},"series":[{"name":[],"type":"bar","data":[{"x":"audi","y":18},{"x":"chevrolet","y":19},{"x":"dodge","y":37},{"x":"ford","y":25},{"x":"honda","y":9},{"x":"hyundai","y":14},{"x":"jeep","y":8},{"x":"land rover","y":4},{"x":"lincoln","y":3},{"x":"mercury","y":4},{"x":"nissan","y":13},{"x":"pontiac","y":5},{"x":"subaru","y":14},{"x":"toyota","y":34},{"x":"volkswagen","y":27}]}],"dataLabels":{"enabled":false},"plotOptions":{"bar":{"horizontal":false,"isDumbbell":false}},"tooltip":{"shared":true,"intersect":false,"followCursor":true},"grid":{"yaxis":{"lines":{"show":true}},"xaxis":{"lines":{"show":false}}},"yaxis":{"labels":{"style":{"colors":"#848484"}}},"xaxis":{"labels":{"style":{"colors":"#848484"},"rotate":0,"trim":false}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"audi","max":"volkswagen"},"type":"column"},"evals":[],"jsHooks":[]}

data("economics", package = "ggplot2")

# Custom crosshair
apex(
  data = tail(economics, 50),
  mapping = aes(x = date, y = psavert),
  type = "line"
) %>% 
  ax_xaxis(
    crosshairs = list(
      opacity = 1,
      width = 2,
      fill = list(color = "red"),
      stroke = list(width = 0)
    )
  )

{"x":{"ax_opts":{"chart":{"type":"line"},"series":[{"name":"psavert","type":"line","data":[[1298937600000,7],[1301616000000,6.9],[1304208000000,6.9],[1306886400000,7.2],[1309478400000,7.3],[1312156800000,7.2],[1314835200000,6.8],[1317427200000,6.8],[1320105600000,7],[1322697600000,7.8],[1325376000000,8],[1328054400000,8],[1330560000000,8.5],[1333238400000,8.699999999999999],[1335830400000,8.800000000000001],[1338508800000,9.1],[1341100800000,8.199999999999999],[1343779200000,8],[1346457600000,8.199999999999999],[1349049600000,8.800000000000001],[1351728000000,9.699999999999999],[1354320000000,12],[1356998400000,6.3],[1359676800000,5.8],[1362096000000,5.9],[1364774400000,6.4],[1367366400000,6.7],[1370044800000,6.8],[1372636800000,6.6],[1375315200000,6.7],[1377993600000,6.8],[1380585600000,6.3],[1383264000000,6.2],[1385856000000,6.4],[1388534400000,7.1],[1391212800000,7.3],[1393632000000,7.4],[1396310400000,7.4],[1398902400000,7.4],[1401580800000,7.4],[1404172800000,7.5],[1406851200000,7.2],[1409529600000,7.4],[1412121600000,7.2],[1414800000000,7.3],[1417392000000,7.6],[1420070400000,7.7],[1422748800000,7.9],[1425168000000,7.4],[1427846400000,7.6]]}],"dataLabels":{"enabled":false},"stroke":{"curve":"straight","width":2},"yaxis":{"decimalsInFloat":2,"labels":{"style":{"colors":"#848484"}}},"xaxis":{"type":"datetime","labels":{"style":{"colors":"#848484"}},"crosshairs":{"opacity":1,"width":2,"fill":{"color":"red"},"stroke":{"width":0}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"2011-03-01","max":"2015-04-01"},"type":"line"},"evals":[],"jsHooks":[]}

# Date format (zoom to see changes)
apex(
  data = tail(economics, 150),
  mapping = aes(x = date, y = psavert),
  type = "line"
) %>% 
  ax_xaxis(
    labels = list(
      datetimeFormatter = list(
        year = "yyyy-MM",
        month = "yyyy-MM-dd",
        day = "yyyy-MM-dd HH:mm"
      )
    )
  )

{"x":{"ax_opts":{"chart":{"type":"line"},"series":[{"name":"psavert","type":"line","data":[[1036108800000,5.7],[1038700800000,5.5],[1041379200000,5.5],[1044057600000,5.6],[1046476800000,5.3],[1049155200000,5.3],[1051747200000,5.8],[1054425600000,5.6],[1057017600000,6.3],[1059696000000,6],[1062374400000,5.2],[1064966400000,5.3],[1067644800000,5.4],[1070236800000,5.4],[1072915200000,5],[1075593600000,5],[1078099200000,4.9],[1080777600000,5.3],[1083369600000,5.3],[1086048000000,5.8],[1088640000000,5.3],[1091318400000,5.2],[1093996800000,4.6],[1096588800000,4.5],[1099267200000,4.1],[1101859200000,6.9],[1104537600000,3.7],[1107216000000,3.4],[1109635200000,3.6],[1112313600000,3.1],[1114905600000,3.5],[1117584000000,2.9],[1120176000000,2.2],[1122854400000,2.7],[1125532800000,2.7],[1128124800000,3.1],[1130803200000,3.5],[1133395200000,3.7],[1136073600000,4.2],[1138752000000,4.2],[1141171200000,4.2],[1143849600000,4],[1146441600000,3.8],[1149120000000,4],[1151712000000,3.4],[1154390400000,3.6],[1157068800000,3.6],[1159660800000,3.6],[1162339200000,3.9],[1164931200000,3.7],[1167609600000,3.7],[1170288000000,4.1],[1172707200000,4.4],[1175385600000,4.2],[1177977600000,4],[1180656000000,3.8],[1183248000000,3.7],[1185926400000,3.4],[1188604800000,3.5],[1191196800000,3.4],[1193875200000,3.1],[1196467200000,3.6],[1199145600000,3.7],[1201824000000,4.1],[1204329600000,4],[1207008000000,3.4],[1209600000000,7.8],[1212278400000,5.5],[1214870400000,4.4],[1217548800000,3.8],[1220227200000,4.7],[1222819200000,5.5],[1225497600000,6.4],[1228089600000,6.4],[1230768000000,6.2],[1233446400000,5.5],[1235865600000,5.9],[1238544000000,6.8],[1241136000000,8.199999999999999],[1243814400000,6.7],[1246406400000,6],[1249084800000,4.9],[1251763200000,5.9],[1254355200000,5.4],[1257033600000,5.9],[1259625600000,5.9],[1262304000000,6.1],[1264982400000,5.8],[1267401600000,5.7],[1270080000000,6.4],[1272672000000,7],[1275350400000,6.9],[1277942400000,6.8],[1280620800000,6.9],[1283299200000,6.7],[1285891200000,6.6],[1288569600000,6.6],[1291161600000,7.1],[1293840000000,7.4],[1296518400000,7.6],[1298937600000,7],[1301616000000,6.9],[1304208000000,6.9],[1306886400000,7.2],[1309478400000,7.3],[1312156800000,7.2],[1314835200000,6.8],[1317427200000,6.8],[1320105600000,7],[1322697600000,7.8],[1325376000000,8],[1328054400000,8],[1330560000000,8.5],[1333238400000,8.699999999999999],[1335830400000,8.800000000000001],[1338508800000,9.1],[1341100800000,8.199999999999999],[1343779200000,8],[1346457600000,8.199999999999999],[1349049600000,8.800000000000001],[1351728000000,9.699999999999999],[1354320000000,12],[1356998400000,6.3],[1359676800000,5.8],[1362096000000,5.9],[1364774400000,6.4],[1367366400000,6.7],[1370044800000,6.8],[1372636800000,6.6],[1375315200000,6.7],[1377993600000,6.8],[1380585600000,6.3],[1383264000000,6.2],[1385856000000,6.4],[1388534400000,7.1],[1391212800000,7.3],[1393632000000,7.4],[1396310400000,7.4],[1398902400000,7.4],[1401580800000,7.4],[1404172800000,7.5],[1406851200000,7.2],[1409529600000,7.4],[1412121600000,7.2],[1414800000000,7.3],[1417392000000,7.6],[1420070400000,7.7],[1422748800000,7.9],[1425168000000,7.4],[1427846400000,7.6]]}],"dataLabels":{"enabled":false},"stroke":{"curve":"straight","width":2},"yaxis":{"decimalsInFloat":2,"labels":{"style":{"colors":"#848484"}}},"xaxis":{"type":"datetime","labels":{"style":{"colors":"#848484"},"datetimeFormatter":{"year":"yyyy-MM","month":"yyyy-MM-dd","day":"yyyy-MM-dd HH:mm"}}}},"auto_update":{"series_animate":true,"update_options":false,"options_animate":true,"options_redrawPaths":true,"update_synced_charts":false},"sparkbox":false,"xaxis":{"min":"2002-11-01","max":"2015-04-01"},"type":"line"},"evals":[],"jsHooks":[]}
```
