module Update exposing (..)

import SearchResults.Update exposing (..)
import Models exposing (Model)
import Messages exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SearchResultsMsg subMsg ->
            let
                ( updatedSearchResults, cmd ) =
                    SearchResults.Update.update subMsg model.searchResults
            in
                ( { model | searchResults = updatedSearchResults }, Cmd.map SearchResultsMsg cmd )
