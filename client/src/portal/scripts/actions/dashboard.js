import * as type from "./_types";


export function updateDashboard(id, formData = {}) {
  return {
    type: types.UPDATE_DASHBOARD,
    payload: {
      dashboard_id: id,
      ...formData
    },
    meta: {}
  }
}
