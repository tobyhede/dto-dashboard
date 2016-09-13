import * as types from "./_types";


export function updateDashboard(id, formData = {}) {
  return {
    type: types.UPDATE_DASHBOARD,
    payload: formData,
    meta: {}
  }
}
