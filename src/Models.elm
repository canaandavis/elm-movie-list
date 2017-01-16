module Models exposing (..)

import SearchResults.Models as SearchResults exposing (SearchResults)
import Movies.Models as Movies exposing (Movies)


type alias Model =
    { searchResults : SearchResults
    , movies : Movies
    }


initialModel : Model
initialModel =
    { searchResults = SearchResults.new
    , movies = Movies.new
    }
