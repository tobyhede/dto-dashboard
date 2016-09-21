import * as types from "./_types";


export const updateDatapoint = formData => ({
  type: types.API,
  payload: {
    url: 'datapoints',
    method: 'POST',
    data: formData,
    // pending: types.UPDATE_DATAPOINTS_PENDING,
    success: types.SET_DATAPOINTS,
    error: types.UPDATE_DATAPOINTS_FAIL
  }
});

export const createDatapoint = formData => ({
  type: types.API,
  payload: {
    url: 'datapoints',
    method: 'POST',
    data: formData,
    // pending: types.CREATE_DATAPOINT_PENDING,
    success: types.PUSH_DATAPOINT,
    error: types.CREATE_DATAPOINT_FAIL
  }
});
