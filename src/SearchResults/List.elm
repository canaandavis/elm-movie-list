module SearchResults.List exposing (..)

import SearchResults.Messages exposing (Msg(..))
import SearchResults.Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : SearchResults -> Html Msg
view searchResults =
    div [ class "search-widget" ]
        [ viewSearchForm
        , viewSearchResults searchResults.results
        , viewSearching searchResults.isSearching
        ]


viewSearchForm : Html Msg
viewSearchForm =
    Html.form [ class "form", onSubmit SubmitForm ]
        [ input [ type_ "text", onInput UpdateFormInput, placeholder "Search By Title" ] []
        , input [ type_ "submit", value "submit" ] []
        ]


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
        li []
            [ h3 [] [ text searchResult.title ]
            , img [ src poster, alt "movie poster" ] []
            ]


viewSearching : IsSearching -> Html Msg
viewSearching isSearching =
    if isSearching then
        h2 [] [ text "Searching. . ." ]
    else
        text ""
