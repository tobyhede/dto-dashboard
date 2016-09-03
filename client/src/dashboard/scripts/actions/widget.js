import * as types from './_types';

export function createWidget(payload) {
  return {
    type: types.CREATE_WIDGET,
    payload,
    meta: {}
  }
}

