import React, { Component, PropTypes } from 'react';
import { Provider } from 'react-redux';
import { Router, Route, IndexRedirect } from 'react-router';

import Layout from './layout';
import Dashboards from './../pages/dashboards';
import Dashboard from './../pages/dashboard';
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
            <Route path="dashboards" component={Dashboards} store={store} />
            <Route path="dashboard/:id" component={Dashboard} store={store} />
            <Route path="*" component={NoMatch}/>
          </Route>
        </Router>
      </Provider>
    )
  }
};
