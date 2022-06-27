const path    = require("path")
const glob = require('glob')
const { VueLoaderPlugin } = require("vue-loader")
const webpack = require("webpack")

const entries = {};
glob.sync('./app/javascript/*.js').forEach((file) => {
  const name = file.replace('./app/javascript/', '').split('.')[0];
  entries[name] = file;
});

module.exports = {
  mode: "production",
  devtool: "source-map",
  entry: entries,
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "..", "..", "app/assets/builds"),
  },
  plugins: [
    new VueLoaderPlugin(),
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    })
  ],
  module: {
    rules: [
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        use: ["babel-loader"]
      },
      {
        test: /\.vue$/,
        loader: "vue-loader"
      },
    ],
  },
}
