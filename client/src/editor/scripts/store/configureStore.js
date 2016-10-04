let window = window || global;
import { createStore, applyMiddleware, compose } from 'redux';
import thunkMiddleware from 'redux-thunk';
import { routerMiddleware } from 'react-router-redux';

import apiMiddleware from './../middlewares/api';
import rootReducer from './../reducers';


export default function configureStore(bootState, history, debug = __DEV__) {
  const middlewares = [
    apiMiddleware,
    thunkMiddleware,
    routerMiddleware(history)
  ];

  return compose(applyMiddleware(...middlewares), debug && window.devToolsExtension ? window.devToolsExtension() : f => f)(createStore)(
    rootReducer,
    bootState
  );
}
