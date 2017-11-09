module InlineSvg exposing (Helpers, inline)

{-| This library allows you to inline external SVG file into Elm views.

@docs inline, Helpers

-}

import Html exposing (Html, text)
import Svg exposing (Attribute, svg)
import SvgParser exposing (SvgNode(..), parseToNode, toAttribute, nodeToSvg)


{-| This is the record returned from `inline` function. `icon` function is used to access individual SVG document, you can also pass a list of attributes to the SVG.

    icon .share [Svg.Attributes.fill "blue"] : Html msg

-}
type alias Helpers icons msg =
    { icon : (icons -> String) -> List (Attribute msg) -> Html msg
    }


type SvgIcons icons
    = SvgIcons icons


{-| This function returns a record, which contains a `icon` function to reference individual SVG document.

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

-}
inline : icons -> Helpers icons msg
inline icons =
    let
        svgIcons =
            SvgIcons icons
    in
        { icon = icon svgIcons
        }


icon : SvgIcons icons -> (icons -> String) -> List (Attribute msg) -> Html msg
icon (SvgIcons icons) accessor attrs =
    case parseToNode (accessor icons) of
        Ok (SvgElement element) ->
            svg ((List.map toAttribute element.attributes) ++ attrs)
                (List.map nodeToSvg element.children)

        _ ->
            text ""
