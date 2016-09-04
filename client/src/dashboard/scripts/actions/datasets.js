import * as types from './_types';


export function createDataset(payload) {
  return {
    type: types.CREATE_DATASET,
    payload,
    meta: {}
  }
}

export function createDatasets(payload) {
  return {
    type: types.CREATE_DATASETS,
    payload,
    meta: {}
  }
}
