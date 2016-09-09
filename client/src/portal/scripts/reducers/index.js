import { combineReducers } from 'redux';
import { routerReducer } from 'react-router-redux'

import app from './app';
import ui from './ui';


const rootReducer = combineReducers({
  routing: routerReducer,
  app,
  ui
});

export default rootReducer;
