module Main exposing (..)

import Html exposing (Html, div, h1, p, a, text)
import Html.Attributes exposing (href)
import Svg.Attributes
import InlineSvg exposing (inline)
import Showcase


{ icon } =
    inline
        { eye = "./svg/eye.svg"
        , github = "./svg/mark-github.svg"
        , code = "./svg/code.svg"
        }


view : () -> Html ()
view () =
    let
        repoUrl =
            "https://github.com/rnons/elm-svg-loader"

        demoSourceUrl =
            repoUrl ++ "/tree/gh-pages"
    in
        div
            []
            [ h1 []
                [ text "An "
                , a [ href repoUrl ] [ text "elm-svg-loader" ]
                , text " example"
                ]
            , p []
                [ a [ href demoSourceUrl ] [ text "source code" ]
                ]
            , div
                []
              <|
                List.map (a [ href repoUrl ] << List.singleton)
                    [ icon .eye [ Svg.Attributes.class "icon" ]
                    , icon .github [ Svg.Attributes.class "icon" ]
                    , icon .code [ Svg.Attributes.class "icon" ]
                    ]
            , Showcase.view ()
            ]


main : Program Never () ()
main =
    Html.beginnerProgram
        { model = ()
        , update = \() () -> ()
        , view = view
        }
