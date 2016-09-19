import fetch from 'whatwg-fetch';
import { bindActionCreators } from 'redux';
import uuid from 'uuid';

import * as types from './../actions/_types';
import {
  USE_FIXTURES,
  API_BASE_URL
} from './../config';


const handleError = (error, data) => {
  return {
    type: types.CALL_API_ERROR,
    payload: error,
    error: true,
    meta: {
      data
    }
  }
};

const apiStart = () => {
  return {
    type: types.CALL_API_START
  }
};

const apiEnd = () => {
  return {
    type: types.CALL_API_DONE
  }
};


/**
 * @type {ReduxMiddleware}
 * @returns result - next(action) - pipe the action to the next middleware,
 * using dispatch instead will pass the action back to the start of the
 * middleware chain
 */
const apiMiddleware = ({dispatch, getState}) => next => action => {

  // if not an API call, do not decorate with middleware
  if (action.type !== types.CALL_API) {
    return next(action);
  }

  const { payload: { method, url, success, error, data } } = action;


  apiStart();

  if (USE_FIXTURES) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (!data.id) {
          data.id = uuid.v1();
        }
        apiEnd();
        return resolve(next({ type: success, payload: data }));  // success interface
        // return reject(next({ type: error, error:{}, meta: { data } }));  // failure interface
      }, 800);
    });
  }

  return fetch(`${API_BASE_URL}${url}`, {
    method,
    // body, credentials,
    // headers: {'Content-Type': 'application/json'}
  })
    .then(response => {
      if (response.status >= 300) {
        throw new Error(response.status);
      } else {
        response.json()
          .then(d => {
            apiEnd();
            return next({type: success, payload: d});
          });
      }
    })
    .catch(error => {
      apiEnd();
      return next(handleError(error, data))
    });
};

export default apiMiddleware;
