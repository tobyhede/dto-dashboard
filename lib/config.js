'use strict';

var env = process.env.NODE_ENV || 'development'

var config = {}

try {
  config = require(`../config/${env}.js`);
}
catch (e) {
 console.log('Error loading environment config')
 console.log(e)
}

module.exports = config;
