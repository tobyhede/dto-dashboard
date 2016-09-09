module.exports = {
  "parser": "babel-eslint",
  "plugins": [
    "react"
  ],
  "extends": [
    "eslint:recommended",
    "formidable",
  ],
  "env": {
    "es6": true,
    "browser": true,
    "node": true
  },
  "globals": {
    "window": true,
    "__DEV__": true
  },
  "rules": {
    // Best Practices
    // disallow the use of alert, confirm, and prompt
    "no-alert": 1,
    // disallow the use of console
    "no-console": 0,
    // no undefined
    "no-undef": 1,

    // Stylistic
    // specify whether double or single quotes should be used
    "quotes": [1, "single"],
    // require or disallow use of semicolons instead of ASI
    "semi": 1
  }
};
