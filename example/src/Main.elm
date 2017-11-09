module Main exposing (..)

import Html exposing (Html, div, text)
import Svg.Attributes
import InlineSvg exposing (inline)


{ icon } =
    inline
        { eye = "./svg/eye.svg"
        , github = "./svg/mark-github.svg"
        , code = "./svg/code.svg"
        }


view : () -> Html ()
view () =
    div
        []
        [ icon .eye [ Svg.Attributes.class "icon" ]
        , icon .github [ Svg.Attributes.class "icon" ]
        , icon .code [ Svg.Attributes.class "icon" ]
        ]


main : Program Never () ()
main =
    Html.beginnerProgram
        { model = ()
        , update = \() () -> ()
        , view = view
        }
