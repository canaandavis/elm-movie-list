module Messages exposing (..)

import Http
import Movies.Models exposing (Movie, ImdbId)
import SearchResults.Models exposing (SearchResult, IsSearching, SearchFormValue)


-- import SearchResults.Messages


type Msg
    = SEARCH_RESULTS_UpdateFormInput SearchFormValue
    | SEARCH_RESULTS_SubmitForm
    | SEARCH_RESULTS_NewSearchResults (Result Http.Error (List SearchResult))
    | MOVIES_AddMovie Movie
    | MOVIES_RemoveMovie ImdbId
    | MOVIES_FetchCurrentMovies
    | MOVIES_CurrentMoviesFetched (Result Http.Error (List Movie))
    | MOVIES_SaveComplete (Result Http.Error Movie)
