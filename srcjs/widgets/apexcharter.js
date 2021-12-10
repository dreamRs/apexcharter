import "widgets";
import ApexCharts from "apexcharts";
import {format, formatLocale} from "d3-format";
import * as utils from "../modules/utils";
import "../css/apexcharter.css";

//window['d3.format'] = format;
//window['d3.formatLocale'] = formatLocale;
// add in webpackconfig: output.libraryTarget: 'window'
export { ApexCharts, format , formatLocale };


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
                  var selection = utils.getSelection(
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
                if (utils.isSingleSerie(options)) {
                  select = select[Object.keys(select)[0]];
                }
                Shiny.setInputValue(
                  x.shinyEvents.click.inputId + ":apex_click",
                  { value: select, datetime: utils.isDatetimeAxis(chartContext) }
                );
              } else {
                Shiny.setInputValue(x.shinyEvents.click.inputId, null);
              }
            };
          }
          if (x.shinyEvents.hasOwnProperty("zoomed")) {
            axOpts.chart.events.zoomed = function(chartContext, xaxis, yaxis) {
              var id = x.shinyEvents.zoomed.inputId;
              if (utils.isDatetimeAxis(chartContext)) {
                id = id + ":apex_datetime";
              }
              Shiny.setInputValue(id, {
                x: utils.getXaxis(xaxis),
                y: utils.getYaxis(xaxis)
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
              if (utils.isDatetimeAxis(chartContext)) {
                id = id + ":apex_datetime";
              }
              var selectionValue;
              if (x.shinyEvents.selection.type === "x") {
                selectionValue = { x: xaxis.xaxis };
              } else if (x.shinyEvents.selection.type === "xy") {
                selectionValue = { x: xaxis.xaxis, y: utils.getYaxis(xaxis) };
              } else if (x.shinyEvents.selection.type === "y") {
                selectionValue = { y: utils.getYaxis(xaxis) };
              }
              Shiny.setInputValue(id, selectionValue);
            };
          }
        }

        // Generate or update chart
        if (apexchart === null) {
          apexchart = new ApexCharts(el, axOpts);
          apexchart.render().then(function() {
            utils.exportChart(x, apexchart);
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
                utils.exportChart(x, chart);
              });
          } else {
            apexchart.destroy();
            apexchart = new ApexCharts(el, axOpts);
            apexchart.render().then(function() {
              utils.exportChart(x, apexchart);
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
    var chart = utils.getWidget(obj.id);
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
    var chart = utils.getWidget(obj.id);
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
    var chart = utils.getWidget(obj.id);
    if (typeof chart != "undefined") {
      var seriesName = obj.data.seriesName;
      for(var i = 0; i < seriesName.length; i++) {
        chart.toggleSeries(seriesName[i]);
      }
    }
  });
}
