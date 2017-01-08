module SearchResults.Messages exposing (..)

import Http
import SearchResults.Models exposing (SearchResult, IsSearching, SearchFormValue)


type Msg
    = UpdateFormInput SearchFormValue
    | SubmitForm
    | NewSearchResults (Result Http.Error (List SearchResult))
