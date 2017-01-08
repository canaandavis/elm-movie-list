module Models exposing (..)

import SearchResults.Models exposing (SearchResults, new)


type alias Model =
    { searchResults : SearchResults
    , alertMessage : String
    }


initialModel : Model
initialModel =
    { searchResults = new
    , alertMessage = ""
    }
