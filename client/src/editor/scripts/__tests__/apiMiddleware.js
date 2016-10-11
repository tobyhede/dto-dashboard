import {merge} from 'lodash';
import * as types from './../actions/_types';
import apiMiddleware from './../middlewares/api';
import {state, config} from './fixtures/data';


const fakeState = merge(state, {config});

const createFakeStore = (fakeData = {}) => ({
  getState() {
    return merge(fakeState, fakeData)
  }
});

const dispatchWithStoreOf = (storeData, action) => {
  let dispatched = null;
  const dispatch = apiMiddleware(createFakeStore(storeData))(actionAttempt => dispatched = actionAttempt);
  dispatch(action);
  return dispatched;
};

describe('api middleware', () => {

  it('should dispatch if store is empty', () => {
    const action = {
      type: 'do nothing'
    };

    expect(
      dispatchWithStoreOf({}, action)
    ).toEqual(action);
  })
});
