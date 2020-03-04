HTMLWidgets.widget({
  name: "apexcharter",

  type: "output",

  factory: function(el, width, height) {
    var ax_opts;
    var apexchart = null;

    return {
      renderValue: function(x) {
        // Global options
        ax_opts = x.ax_opts;

        // Sizing
        if (typeof ax_opts.chart === "undefined") {
          ax_opts.chart = {};
        }
        ax_opts.chart.width = width;
        ax_opts.chart.height = height;
        if (!ax_opts.chart.hasOwnProperty("parentHeightOffset")) {
          ax_opts.chart.parentHeightOffset = 0;
        }

        if (x.hasOwnProperty("input") & HTMLWidgets.shinyMode) {
          if (!ax_opts.hasOwnProperty("chart")) {
            ax_opts.chart = {};
          }
          if (!ax_opts.chart.hasOwnProperty("events")) {
            ax_opts.chart.events = {};
          }
          if (x.input.hasOwnProperty("category")) {
            ax_opts.chart.events.dataPointSelection = function(
              event,
              chartContext,
              opts
            ) {
              var selected = {};
              for (var i = 0; i < opts.selectedDataPoints.length; i++) {
                if (typeof opts.selectedDataPoints[i] === "undefined") {
                  continue;
                }
                if (opts.w.config.series[i].hasOwnProperty("name")) {
                  var name = opts.w.config.series[i].name;
                  selected[name] = getSelection(opts, i);
                } else {
                  selected[i] = getSelection(opts, i);
                }
              }
              if (is_single(opts)) {
                selected = selected[Object.keys(selected)[0]];
              }
              Shiny.setInputValue(x.input.category.inputId, selected);
            };
          }
          if (x.input.hasOwnProperty("zoom")) {
            ax_opts.chart.events.zoomed = function(chartContext, xaxis, yaxis) {
              var id = x.input.zoom.inputId;
              if (chartContext.w.config.xaxis.type == "datetime") {
                id = id + ":apex_datetime";
              }
              Shiny.setInputValue(id, {
                x: getXaxis(xaxis),
                y: getYaxis(xaxis)
              });
            };
          }
        }

        // Generate or update chart
        if (apexchart === null) {
          apexchart = new ApexCharts(el, ax_opts);
          apexchart.render();
        } else {
          if (x.auto_update) {
            apexchart.updateSeries(
              ax_opts.series,
              x.auto_update.series_animate
            );
            if (x.auto_update.update_options) {
              apexchart.updateOptions(
                ax_opts,
                x.auto_update.options_redrawPaths,
                x.auto_update.options_animate
              );
            }
          } else {
            apexchart.destroy();
            apexchart = new ApexCharts(el, ax_opts);
            apexchart.render();
          }
        }
      },

      getChart: function() {
        return apexchart;
      },

      resize: function(width, height) {
        apexchart.updateOptions({
          chart: {
            width: width,
            height: height
          }
        });
      }
    };
  }
});

// From Friss tuto (https://github.com/FrissAnalytics/shinyJsTutorials/blob/master/tutorials/tutorial_03.Rmd)
function get_widget(id) {
  // Get the HTMLWidgets object
  var htmlWidgetsObj = HTMLWidgets.find("#" + id);

  // Use the getChart method we created to get the underlying billboard chart
  var widgetObj;

  if (typeof htmlWidgetsObj != "undefined") {
    widgetObj = htmlWidgetsObj.getChart();
  }

  return widgetObj;
}

function is_single(opts) {
  var typeLabels = ["pie", "radialBar", "donut"];
  var lab = typeLabels.indexOf(opts.w.config.chart.type) > -1;
  var single = opts.w.config.series.length == 1;
  return lab | single;
}

function getSelection(opts, serieIndex) {
  var typeLabels = ["pie", "radialBar", "donut"];
  var typeXY = ["scatter", "bubble"];
  var selected;
  if (typeLabels.indexOf(opts.w.config.chart.type) > -1) {
    var labels = opts.w.config.labels;
    selected = opts.selectedDataPoints[serieIndex].map(function(index) {
      return labels[index];
    });
  } else {
    var data = opts.w.config.series[serieIndex].data;
    //console.log(opts.selectedDataPoints);
    selected = opts.selectedDataPoints[serieIndex].map(function(index) {
      var val = data[index];
      if (typeXY.indexOf(opts.w.config.chart.type) < 0) {
        if (val.hasOwnProperty("x")) {
          val = val.x;
        } else {
          val = val[0];
        }
      }
      return val;
    });
  }
  if (typeXY.indexOf(opts.w.config.chart.type) > -1) {
    selected = {
      x: selected.map(function(obj) {
        return obj.x;
      }),
      y: selected.map(function(obj) {
        return obj.y;
      })
    };
  }
  return selected;
}

function getYaxis(axis) {
  var yzoom = { min: null, max: null };
  if (typeof axis.yaxis != "undefined") {
    var y_axis = axis.yaxis[0];
    if (y_axis.hasOwnProperty("min") && typeof y_axis.min != "undefined") {
      yzoom.min = y_axis.min;
    }
    if (y_axis.hasOwnProperty("max") && typeof y_axis.max != "undefined") {
      yzoom.max = y_axis.max;
    }
  }
  return yzoom;
}

function getXaxis(axis) {
  var xzoom = { min: null, max: null };
  if (typeof axis.xaxis != "undefined") {
    var x_axis = axis.xaxis;
    if (x_axis.hasOwnProperty("min") && typeof x_axis.min != "undefined") {
      xzoom.min = x_axis.min;
    }
    if (x_axis.hasOwnProperty("max") && typeof x_axis.max != "undefined") {
      xzoom.max = x_axis.max;
    }
  }
  return xzoom;
}

if (HTMLWidgets.shinyMode) {
  // update serie
  Shiny.addCustomMessageHandler("update-apexchart-series", function(obj) {
    var chart = get_widget(obj.id);
    if (typeof chart != "undefined") {
      chart.updateSeries(
        [
          {
            data: obj.data.newSeries
          }
        ],
        obj.data.animate
      );
    }
  });

  // update options
  Shiny.addCustomMessageHandler("update-apexchart-options", function(obj) {
    var chart = get_widget(obj.id);
    if (typeof chart != "undefined") {
      chart.updateOptions(obj.data.options);
    }
  });
}

