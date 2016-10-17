import expect from 'expect';
import uiReducer from './../reducers/ui';
import initState from './../store/initialState';

import {
  editFormAtDashboardPage,
  editFormAtDashboardWidgetPage,
  editFormAtDatasetPage,
  editFormAtDatasetDatapointPage,
  editFormAtDatasetDatapointCreatePage
} from './../actions/ui';


describe('ui reducer', () => {

  let state;

  const testSetIseditingOnce = (domain, action, mode) => {
    const expectedStateSlice = {
      [domain]: { isEditing: mode }
    };
    state = uiReducer(state, action(mode));
    expect(state).toInclude(expectedStateSlice);
  };

  const testSetIseditingTwice = (domain, action, mode1, mode2) => {
    const expectedStateSlice = {
      [domain]: { isEditing: mode2 }
    };
    state = uiReducer(state, action(mode1));
    state = uiReducer(state, action(mode2));
    expect(state).toInclude(expectedStateSlice);
  };


  beforeEach(() => {
    state = initState.ui;
  });
  afterEach(() => {
  });

  /**
   * pageDashboard
   */
  it('Will set pageDashboard isEditing to true', () => {
    testSetIseditingOnce('pageDashboard', editFormAtDashboardPage, true)
  });
  it('Will set pageDashboard isEditing to true then false', () => {
    testSetIseditingTwice('pageDashboard', editFormAtDashboardPage, true, false)
  });

  /**
   * pageDashboardWidget
   */
  it('Will set pageDashboardWidget isEditing to true', () => {
    testSetIseditingOnce('pageDashboardWidget', editFormAtDashboardWidgetPage, true);
  });

  it('Will set pageDashboardWidget isEditing to true then false', () => {
    testSetIseditingTwice('pageDashboardWidget', editFormAtDashboardWidgetPage, true, false);
  });

  /**
   * pageDataset
   */
  it('Will set pageDataset isEditing to true', () => {
    testSetIseditingOnce('pageDataset', editFormAtDatasetPage, true);
  });

  it('Will set pageDataset isEditing to true then false', () => {
    testSetIseditingTwice('pageDataset', editFormAtDatasetPage, true, false);
  });

  /**
   * pageDatasetDatapoint
   */
  it('Will set pageDatasetDatapoint isEditing to true', () => {
    testSetIseditingOnce('pageDatasetDatapoint', editFormAtDatasetDatapointPage, true);
  });

  it('Will set pageDatasetDatapoint isEditing to true then false', () => {
    testSetIseditingTwice('pageDatasetDatapoint', editFormAtDatasetDatapointPage, true, false);
  });

  /**
   * pageDatasetDatapointCreate
   */
  it('Will set pageDatasetDatapoint isEditing to true', () => {
    testSetIseditingOnce('pageDatasetDatapointCreate', editFormAtDatasetDatapointCreatePage, true);
  });

  it('Will set pageDatasetDatapoint isEditing to true then false', () => {
    testSetIseditingTwice('pageDatasetDatapointCreate', editFormAtDatasetDatapointCreatePage, true, false);
  });
});
