import { merge } from 'lodash';
import * as types from './../actions/_types';
import initialState from './../store/initialState';


const dashboardsReducer = (state = initialState.dashboards, action) => {
  switch (action.type) {

    case types.UPDATE_DASHBOARD:
      return state.map((d) => {
        if (d.id === action.payload.id) {
          return {...d, ...action.payload}
        }
        return d;
      });
      break;

    default:
      return state;
  }
};

export default dashboardsReducer;


// Helpers

export const getDashboardById = (state, id) => {
  return state.find((d) => Number(id) === d.id);
};
