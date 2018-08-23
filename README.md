# SVG loader for Elm

**NOTE: This repo is not maintained any more. Feel free to fork and upload to elm-packages by yourself.**

[![npm](https://img.shields.io/npm/v/elm-svg-loader.svg)](https://www.npmjs.com/package/elm-svg-loader)
[![Elm package](https://img.shields.io/elm-package/v/rnons/elm-svg-loader.svg)](http://package.elm-lang.org/packages/rnons/elm-svg-loader/latest)

A webpack loader that inlines external SVG file into Elm views. It consists of a elm package and a npm package. [DEMO](https://rnons.github.io/elm-svg-loader).

Inspired by [elm-css-modules-loader](https://github.com/cultureamp/elm-css-modules-loader).

## Overview

```
module Main exposing (..)

import Svg.Attributes
import InlineSvg exposing (inline)

{ icon } =
    inline
        { github = "./svg/github.svg"
        , share = "./svg/share.svg"
        }

view =
    div
        []
        [ icon .github [ Svg.Attributes.class "icon icon--github" ]
        , icon .share [ Svg.Attributes.class "icon icon--share" ]
        ]
```

## Setup

Add `elm-svg-loader` and `raw-loader` to your project.

```
npm install raw-loader elm-svg-loader --save-dev
```

or

```
yarn add raw-loader elm-svg-loader --dev
```

### Webpack config

```
module.exports = {
  ⋮
  module: {
    rules: [
      {
        test: /\.elm$/,
        use: [
          {
            loader: "elm-svg-loader",
          },
          {
            loader: "elm-webpack",
          }
        ],
      },
      {
        test: /\.svg$/,
        loaders: ["raw-loader"]
      }
      ⋮
    ],
  },
};
```

### Elm package

```
elm-package install rnons/elm-svg-loader
```

Then you can `import InlineSvg` as in the [Overview](#overview) section.


## Under the hood

1. Without `elm-svg-loader`, webpack will compile

    ```
    { icon } =
        inline
            { github = "./svg/github.svg"
            , share = "./svg/share.svg"
            }
    ```

    to

    ```
    var _user$project$Main$_p0 = _rnons$elm_svg_loader$InlineSvg$inline(
      {github: './svg/mark-github.svg', share: './svg/share.svg'});
    ```

2. `elm-svg-loader` will replace the svg file location with a `require` statement

    ```
    var _user$project$Main$_p0 = _rnons$elm_svg_loader$InlineSvg$inline(
      {github: require('./svg/mark-github.svg'), share: require('./svg/share.svg')});
    ```

3. With the help of `raw-loader`, `require('./svg/mark-github.svg')` will become the actual svg file content.

4. With the help of [elm-svg-parser](https://github.com/rnons/elm-svg-parser), the `icon` function in `icon .github []` parses the svg file content `String` to a `Html msg` so that it can be used in Elm views.
