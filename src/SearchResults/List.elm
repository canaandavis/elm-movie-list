module SearchResults.List exposing (..)

import Movies.Models exposing (Movie)
import Messages exposing (Msg(..))
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
            [ viewSearchForm searchResults.formValue
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


viewSearchForm : SearchFormValue -> Html Msg
viewSearchForm formValue =
    Html.form [ class "form", submitWithOptions SEARCH_RESULTS_SubmitForm ]
        [ input
            [ type_ "text"
            , onInput SEARCH_RESULTS_UpdateFormInput
            , placeholder "Search By Title"
            , value formValue
            ]
            []
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
        li
            [ class "search-item"
            ]
            [ div [ class "poster", style [ ( "backgroundImage", "url(" ++ poster ++ ")" ) ] ] []
            , h3 [] [ text searchResult.title ]
            , button
                [ class "add-movie-button"
                , onClick
                    (MOVIES_AddMovie
                        (Movie Nothing searchResult.title searchResult.year searchResult.imdbID searchResult.poster)
                    )
                ]
                [ text "+ Add Movie" ]
            ]


viewSearching : IsSearching -> Html Msg
viewSearching isSearching =
    if isSearching then
        h2 [] [ text "Searching. . ." ]
    else
        text ""
