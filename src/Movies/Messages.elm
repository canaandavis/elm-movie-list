module Movies.Messages exposing (..)

import Movies.Models exposing (..)


type Msg
    = AddMovie Movie
    | RemoveMovie ImdbId
