module SearchResults.Update exposing (..)

import SearchResults.Messages exposing (Msg(..))
import SearchResults.Commands exposing (search)
import SearchResults.Models exposing (SearchResults)


update : Msg -> SearchResults -> ( SearchResults, Cmd Msg )
update msg searchResults =
    case msg of
        UpdateFormInput text ->
            if String.length (String.trim text) == 0 then
                ( { searchResults | formValue = text, results = [] }, Cmd.none )
            else
                ( { searchResults | formValue = text }, Cmd.none )

        SubmitForm ->
            if String.isEmpty (String.trim searchResults.formValue) then
                ( searchResults, Cmd.none )
            else
                ( { searchResults | isSearching = True, results = [] }, (search searchResults.formValue) )

        NewSearchResults (Ok results) ->
            ( { searchResults | results = results, isSearching = False }, Cmd.none )

        NewSearchResults (Err error) ->
            ( { searchResults | isSearching = False }, Cmd.none )

        _ ->
            ( searchResults, Cmd.none )
