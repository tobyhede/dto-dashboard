import * as types from "./_types";
import { update } from './../api/datapoint';


export function updateDatapoint(formData = {}) {
  return (dispatch, getState) => {
    return update(formData.id, formData).then(
      (resp) => {
        return dispatch({
          type: types.UPDATE_DATAPOINT_SUCCESS,
          payload: resp.data
        });
      },
      (error) => {
        return dispatch({
          type: types.UPDATE_DATAPOINT_FAIL,
          error: error,
          payload: formData
        })
      }
    )
  }
}
