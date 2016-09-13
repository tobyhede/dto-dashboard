import * as types from "./_types";


export function updateDashboard(formData = {}) {
  return {
    type: types.UPDATE_DASHBOARD,
    payload: formData,
    meta: {}
  }
}
