import test from 'ava';
import _ from 'lodash';
import { PATTERNS, PATTERNSDARK } from './../fixtures/patterns';

import inputData from './../fixtures/data-dashboard-show-hero';

const EXPECTED = [
  [
    {
      "x": "2016-03-01T00:00:00.000Z",
      "y": 99,
      "id": "user-satisfaction",
      "color": "#f2b038",
      "altColor": "url(#xgsat)",
      "altColorDark": "url(#egzhj)",
      "altLineStyle": "12, 5",
      "name": "User satisfaction"
    }, {
      "x": "2016-04-01T00:00:00.000Z",
      "y": 95,
      "id": "user-satisfaction",
      "color": "#f2b038",
      "altColor": "url(#xgsat)",
      "altColorDark": "url(#egzhj)",
      "altLineStyle": "12, 5",
      "name": "User satisfaction"
    }, {
      "x": "2016-05-01T00:00:00.000Z",
      "y": 90,
      "id": "user-satisfaction",
      "color": "#f2b038",
      "altColor": "url(#xgsat)",
      "altColorDark": "url(#egzhj)",
      "altLineStyle": "12, 5",
      "name": "User satisfaction"
    }, {
      "x": "2016-06-01T00:00:00.000Z",
      "y": 97,
      "id": "user-satisfaction",
      "color": "#f2b038",
      "altColor": "url(#xgsat)",
      "altColorDark": "url(#egzhj)",
      "altLineStyle": "12, 5",
      "name": "User satisfaction"
    }], [{
      "x": "2016-03-01T00:00:00.000Z",
      "y": 94,
      "id": "completion-rate",
      "color": "#7066a5",
      "altColor": "url(#rxdmi)",
      "altColorDark": "url(#yjmql)",
      "altLineStyle": "5, 10",
      "name": "Completion rate"
    }, {
      "x": "2016-04-01T00:00:00.000Z",
      "y": 92,
      "id": "completion-rate",
      "color": "#7066a5",
      "altColor": "url(#rxdmi)",
      "altColorDark": "url(#yjmql)",
      "altLineStyle": "5, 10",
      "name": "Completion rate"
    }, {
      "x": "2016-05-01T00:00:00.000Z",
      "y": 97,
      "id": "completion-rate",
      "color": "#7066a5",
      "altColor": "url(#rxdmi)",
      "altColorDark": "url(#yjmql)",
      "altLineStyle": "5, 10",
      "name": "Completion rate"
    }, {
      "x": "2016-06-01T00:00:00.000Z",
      "y": 98,
      "id": "completion-rate",
      "color": "#7066a5",
      "altColor": "url(#rxdmi)",
      "altColorDark": "url(#yjmql)",
      "altLineStyle": "5, 10",
      "name": "Completion rate"
    }], [{
      "x": "2016-03-01T00:00:00.000Z",
      "y": 1.9,
      "id": "digital-take-up",
      "color": "#4892c0",
      "altColor": "url(#sxqmc)",
      "altColorDark": "url(#jknjx)",
      "altLineStyle": "3, 3",
      "name": "Digital take-up"
    }, {
      "x": "2016-04-01T00:00:00.000Z",
      "y": 15,
      "id": "digital-take-up",
      "color": "#4892c0",
      "altColor": "url(#sxqmc)",
      "altColorDark": "url(#jknjx)",
      "altLineStyle": "3, 3",
      "name": "Digital take-up"
    }, {
      "x": "2016-05-01T00:00:00.000Z",
      "y": 14,
      "id": "digital-take-up",
      "color": "#4892c0",
      "altColor": "url(#sxqmc)",
      "altColorDark": "url(#jknjx)",
      "altLineStyle": "3, 3",
      "name": "Digital take-up"
    }, {
      "x": "2016-06-01T00:00:00.000Z",
      "y": 23,
      "id": "digital-take-up",
      "color": "#4892c0",
      "altColor": "url(#sxqmc)",
      "altColorDark": "url(#jknjx)",
      "altLineStyle": "3, 3",
      "name": "Digital take-up"
    }
  ]
];


test.beforeEach(t => {
  require('./../helpers/setup-browser-env');

  window.patterns = PATTERNS;
  window.patternsDark = PATTERNSDARK;

  let convertDataForHero = require('./../../../lib/assets/src/scripts/Helpers/convertData');

  let data = convertDataForHero(inputData);
  let datum = data[0][0];

  t.context.data = {data, datum};
});


test.todo('y should exist for all and be a number between 0 and 100');

test.todo('x should exist for all and be a date');

test.todo('datums with same id should have x as sequential months');
