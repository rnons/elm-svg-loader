const HtmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
  context: __dirname,
  entry: "./src/main.js",
  output: {
    path: __dirname,
    filename: "main.js"
  },
  resolve: {
    extensions: [".js"]
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        use: [
          {
            loader: "elm-svg-loader",
            options: {
              package: "user/project"
            }
          },
          {
            loader: "elm-webpack-loader"
          }
        ]
      },
      {
        test: /\.svg$/,
        loaders: ["raw-loader"]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "src/index.html",
      filename: "index.html",
      minify: {
        collapseWhitespace: true
      }
    })
  ]
};
