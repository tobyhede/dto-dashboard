import './styles/main.scss';

import './images/coatofarms.png';
import './images/coatofarms.svg';
import './images/dashboard.svg';
import './images/dto.png';
import './images/gov-performance.png';
import './images/gov-performance.svg';
import './images/govau.svg';
import './images/performance.svg';
import './images/title.svg';


// // check if HMR is enabled
if (module.hot) {
  // accept itself
  module.hot.accept();

  // todo - improve
  // charts depend on CSS layout, so delay the
  // async render to allow css to inject first.
  // this is only an issue on dev-server mode.
  // http://stackoverflow.com/questions/39400038/how-to-ensure-that-hot-css-loads-before-js-in-webpack-dev-server
  console.log('Start: delaying JS execution by 3 seconds.');
  setTimeout(() => {
    console.log('Executing.');
    require('./scripts/main');
  }, 3000);
} else {
  require('./scripts/main');
}

function toggleHighContrastMode(value) {
  if (value === "on") {
    isHighContrastMode = true;
  } else if (value === "off") {
    isHighContrastMode = false;
  } else {
    isHighContrastMode = !isHighContrastMode;
  }
  handleGaEvent(isHighContrastMode ? track.ENABLE_HIGH_CONTRAST : track.DISABLE_HIGH_CONTRAST);
  // switch to high contrast mode
  d3.select('body').classed('is-high-contrast', isHighContrastMode);
  modeButton.classed('is-high-contrast', isHighContrastMode);

  charts.forEach((c) => {
    c.switchColorMode(isHighContrastMode);
  });
  if (localStorage) {
    localStorage.setItem('high_contrast_mode', isHighContrastMode ? "on" : "off");
  }
}

if (localStorage) {
  let storedHighContrastMode = localStorage.getItem('high_contrast_mode');
  if (storedHighContrastMode === "on") {  // localStorage sets Boolean as String
    // must jquery trigger to trick the css checkbox to "switch" - :(
    $modeButton.trigger('click');
    // programmatically trigger the application values
    toggleHighContrastMode.call(this, "on")
  } else {
    // programmatically trigger the application values
    toggleHighContrastMode.call(this, "off");
  }
}

modeButton.on('click', toggleHighContrastMode);
