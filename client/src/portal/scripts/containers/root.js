import React, { Component } from 'react';
import { Provider } from 'react-redux';
import { Router, Route, hashHistory, IndexRedirect } from 'react-router';

import Layout from './layout';
import Dashboards from './../pages/dashboards';
import Dashboard from './../pages/dashboard';
import NoMatch from './../pages/no-match';


export default class Root extends Component {
  render() {
    let { store } = this.props;
    return (
      <Provider store={store}>
        <Router history={hashHistory}>
          <Route path="/" component={Layout}>
            <IndexRedirect to="dashboards" />
            <Route path="dashboards" component={Dashboards} store={store} />
            <Route path="dashboard/:id" component={Dashboard} store={store} />
            <Route path="*" component={NoMatch}/>
          </Route>
        </Router>
      </Provider>
    )
  }
};
