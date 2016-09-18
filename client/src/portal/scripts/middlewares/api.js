import fetch from 'whatwg-fetch'; // todo - fetch or axios
import { bindActionCreators } from 'redux';

import * as types from './../actions/_types';
import {
  USE_FIXTURES,
  API_BASE_URL
} from './../config';


const handleError = (error) => {
  return {
    type: types.CALL_API_ERROR,
    error
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

const apiMiddleware = ({dispatch}) => next => action => {

  // if not an API call, pass through as normal

  if (action.type !== types.CALL_API) {
    return next(action);
  }

  bindActionCreators(handleError, dispatch);
  bindActionCreators(apiStart, dispatch);
  bindActionCreators(apiEnd, dispatch);


  // if it's an API call, decorate it with middleware behaviour

  const { payload: { method, url, success, error, data } } = action;

  apiStart();


  if (USE_FIXTURES) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        apiEnd();
        resolve(dispatch({ type: success, payload: data, meta:{ status:'success'} }));  // success interface
        // reject(dispatch({ type: error, error:{}, meta: { status: 'error'} }));  // failure interface
      }, 800);
    });
  }

  return fetch(`${API_BASE_URL}${url}`, {
    method
  })
    .then(response => {
      if (response.status >= 300) {
        throw new Error(response.status);
      } else {
        response.json()
          .then(data => {
            apiEnd();
            dispatch({ type: action.next, payload: data });  // todo - type: success
          });
      }
    })
    .catch(error => {
      apiEnd();
      handleError(error)
    });
};

export default apiMiddleware;
