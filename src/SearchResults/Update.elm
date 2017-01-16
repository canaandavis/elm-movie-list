module SearchResults.Update exposing (..)

import Messages exposing (Msg(..))
import SearchResults.Commands exposing (search)
import SearchResults.Models exposing (SearchResults)


update : Msg -> SearchResults -> ( SearchResults, Cmd Msg )
update msg searchResults =
    case msg of
        SEARCH_RESULTS_UpdateFormInput text ->
            if String.length (String.trim text) == 0 then
                ( { searchResults | formValue = text, results = [] }, Cmd.none )
            else
                ( { searchResults | formValue = text }, Cmd.none )

        SEARCH_RESULTS_SubmitForm ->
            if String.isEmpty (String.trim searchResults.formValue) then
                ( searchResults, Cmd.none )
            else
                ( { searchResults | isSearching = True, results = [] }, (search searchResults.formValue) )

        SEARCH_RESULTS_NewSearchResults (Ok results) ->
            ( { searchResults | results = results, isSearching = False }, Cmd.none )

        SEARCH_RESULTS_NewSearchResults (Err error) ->
            ( { searchResults | isSearching = False }, Cmd.none )

        MOVIES_AddMovie _ ->
            ( { searchResults | formValue = "", results = [] }, Cmd.none )

        _ ->
            ( searchResults, Cmd.none )



-- _ ->
-- ( searchResults, Cmd.none )
