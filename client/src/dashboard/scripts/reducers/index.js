import { combineReducers } from 'redux';

import app from './app';
import ui from './ui';
import widgets from './widgets';
import datasets from './datasets';


const rootReducer = combineReducers({
  app,
  ui,
  widgets,
  datasets
});

export default rootReducer;
