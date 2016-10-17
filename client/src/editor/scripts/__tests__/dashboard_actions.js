import expect from 'expect';
import nock from 'nock';
import configureStore from 'redux-mock-store';
import apiMiddleware from './../middlewares/api';
import fixtureData from './fixtures/data';
import { updateDashboard } from './../actions/dashboard';


describe('dashboard actions', () => {

  let fixture;

  //Fake Store and Middleware
  const middlewares = [ apiMiddleware ];
  const mockStore = configureStore(middlewares);

  //Fake Data
  const url = 'https://fake-site.com';


  beforeEach(() => {
    fixture = fixtureData.dashboards[0];
  });

  afterEach(() => {
    nock.cleanAll();
  });

  it('updateDashboard expected actions are dispatched on success', () => {
    let newStateSlice = {...fixture, name:'boo hoo'};

    nock(url)
      .put(`/api/v1/dashboards/${fixture.id}`, newStateSlice)
      .reply(200, {data:newStateSlice});

    const expectedActions = [
      { type: 'SET_DASHBOARDS', payload: newStateSlice }
    ];

    const store = mockStore(fixtureData);
    store.dispatch(updateDashboard(newStateSlice));

    setTimeout(() => {
      expect(store.getActions()).to.include(expectedActions);
    }, 1000);
  });

});
