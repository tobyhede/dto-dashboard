import { normalize } from 'normalizr';

import initialState from './../store/initialState';
import * as types from './../actions/_types';
import schemas from './../schemas';


const widget = (state = {}, action) => {
  switch (action.type) {
    case types.CREATE_WIDGET:
      let { id, name } = action.data;
      return normalize({
        id,
        name
      }, schemas.WIDGET);
    default:
      return state;
  }
};

const widgetsReducer = (state = initialState.widgets, action) => {
  switch (action.type) {
    case types.CREATE_WIDGET:
      return [
        ...state,
        widget('', action)
      ];
    default:
      return state;
  }
};

export default widgetsReducer;


// Helpers

