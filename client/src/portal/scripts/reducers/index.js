import { combineReducers } from 'redux';
import { routerReducer } from 'react-router-redux'

import app from './app';
import ui from './ui';
import currentUser from './currentUser';
import dashboards from './dashboards';


const rootReducer = combineReducers({
  routing: routerReducer,
  app,
  ui,
  currentUser,
  dashboards
});

export default rootReducer;
