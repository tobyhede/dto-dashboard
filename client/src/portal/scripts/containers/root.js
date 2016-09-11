import React, { Component, PropTypes } from 'react';
import { Provider } from 'react-redux';
import { Router, Route, IndexRedirect, IndexRoute } from 'react-router';

import Layout from './layout';
import Dashboards from './../pages/dashboards';
import DashboardLayout from './../pages/dashboard.js';
import DashboardView from './../pages/dashboard/index';
import DashboardEdit from './../pages/dashboard/edit';
import NoMatch from './../pages/no-match';


export default class Root extends Component {

  static propTypes = {
    store: PropTypes.object,
    history: PropTypes.object
  };

  render() {
    let { store, history } = this.props;
    return (
      <Provider store={store}>
        <Router history={history}>
          <Route path="/" component={Layout}>
            <IndexRedirect to="dashboards" />
            <Route path="dashboards" component={Dashboards} />
            <Route path="dashboard/:id" component={DashboardLayout}>
              <IndexRoute component={DashboardView} />
              <Route path="edit" component={DashboardEdit} />
              {/*<Route path="new" component={DashboardNew} />*/}
            </Route>
            <Route path="*" component={NoMatch}/>
          </Route>
        </Router>
      </Provider>
    )
  }
};
