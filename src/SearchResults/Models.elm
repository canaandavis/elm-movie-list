module SearchResults.Models exposing (..)


type alias SearchResult =
    { title : String
    , year : String
    , imdbID : String
    , poster : String
    }


type alias IsSearching =
    Bool


type alias SearchFormValue =
    String


type alias SearchResults =
    { results : List SearchResult
    , formValue : SearchFormValue
    , isSearching : IsSearching
    }


new : SearchResults
new =
    { results = []
    , formValue = ""
    , isSearching = False
    }
