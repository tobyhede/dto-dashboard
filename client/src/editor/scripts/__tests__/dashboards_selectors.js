import expect from 'expect';
import { getDashboardById } from './../reducers/dashboards';
import fixtureData from './fixtures/data';


describe('dashboards reducers', () => {

  let state = fixtureData.dashboards;
  let fixture = state[0];

  it(`can retrieve a dashboard by its' id`, () => {
    expect(getDashboardById(state, fixture.id)).toBe(fixture);
  });

});
