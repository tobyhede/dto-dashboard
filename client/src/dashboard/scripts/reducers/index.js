import { combineReducers } from 'redux';

import app from './app';
import ui from './ui';
import widgets from './widgets';
import datums from './datums';


const rootReducer = combineReducers({
  app,
  ui,
  widgets,
  datums
});

export default rootReducer;
