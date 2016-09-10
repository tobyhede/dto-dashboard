import React from 'react';
import { render } from 'react-dom';
import { merge } from 'lodash';
import { hashHistory } from 'react-router';
import { syncHistoryWithStore } from 'react-router-redux';

import configureStore from './store/configureStore';
import initialState from './store/initialState';
import Root from './containers/root';


const bootState = merge(initialState, window.__INITIAL_STATE__);
const store = configureStore(bootState, hashHistory);
const history = syncHistoryWithStore(hashHistory, store);

render(
  <Root store={store} history={history} />,
  document.getElementById('portal_index')
);
