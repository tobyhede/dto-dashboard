import * as types from "./_types";


export const updateDataset = formData => {
  return {
    type: types.CALL_API,
    payload: {
      url: 'datasets',
      method: 'POST',
      data: formData,
      // pending: types.UPDATE_DATASETS_PENDING,
      success: types.SET_DATASETS,
      error: types.UPDATE_DATASETS_FAIL
    }
  }
};
