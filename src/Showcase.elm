module Showcase exposing (..)

import Html exposing (Html, div, h1, p, a, text)
import InlineSvg exposing (inline)


{ icon } =
    inline
        { code = "./svg/code.svg"
        }


view : () -> Html ()
view () =
    div [] [ icon .code [] ]
