import path from 'path';

export const ENV = process.env.NODE_ENV || 'development';
export const WEBPACK_HOST = 'localhost';
export const WEBPACK_PORT = 8080;
export const DIR_ROOT = path.resolve('./');
export const DIR_SRC = path.join(DIR_ROOT, '/client/src');
export const DIR_TEST = path.join(DIR_ROOT, '/client/test');
export const DIR_NPM = path.join(DIR_ROOT, '/node_modules');
export const DIR_DIST = path.join(DIR_ROOT, '/lib/assets');

export const RAILS_HTTP = 'http://localhost:3000/';
