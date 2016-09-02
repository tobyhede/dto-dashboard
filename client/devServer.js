import webpack from 'webpack';
import WebpackDevServer from 'webpack-dev-server';

import * as CONFIG from './_config';
import webpackConfig from './webpack.config.devserver';


let devServerPublicPath = `http://${CONFIG.HOST}:${CONFIG.PORT}/`;
webpackConfig.output.publicPath = devServerPublicPath;

// same as --inline
// webpack/hot/dev-server will reload the entire page if the HMR update fails.
// If you want to reload the page on your own, you can add
// webpack/hot/only-dev-server to the entry point instead.
for(let [key, value] of Object.entries(webpackConfig.entry)) {
	if (!Array.isArray(value)) {
		throw new Error('Entry value must be an array');
	}
	value.unshift(
		`webpack-dev-server/client?${devServerPublicPath}`,
		'webpack/hot/dev-server',    // reload if HMR fails
    // './../../client/src/dashboard'
	);
}

// same as: --hot
webpackConfig.plugins.push(new webpack.HotModuleReplacementPlugin());


// create an instance of webpack compiler
var devCompiler = webpack(webpackConfig);

// create an instance of webpack-dev-server
let devServer = new WebpackDevServer(devCompiler, {
  publicPath: devServerPublicPath,
  hot: true,
  // Set this as true if you want to access dev server from arbitrary url.
  // This is handy if you are using a html5 router.
  historyApiFallback: false,
  noInfo: false,
  quiet: false,
  stats: {
	  colors: true
  }
});

// bind the server to location and callback
devServer.listen(CONFIG.PORT, CONFIG.HOST, function (err) {
	if (err) {
		console.log(err);
	}
	console.log(`Listening at ${devServerPublicPath}..`);
});


export default devServer;
