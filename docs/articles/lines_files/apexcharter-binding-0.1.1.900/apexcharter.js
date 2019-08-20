HTMLWidgets.widget({

  name: 'apexcharter',

  type: 'output',

  factory: function(el, width, height) {

    var ax_opts;
    var apexchart = null;

    return {

      renderValue: function(x) {


        // Global options
        ax_opts = x.ax_opts;

        // Sizing
        if (typeof ax_opts.chart === 'undefined') {
          ax_opts.chart = {};
        }
        ax_opts.chart.width = width;
        ax_opts.chart.height = height;
        if (!ax_opts.chart.hasOwnProperty('parentHeightOffset')) {
          ax_opts.chart.parentHeightOffset = 0;
        }

        // Generate or update chart
        if (apexchart === null) {
          apexchart = new ApexCharts(document.querySelector("#" + el.id), ax_opts);
          apexchart.render();
        } else {
          if (x.auto_update) {
            apexchart.updateSeries(ax_opts.series);
          } else {
            apexchart.destroy();
            apexchart = new ApexCharts(document.querySelector("#" + el.id), ax_opts);
            apexchart.render();
          }
        }
        

      },
      
      getChart: function(){
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
function get_widget(id){
  
  // Get the HTMLWidgets object
  var htmlWidgetsObj = HTMLWidgets.find("#" + id);
  
  // Use the getChart method we created to get the underlying billboard chart
  var widgetObj ;
  
  if (typeof htmlWidgetsObj != 'undefined') {
    widgetObj = htmlWidgetsObj.getChart();
  }

  return(widgetObj);
}



if (HTMLWidgets.shinyMode) {
  // update serie
  Shiny.addCustomMessageHandler('update-apexchart-series',
    function(obj) {
      var chart = get_widget(obj.id);
      if (typeof chart != 'undefined') {
        chart.updateSeries([{
          data: obj.data.newSeries
        }], obj.data.animate);
      }
  });
  
  // update options
  Shiny.addCustomMessageHandler('update-apexchart-options',
    function(obj) {
      var chart = get_widget(obj.id);
      if (typeof chart != 'undefined') {
        chart.updateOptions(obj.data.options);
      }
  });
}





