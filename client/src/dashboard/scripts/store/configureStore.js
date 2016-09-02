let window = require('window');
import { createStore, applyMiddleware, compose } from 'redux';
import thunkMiddleware from 'redux-thunk';
import createLogger from 'redux-logger';
import rootReducer from './../reducers';


export default function configureStore(state, debug = false) {
  const middlewares = [
    thunkMiddleware
  ];

  if (__DEV__) {
    middlewares.push(createLogger());
    if (window.devToolsExtension) {
      window.devToolsExtension();
    }
  }

  return compose(applyMiddleware(...middlewares))(createStore)(
    rootReducer,
    state
  );
}
