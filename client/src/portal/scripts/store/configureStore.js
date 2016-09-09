let window = window || global;
import { createStore, applyMiddleware, compose } from 'redux';
import { routerMiddleware } from 'react-router-redux';
import thunkMiddleware from 'redux-thunk';

import rootReducer from './../reducers';


export default function configureStore(bootState, debug = __DEV__) {
  const middlewares = [
    thunkMiddleware,
    routerMiddleware
  ];

  return compose(applyMiddleware(...middlewares), debug && window.devToolsExtension ? window.devToolsExtension() : f => f)(createStore)(
    rootReducer,
    bootState
  );
}
