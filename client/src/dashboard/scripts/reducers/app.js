import initialState from './../store/initialState';
import * as types from './../actions/_types';


const appReducer = (state = initialState.app, action) => {
  switch (action.type) {
    case types.SET_HIGH_CONTRAST:
      return {...state, highContrast: action.payload.highContrast};
    default:
      return state;
  }
};

export default appReducer;


// Helpers
