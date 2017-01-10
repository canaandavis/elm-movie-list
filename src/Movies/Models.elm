module Movies.Models exposing (..)


type alias ImdbId =
    String


type alias Movie =
    { title : String
    , year : String
    , imdbID : ImdbId
    , poster : String
    }


type alias Movies =
    { allMovies : List Movie
    }


new : Movies
new =
    { allMovies = []
    }
