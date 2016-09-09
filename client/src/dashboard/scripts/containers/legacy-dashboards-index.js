import { selectAll } from 'd3-selection';

import { getDatasetsByWidgetId } from './../reducers/datasets';

import convertData from './../legacy-components/Helpers/convertData'
import SparklineWidget from './../legacy-components/Widgets/SparklineWidget';


class LegacyDashboardsIndex {

  constructor() {
    return this;
  }

  render(props) {
    let self = this;
    let chartData = null;
    let sparkline;
    self.props = props;

    self.props.widgets.forEach((w) => {
      let el = selectAll(`[data-id="${w.id}"] .widget__inner`);
      let datasets = getDatasetsByWidgetId(self.props.datasets, w.id);

      switch (w.type) {
        case 'kpi-sparkline':
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

export default LegacyDashboardsIndex;
