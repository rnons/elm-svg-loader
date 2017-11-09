# SVG loader for Elm

A webpack loader that inlines external SVG file into Elm views. It consists of a elm package and a npm package.

Inspired by [elm-css-modules-loader](https://github.com/cultureamp/elm-css-modules-loader).

<a target='_blank' rel='nofollow' href='http://app.codesponsor.io/link/Uwsz51h7LnBMxKdsoXrxgQps/rnons/elm-svg-loader'>
  <img alt='Sponsor' width='888' height='68' src='http://app.codesponsor.io/embed/Uwsz51h7LnBMxKdsoXrxgQps/rnons/elm-svg-loader.svg' />
</a>

## Overview

```
module Main exposing (..)

import Svg.Attributes
imort InlineSvg exposing (inline)

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
yarn install raw-loader elm-svg-loader --dev
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
var _rnons$elm_svg_loader$Main$_p0 = _rnons$elm_svg_loader$InlineSvg$inline(
	{github: './svg/mark-github.svg', share: './svg/share.svg'});
```

2. `elm-svg-loader` will replace the svg file location with a `require` statement
```
var _rnons$elm_svg_loader$Main$_p0 = _rnons$elm_svg_loader$InlineSvg$inline(
	{github: require('./svg/mark-github.svg'), share: require('./svg/share.svg')});
```

3. With the help of `raw-loader`, in runtime, `require('./svg/mark-github.svg')` will become the actual svg file content.

4. The Elm package uses [elm-svg-parser](https://github.com/rnons/elm-svg-parser) to convert `String` to a `Html msg` so that it can be used in Elm views.
