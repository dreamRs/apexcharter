/*!
 *
 * htmlwidgets bindings for ApexCharts
 * https://github.com/dreamRs/apexcharter
 *
 */

/*global HTMLWidgets, ApexCharts, Shiny */

/// Functions

// From Friss tuto (https://github.com/FrissAnalytics/shinyJsTutorials/blob/master/tutorials/tutorial_03.Rmd)
var apexcharter = {
  getWidget: function(id) {
    var htmlWidgetsObj = HTMLWidgets.find("#" + id);
    var widgetObj;
    if (typeof htmlWidgetsObj !== "undefined") {
      widgetObj = htmlWidgetsObj.getChart();
    }
    return widgetObj;
  },

  isSingleSerie: function(options) {
    var typeLabels = ["pie", "radialBar", "donut"];
    var lab = typeLabels.indexOf(options.w.config.chart.type) > -1;
    var single = options.w.config.series.length === 1;
    return lab | single;
  },

  isDatetimeAxis: function(chartContext) {
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
  },

  getSelection: function(chartContext, selectedDataPoints, serieIndex) {
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
  },

  getYaxis: function(axis) {
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
  },

  getXaxis: function(axis) {
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
  },

  exportChart: function(x, chart) {
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
};

/// Widget

HTMLWidgets.widget({
  name: "apexcharter",

  type: "output",

  factory: function(el, width, height) {
    var axOpts;
    var apexchart = null;

    return {
      renderValue: function(x) {
        // Global options
        axOpts = x.ax_opts;

        if (x.sparkbox) {
          el.style.background = x.sparkbox.background;
          el.classList.add("apexcharter-spark-box");
        }

        // Sizing
        if (typeof axOpts.chart === "undefined") {
          axOpts.chart = {};
        }
        axOpts.chart.width = el.clientWidth;
        axOpts.chart.height = el.clientHeight;
        if (!axOpts.chart.hasOwnProperty("id")) {
          axOpts.chart.id = el.id;
        }
        if (!axOpts.chart.hasOwnProperty("parentHeightOffset")) {
          axOpts.chart.parentHeightOffset = 0;
        }

        // added events to remove minheight container
        if (!axOpts.chart.hasOwnProperty("events")) {
          axOpts.chart.events = {};
        }
        if (!axOpts.chart.events.hasOwnProperty("mounted")) {
          axOpts.chart.events.mounted = function(chartContext, config) {
            el.style.minHeight = 0;
          };
        }
        if (!axOpts.chart.events.hasOwnProperty("updated")) {
          axOpts.chart.events.updated = function(chartContext, config) {
            el.style.minHeight = 0;
          };
        }

        if (x.hasOwnProperty("shinyEvents") & HTMLWidgets.shinyMode) {
          if (!axOpts.hasOwnProperty("chart")) {
            axOpts.chart = {};
          }
          if (!axOpts.chart.hasOwnProperty("events")) {
            axOpts.chart.events = {};
          }
          if (x.shinyEvents.hasOwnProperty("click")) {
            axOpts.chart.events.dataPointSelection = function(
              event,
              chartContext,
              opts
            ) {
              var options = opts;
              var nonEmpty = opts.selectedDataPoints.filter(function(el) {
                return el !== null && el.length > 0;
              });
              if (nonEmpty.length > 0) {
                var select = {};
                for (var i = 0; i < opts.selectedDataPoints.length; i++) {
                  if (typeof opts.selectedDataPoints[i] === "undefined") {
                    continue;
                  }
                  var selection = apexcharter.getSelection(
                    chartContext,
                    options.selectedDataPoints,
                    i
                  );
                  if (selection !== null) {
                    if (opts.w.config.series[i].hasOwnProperty("name")) {
                      var name = opts.w.config.series[i].name;
                      select[name] = selection;
                    } else {
                      select[i] = selection;
                    }
                  }
                }
                if (apexcharter.isSingleSerie(options)) {
                  select = select[Object.keys(select)[0]];
                }
                Shiny.setInputValue(
                  x.shinyEvents.click.inputId + ":apex_click",
                  { value: select, datetime: apexcharter.isDatetimeAxis(chartContext) }
                );
              } else {
                Shiny.setInputValue(x.shinyEvents.click.inputId, null);
              }
            };
          }
          if (x.shinyEvents.hasOwnProperty("zoomed")) {
            axOpts.chart.events.zoomed = function(chartContext, xaxis, yaxis) {
              var id = x.shinyEvents.zoomed.inputId;
              if (apexcharter.isDatetimeAxis(chartContext)) {
                id = id + ":apex_datetime";
              }
              Shiny.setInputValue(id, {
                x: apexcharter.getXaxis(xaxis),
                y: apexcharter.getYaxis(xaxis)
              });
            };
          }
          if (x.shinyEvents.hasOwnProperty("selection")) {
            axOpts.chart.events.selection = function(
              chartContext,
              xaxis,
              yaxis
            ) {
              var id = x.shinyEvents.selection.inputId;
              if (apexcharter.isDatetimeAxis(chartContext)) {
                id = id + ":apex_datetime";
              }
              var selectionValue;
              if (x.shinyEvents.selection.type === "x") {
                selectionValue = { x: xaxis.xaxis };
              } else if (x.shinyEvents.selection.type === "xy") {
                selectionValue = { x: xaxis.xaxis, y: apexcharter.getYaxis(xaxis) };
              } else if (x.shinyEvents.selection.type === "y") {
                selectionValue = { y: apexcharter.getYaxis(xaxis) };
              }
              Shiny.setInputValue(id, selectionValue);
            };
          }
        }

        // Generate or update chart
        if (apexchart === null) {
          apexchart = new ApexCharts(el, axOpts);
          apexchart.render().then(function() {
            apexcharter.exportChart(x, apexchart);
          });
        } else {
          if (x.auto_update) {
            //console.log(x.auto_update);
            if (x.auto_update.update_options) {
              var options = Object.assign({}, axOpts);
              delete options.series;
              delete options.chart.width;
              delete options.chart.height;
              apexchart
                .updateOptions(
                  options,
                  x.auto_update.options_redrawPaths,
                  x.auto_update.options_animate,
                  x.auto_update.update_synced_charts
                );
            }
            apexchart
              .updateSeries(axOpts.series, x.auto_update.series_animate)
              .then(function(chart) {
                apexcharter.exportChart(x, chart);
              });
          } else {
            apexchart.destroy();
            apexchart = new ApexCharts(el, axOpts);
            apexchart.render().then(function() {
              apexcharter.exportChart(x, apexchart);
            });
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

if (HTMLWidgets.shinyMode) {
  // update serie
  Shiny.addCustomMessageHandler("update-apexchart-series", function(obj) {
    var chart = apexcharter.getWidget(obj.id);
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
    var chart = apexcharter.getWidget(obj.id);
    if (typeof chart != "undefined") {
      var options = obj.data.options;
      var evals = obj.data.evals;
      if (!(evals instanceof Array)) evals = [evals];
      for (var k = 0; evals && k < evals.length; k++) {
          window.HTMLWidgets.evaluateStringMember(options, evals[k]);
      }
      chart.updateOptions(options);
    }
  });

  // toggle series
  Shiny.addCustomMessageHandler("update-apexchart-toggle-series", function(obj) {
    var chart = apexcharter.getWidget(obj.id);
    if (typeof chart != "undefined") {
      var seriesName = obj.data.seriesName;
      for(var i = 0; i < seriesName.length; i++) {
        chart.toggleSeries(seriesName[i]);
      }
    }
  });
}

