import initialState from './../store/initialState';


const datapointsReducer = (state = initialState.datapoints, action) => {
  switch (action.type) {
    default:
      return state;
  }
};

export default datapointsReducer;


// Helpers

/**
 * @param state
 * @param id
 * @returns {Object} - datapoint
 */
export const getDatapointById = (state, id) => {
  return state.find((d) => Number(id) === d.id);
};

/**
 * @param state
 * @param dataset_id
 * @returns {Array} - datapoints
 */
export const getDatapointsByDatasetId = (state, dataset_id) => {
  return state.filter((w) => Number(dataset_id) === w.dataset_id);
};
