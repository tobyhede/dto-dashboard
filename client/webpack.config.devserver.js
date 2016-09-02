import webpack from 'webpack';
import BellOnBundlerErrorPlugin from 'bell-on-bundler-error-plugin';
import autoprefixer from 'autoprefixer';
import * as CONFIG from './_config';

const projectName = require('./../package').name;


let webpackConfig = {
	name: projectName,
	bail: true,
	debug: true,
	devtool: 'eval',        // better sourcemaps -> cheap-module-eval-source-map
	context: CONFIG.DIR_SRC,
  entry: {
    ['dashboard']: [`./dashboard`],
  },
	output: {
		path: CONFIG.DIR_DIST,
		filename: 'javascripts/[name].js',       // relative     - determines output file
    publicPath:  `/`,     // Web root. publicPath + filename must equal resource path in dev server
		// publicPath:  `http://${CONFIG.HOST}:${CONFIG.PORT}/`
		sourceMapFilename: "javascripts/[name].js.map"
	},
	externals: {
	},
	module: {
		preLoaders: [
      {
        test: /client\/src\/\.(js)$/,
        loader: "eslint"
      }
		],
		loaders: [
			{
				test: /\.(js|json)$/,
				loaders: ['babel'],
				exclude: /node_modules/
			},
			{
        test: /\.(scss)$/,
				loader: 'style!css?&sourceMap!postcss!sass?sourceMap'
			},
			{
				test: /\.(jpe?g|gif|png|svg)$/,
				loader: "file?name=images/[name].[ext]"
			},
			{
				test: /\.(eot|ttf|woff|svg|woff2)$/,
				loader: "url?limit=10000&name=fonts/[name].[ext]"
			}
		]
	},
	plugins: [
		new webpack.DefinePlugin({
			'process.env.NODE_ENV': JSON.stringify(CONFIG.ENV),
          __DEV__: true
		}),
		new BellOnBundlerErrorPlugin()
	],
	resolve: {
		extensions : ['', '.js', '.scss']
	},
	node: {
		fs: 'empty'
	},

  postcss : [
    autoprefixer()
  ],
	sassLoader: {
		precision: 8,
		includePaths: [
			CONFIG.DIR_SRC,
			CONFIG.DIR_NPM
		],
		sourceMap: true,
		lineNumbers: true,
		bundleExec: true,
		data: `$env:  ${CONFIG.ENV === 'production' ? 'production' : 'development'};`
	}
};

export default webpackConfig;
