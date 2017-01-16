module Update exposing (..)

import SearchResults.Update
import Movies.Update
import Models exposing (Model)
import Messages exposing (Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ( updatedSearchResults, searchResultsCmd ) =
            SearchResults.Update.update msg model.searchResults

        ( updatedMovies, moviesCmd ) =
            Movies.Update.update msg model.movies
    in
        ( { model
            | searchResults = updatedSearchResults
            , movies = updatedMovies
          }
        , Cmd.batch [ searchResultsCmd, moviesCmd ]
        )
