module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import SearchResults.List
import Movies.List
import Messages exposing (..)
import Models exposing (..)


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ h1 [] [ text "MOVIES OR WHATEVER" ]
        , SearchResults.List.view model.searchResults
        , Movies.List.view model.movies
        ]
