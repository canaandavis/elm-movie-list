module SearchResults.List exposing (..)

import SearchResults.Messages exposing (Msg(..))
import SearchResults.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


view : SearchResults -> Html Msg
view searchResults =
    let
        showContainer =
            (List.length searchResults.results > 0 || searchResults.isSearching)
    in
        div [ class "search-widget" ]
            [ viewSearchForm
            , div
                [ classList
                    [ ( "search-results-container", True )
                    , ( "expanded", showContainer )
                    ]
                ]
                [ viewSearchResults searchResults.results
                , viewSearching searchResults.isSearching
                ]
            ]


viewSearchForm : Html Msg
viewSearchForm =
    Html.form [ class "form", submitWithOptions SubmitForm ]
        [ input [ type_ "text", onInput UpdateFormInput, placeholder "Search By Title" ] []
        , input [ type_ "submit", value "submit" ] []
        ]


submitWithOptions : Msg -> Attribute Msg
submitWithOptions msg =
    let
        config =
            { stopPropagation = False
            , preventDefault = True
            }
    in
        onWithOptions "submit" config (Json.succeed msg)


viewSearchResults : List SearchResult -> Html Msg
viewSearchResults searchResults =
    ul [] (List.map viewSearchResult searchResults)


viewSearchResult : SearchResult -> Html Msg
viewSearchResult searchResult =
    let
        poster =
            if searchResult.poster == "N/A" then
                "./static/default.jpg"
            else
                searchResult.poster
    in
        li [ class "search-item" ]
            [ div [ class "poster", style [ ( "backgroundImage", "url(" ++ poster ++ ")" ) ] ] []
            , h3 [] [ text searchResult.title ]
            ]


viewSearching : IsSearching -> Html Msg
viewSearching isSearching =
    if isSearching then
        h2 [] [ text "Searching. . ." ]
    else
        text ""
