module Messages exposing (..)

import Http
import Movies.Models exposing (Movie)
import SearchResults.Models exposing (SearchResult, IsSearching, SearchFormValue)


-- import SearchResults.Messages


type Msg
    = SEARCH_RESULTS_UpdateFormInput SearchFormValue
    | SEARCH_RESULTS_SubmitForm
    | SEARCH_RESULTS_NewSearchResults (Result Http.Error (List SearchResult))
    | MOVIES_AddMovie Movie
    | MOVIES_RemoveMovie Movie
    | MOVIES_FetchCurrentMovies
    | MOVIES_CurrentMoviesFetched (Result Http.Error (List Movie))
    | MOVIES_SaveComplete (Result Http.Error Movie)
    | MOVIES_DeleteComplete (Result Http.Error Movie)
