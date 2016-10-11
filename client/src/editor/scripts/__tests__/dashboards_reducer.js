import expect from 'expect';
import dashboardReducer from './../reducers/dashboards';
import fixtureData from './fixtures/data';
import * as types from './../actions/_types';


describe('dashboards reducer', () => {

  let state;
  let fixture;

  beforeEach(() => {
    state = [fixtureData.dashboards];
    fixture = state[0];
  });

  afterEach(() => {
  });

  it('Will update a dashboard', () => {
    let expectedStateSlice = {...fixture, name:'boo hoo'};
    state = dashboardReducer(state, {
      type: types.SET_DASHBOARDS,
      payload: expectedStateSlice
    });
    expect(state).toInclude(expectedStateSlice);
  });

});
