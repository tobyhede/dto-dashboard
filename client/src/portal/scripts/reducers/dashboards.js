import initialState from './../store/initialState';


const dashboardsReducer = (state = initialState.dashboards, action) => {
  switch (action.type) {
    default:
      return state;
  }
};

export default dashboardsReducer;


// Helpers

export const getDashboardById = (state, id) => {
  return state.find((d) => Number(id) === d.id);
};
