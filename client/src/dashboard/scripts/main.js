import { merge } from 'lodash';
import configureStore from './store/configureStore';
import initialState from './store/initialState';


const bootState = merge(initialState, window.__INITIAL_STATE__);

const store = configureStore(bootState, true);
