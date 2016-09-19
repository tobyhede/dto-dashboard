import * as types from "./_types";


export const updateDashboard = formData => {
  return {
    type: types.CALL_API,
    payload: {
      url: 'dashboards',
      method: 'POST',
      data: formData,
      // pending: types.UPDATE_DASHBOARDS_PENDING,
      success: types.SET_DASHBOARDS,
      error: types.UPDATE_DASHBOARDS_FAIL
    }
  }
};
