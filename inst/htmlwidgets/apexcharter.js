HTMLWidgets.widget({

  name: 'apexcharter',

  type: 'output',

  factory: function(el, width, height) {

    var ax_opts, chart;

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

        // Generate chart
        chart = new ApexCharts(document.querySelector("#" + el.id), ax_opts);
        chart.render();

      },

      resize: function(width, height) {
        chart.updateOptions({
          chart: {
            width: width,
            height: height
          }
        });
      }

    };
  }
});
