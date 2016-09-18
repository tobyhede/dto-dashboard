import * as types from "./_types";


// export const fetchDashboards = () => ({
//   type: types.CALL_API,
//   payload: {
//     method: 'GET',
//     url: 'dashboards.json',
//     success: types.SET_DASHBOARDS
//   }
// });
//
// export const saveDashboards = (dashboard) => ({
//   type: types.CALL_API,
//   payload: {
//     method: 'POST',
//     url: 'dashboards',
//     success: types.SET_DASHBOARDS
//   }
// });


export const updateDashboard = formData => {
  if (!formData) {
    throw new Error(`Can't submit dashboard without data.`)
  }
  debugger
  return {
    type: types.CALL_API,
    payload: {
      url: 'dashboards',
      method: 'POST',
      data: formData,
      // pending: types.UPDATE_DASHBOARD_PENDING,
      success: types.UPDATE_DASHBOARD_SUCCESS,
      error: types.UPDATE_DASHBOARD_FAIL
    }
  }
};
