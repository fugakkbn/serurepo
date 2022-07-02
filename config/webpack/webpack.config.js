const path = require("path")
const glob = require('glob')
const { VueLoaderPlugin } = require("vue-loader")
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin')

const entries = {};
glob.sync('./app/javascript/*.{js,ts}').forEach((file) => {
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
    new ForkTsCheckerWebpackPlugin(),
  ],
  module: {
    rules: [
      {
        test: /\.(js|ts)$/,
        exclude: /node_modules/,
        use: ["babel-loader", "ts-loader"],
      },
      {
        test: /\.vue$/,
        loader: "vue-loader"
      },
    ],
  },
}
