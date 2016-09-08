import { selectAll } from 'd3-selection';
import { createWidgets } from './../actions/widgets';
import { createDatasets } from './../actions/datasets';


class LegacyDashboardShow {

  constructor(store) {
    let self = this;
    store.subscribe(() => {
      self.props = this.state;
      self.onPropsChange();
    });
    this.serializeWidgets(this.fetchWidgets(), store.dispatch);
  }

  serializeWidgets(widgets, dispatch) {
    widgets.forEach((w) => {
      w.datasets.forEach((d) => {
        d.widget_id = w.id;
      });
      dispatch(createDatasets(w.datasets));
      delete w.datasets;
    });
    dispatch(createWidgets(widgets));
  }

  fetchWidgets() {
    let _widgetsData = [];
    selectAll('.bar .widget__inner').each(function() {
      console.log(this);
      _widgetsData.push(JSON.parse(this.getAttribute('data-data')));
    });
    selectAll('.sparkline .widget__inner').each(function() {
      _widgetsData.push(JSON.parse(this.getAttribute('data-data')));
    });
    selectAll('.line .widget__inner').each(function() {
      _widgetsData.push(JSON.parse(this.getAttribute('data-data')));
    });
    selectAll('.pie .widget__inner').each(function() {
      _widgetsData.push(JSON.parse(this.getAttribute('data-data')));
    });
    selectAll('.fact .widget__inner').each(function() {
      _widgetsData.push(JSON.parse(this.getAttribute('data-data')));
    });
    return _widgetsData;
  }

  onPropsChange() {
    console.log(this.props);
    // todo
  }
}

export default LegacyDashboardShow;
