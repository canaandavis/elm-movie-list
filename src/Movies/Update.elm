module Movies.Update exposing (..)

import Movies.Models exposing (..)
import Movies.Mesages exposing (Msg(..))


update : Msg -> Movies -> ( Movies, Cmd Msg )
update msg movies =
    case msg of
        AddMovie movie ->
            ( { movies | allMovies = allMovies ++ [ movie ] }, Cmd.none )

        RemoveMovie imdbdId ->
            let
                movies =
                    movies.allMovies
                        |> List.filter (\movie -> movie.imdbID /= imdbId)
            in
                ( { movies | allMovies = movies }, Cmd.none )
