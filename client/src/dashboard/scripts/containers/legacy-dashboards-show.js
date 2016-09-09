import { selectAll } from 'd3-selection';

import { getDatasetsByWidgetId } from './../reducers/datasets';
import { getWidgetsByType } from './../reducers/widgets';

import FactWidget from './../legacy-components/Widgets/FactWidget';
import ChartWidget from './../legacy-components/Widgets/ChartWidget';
import SparklineWidget from './../legacy-components/Widgets/SparklineWidget';
import HeroWidget from './../legacy-components/Widgets/HeroWidget';
import Note from './../legacy-components/Note';
import convertData from './../legacy-components/Helpers/convertData'
import convertDataForPie from './../legacy-components/Helpers/convertDataForPie'
import convertDataForLine from './../legacy-components/Helpers/convertDataForLine';
import convertDataForHero from './../legacy-components/Helpers/convertDataForHero';
import stackByPercentage from './../legacy-components/Helpers/stackByPercentage';


const C_HEIGHT = 150;

class LegacyDashboardsShow {

  constructor() {
    return this;
  }

  render(props) {
    this.props = props;
    // this.renderHero();
    this.renderBelowTheLine();
    return this;
  }

  // todo
  // renderHero() {
  //   let chartData = null;
  //   let sparklines = [];
  //
  //   // render sparklines
  //   getWidgetsByType(this.props.widgets, 'kpi-sparkline').forEach((w) => {
  //     let el = selectAll(`[data-id="${w.id}"] .widget__inner`);
  //     let datasets = getDatasetsByWidgetId(w.datasets, w.id);
  //
  //     el.each(function() {
  //       chartData = null;
  //       if (datasets[0].data) {
  //         chartData = convertData(datasets);
  //       }
  //
  //       let options = {
  //         element: el,
  //         data: chartData,
  //         prefix: w.prefix,
  //         suffix: w.suffix,
  //         units: w.units,
  //         displayRoundedData: w.displayRoundedData,
  //         isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
  //       };
  //
  //       sparklines.push(new SparklineWidget(options));
  //     });
  //   });
  //
  //   // render hero
  //   // todo - hero widgets has a different data schema
  //   getWidgetsByType(this.props.widgets, 'full').forEach((w) => {
  //     let el = selectAll(`[data-id="${w.id}"]`);
  //     chartData = convertDataForHero(w);
  //
  //     if (chartData.length) {
  //       let heroHeight = 240;
  //       if ((window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth) <= 768){
  //         heroHeight = 150;
  //       }
  //       new HeroWidget({
  //         element: el,
  //         data: chartData,
  //         margin: {top: 0, right: 0, bottom: 0, left: 0},
  //         sparklines: sparklines,
  //         height: heroHeight,
  //         isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
  //       });
  //     }
  //   });
  //
  //   return this;
  // }

  renderBelowTheLine() {
    let self = this;
    let chartData = null;

    self.props.widgets.forEach((w) => { // improve this fetch
      let el = selectAll(`[data-id="${w.id}"] .widget__inner`);
      let datasets = getDatasetsByWidgetId(self.props.datasets, w.id);

      switch (w.type) {
        case 'line':
          el.each(function() {
            chartData = convertDataForLine(datasets);

            let options = {
              data: chartData,
              height: C_HEIGHT,
              element: el,
              type: w.type,
              margin: {top: 20, right: 5, bottom: 20, left: 40},
              showLegend: true,
              showNullData: true,
              showOverlay: true,
              showXAxis: true,
              showYAxis: true,
              prefix: w.prefix,
              suffix: w.suffix,
              units: w.units,
              padding: {
                left: 20,
                right: 20,
                top: 0,
                bottom: 0
              },
              displayRoundedData: w.displayRoundedData,
              isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
            };

            new ChartWidget(options);
            // let chartWidget = new ChartWidget(options);
            // self.charts.push(chartWidget);
          });

          break;

        case 'bar':
          el.each(function() {
            chartData = convertDataForLine(datasets);

            let options = {
              data: chartData,
              legendData: chartData,
              height: C_HEIGHT,
              element: el,
              type: w.type,
              margin: {top: 20, right: 5, bottom: 20, left: 40},
              showLegend: true,
              showNullData: true,
              showOverlay: true,
              showXAxis: true,
              showYAxis: true,
              prefix: w.prefix,
              suffix: w.suffix,
              units: w.units,
              stacking: w.stacking,
              displayRoundedData: w.displayRoundedData,
              isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
            };

            if(w.stacking && w.stacking === 'percentage'){
              options.chartData = stackByPercentage(chartData);
            }

            new ChartWidget(options);
            // let chartWidget = new ChartWidget(options);
            // self.charts.push(chartWidget);
          });

          break;

        case 'fact':
          el.each(function() {
            new FactWidget({
              description: w.description,
              element: el
            });
          });

          break;

        case 'pie':
          el.each(function() {
            chartData = null;
            chartData = convertDataForPie(datasets);

            if (chartData) {
              let options = {
                data: chartData,
                height: C_HEIGHT,
                element: el,
                type: w.type,
                margin: {top: 0, right: 0, bottom: 0, left: 0},
                showLegend: true,
                showNullData: false,
                showOverlay: false,
                showXAxis: false,
                showYAxis: false,
                prefix: w.prefix,
                suffix: w.suffix,
                units: w.units,
                displayRoundedData: w.displayRoundedData,
                isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
              };

              new ChartWidget(options);
              // let chartWidget = new ChartWidget(options);
              // self.charts.push(chartWidget);
            }
          });

          break;

        case 'sparkline':
          el.each(function() {
            chartData = null;
            if (datasets[0].data) {
              chartData = convertData(datasets);
            }

            let options = {
              element: el,
              data: chartData,
              prefix: w.prefix,
              suffix: w.suffix,
              units: w.units,
              displayRoundedData: w.displayRoundedData,
              isHighContrastMode: window.localStorage.getItem('high_contrast_mode') === 'on'
            };

            new SparklineWidget(options);
            // sparkline = new SparklineWidget(options);
            // self.charts.push(sparkline);
          });

          break;
      }
    });

    return this;
  }

}

export default LegacyDashboardsShow;
