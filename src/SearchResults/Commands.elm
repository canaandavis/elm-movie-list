module SearchResults.Commands exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import SearchResults.Models exposing (SearchResult, SearchFormValue)
import SearchResults.Messages exposing (..)
import Http


searchResultDecoder : Decode.Decoder SearchResult
searchResultDecoder =
    Decode.map5 SearchResult
        (field "Title" Decode.string)
        (field "Year" Decode.string)
        (field "imdbID" Decode.string)
        (field "Poster" Decode.string)


baseSearchUrl : String
baseSearchUrl =
    "http://www.omdbapi.com/?r=json&s="


search : SearchFormValue -> Cmd Msg
search searchFormValue =
    Decode.list searchResultDecoder
        |> Decode.at [ "Search" ]
        |> Http.get (baseSearchUrl ++ searchFormValue)
        |> Http.send NewSearchResults
