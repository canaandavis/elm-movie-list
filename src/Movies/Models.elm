module Movies.Models exposing (..)


type alias ImdbId =
    String


type alias Movie =
    { id : Maybe Int
    , title : String
    , year : String
    , imdbID : ImdbId
    , poster : String
    }


type alias Movies =
    { allMovies : List Movie
    , eagerAdding : Maybe ImdbId
    , eagerDeleting : Maybe Movie
    }


new : Movies
new =
    { allMovies = []
    , eagerAdding = Nothing
    , eagerDeleting = Nothing
    }
