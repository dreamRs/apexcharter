// From Friss tuto (https://github.com/FrissAnalytics/shinyJsTutorials/blob/master/tutorials/tutorial_03.Rmd)
export function getWidget(id) {
  var htmlWidgetsObj = HTMLWidgets.find("#" + id);
  var widgetObj;
  if (typeof htmlWidgetsObj !== "undefined") {
    widgetObj = htmlWidgetsObj.getChart();
  }
  return widgetObj;
}

export function isSingleSerie(options) {
  var typeLabels = ["pie", "radialBar", "donut"];
  var lab = typeLabels.indexOf(options.w.config.chart.type) > -1;
  var single = options.w.config.series.length === 1;
  return lab | single;
}

export function isDatetimeAxis(chartContext) {
  if (
    chartContext.hasOwnProperty("w") &&
    chartContext.w.hasOwnProperty("config") &&
    chartContext.w.config.hasOwnProperty("xaxis") &&
    chartContext.w.config.xaxis.hasOwnProperty("type")
  ) {
    return chartContext.w.config.xaxis.type == "datetime";
  } else {
    return false;
  }
}

export function getSelection(chartContext, selectedDataPoints, serieIndex) {
  var typeLabels = ["pie", "radialBar", "donut"];
  var typeXY = ["scatter", "bubble"];
  var selected;
  if (typeLabels.indexOf(chartContext.opts.chart.type) > -1) {
    var labels = chartContext.opts.labels;
    selected = selectedDataPoints[serieIndex].map(function(index) {
      return labels[index];
    });
  } else {
    var data = chartContext.opts.series[serieIndex].data;
    selected = selectedDataPoints[serieIndex].map(function(index) {
      var val = data[index];
      if (typeXY.indexOf(chartContext.opts.chart.type) < 0) {
        if (val.hasOwnProperty("x")) {
          val = val.x;
        } else {
          val = val[0];
        }
      }
      return val;
    });
  }
  //console.log(selected);
  if (typeXY.indexOf(chartContext.opts.chart.type) > -1) {
    selected = {
      x: selected.map(function(obj) {
        return obj.x;
      }),
      y: selected.map(function(obj) {
        return obj.y;
      })
    };
  }
  if (typeof selected == "undefined") {
    selected = null;
  }
  return selected;
}

export function getYaxis(axis) {
  var yzoom = { min: null, max: null };
  if (typeof axis.yaxis !== "undefined" && axis.yaxis !== null) {
    var y_axis;
    if (axis.yaxis.hasOwnProperty("min")) {
      y_axis = axis.yaxis;
    } else {
      y_axis = axis.yaxis[0];
    }
    if (y_axis.hasOwnProperty("min") && typeof y_axis.min !== "undefined") {
      yzoom.min = y_axis.min;
    }
    if (y_axis.hasOwnProperty("max") && typeof y_axis.max !== "undefined") {
      yzoom.max = y_axis.max;
    }
  }
  return yzoom;
}

export function getXaxis(axis) {
  var xzoom = { min: null, max: null };
  if (typeof axis.xaxis !== "undefined") {
    var x_axis = axis.xaxis;
    if (x_axis.hasOwnProperty("min") && typeof x_axis.min !== "undefined") {
      xzoom.min = x_axis.min;
    }
    if (x_axis.hasOwnProperty("max") && typeof x_axis.max !== "undefined") {
      xzoom.max = x_axis.max;
    }
  }
  return xzoom;
}

export function exportChart(x, chart) {
  if (x.hasOwnProperty("shinyEvents") & HTMLWidgets.shinyMode) {
    if (x.shinyEvents.hasOwnProperty("export")) {
      setTimeout(function() {
        chart.dataURI().then(function(imgURI) {
          Shiny.setInputValue(x.shinyEvents.export.inputId, imgURI);
        });
      }, 1000);
    }
  }
}
