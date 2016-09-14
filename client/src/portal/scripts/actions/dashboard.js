import * as types from "./_types";
import { update } from './../api/dashboard';


export function updateDashboard(formData = {}) {
  return (dispatch, getState) => {
    return update(formData.id, formData).then(
      (resp) => {
        return dispatch({
          type: types.UPDATE_DASHBOARD_SUCCESS,
          payload: resp.data
        });
      },
      (error) => {
        return dispatch({
          type: types.UPDATE_DASHBOARD_FAIL,
          error: error,
          payload: formData
        })
      }
    )
  }
}
