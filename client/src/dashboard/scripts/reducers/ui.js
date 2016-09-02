import initialState from './../store/initialState';
import * as types from './../actions/_types';
import { combineReducers } from 'redux';


const app = (state = initialState.ui.app, action) => {
  switch (action.type) {
    case types.DOIN_IT:
    default:
      return state;
  }
};

const uiReducer = combineReducers({
  app: app
});

export default uiReducer;
