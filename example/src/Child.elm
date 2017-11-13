module Child exposing (..)

import Html exposing (Html, div)
import InlineSvg exposing (inline)


{ icon } =
    inline
        { code = "./svg/code.svg"
        }


view : Html ()
view =
    div [] [ icon .code [] ]
