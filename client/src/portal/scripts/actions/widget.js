import * as types from "./_types";


export const updateWidget = formData => ({
  type: types.API,
  payload: {
    url: 'widgets',
    method: 'POST',
    data: formData,
    // pending: types.UPDATE_WIDGETS_PENDING,
    success: types.SET_WIDGETS,
    error: types.UPDATE_WIDGETS_FAIL
  }
});
