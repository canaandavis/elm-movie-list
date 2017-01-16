module Movies.Update exposing (..)

import Movies.Models exposing (..)
import Messages exposing (Msg(..))
import Movies.Commands as MovieCommands


update : Msg -> Movies -> ( Movies, Cmd Msg )
update msg movies =
    case msg of
        MOVIES_AddMovie movie ->
            ( { movies
                | allMovies = movies.allMovies ++ [ movie ]
                , eagerAdding = Just movie.imdbID
              }
            , (MovieCommands.saveMovie movie)
            )

        MOVIES_RemoveMovie movie ->
            let
                updatedMovies =
                    movies.allMovies
                        |> List.filter (\m -> m.id /= movie.id)
            in
                ( { movies | allMovies = updatedMovies, eagerDeleting = Just movie }, (MovieCommands.deleteMovie movie) )

        MOVIES_CurrentMoviesFetched (Ok results) ->
            ( { movies | allMovies = results }, Cmd.none )

        MOVIES_CurrentMoviesFetched (Err error) ->
            ( movies, Cmd.none )

        MOVIES_SaveComplete (Ok movie) ->
            let
                updatedMovies =
                    movies.allMovies
                        |> List.map
                            (\m ->
                                if m.imdbID == movie.imdbID then
                                    movie
                                else
                                    m
                            )
            in
                ( { movies | allMovies = updatedMovies, eagerAdding = Nothing }, Cmd.none )

        MOVIES_SaveComplete (Err error) ->
            let
                updatedMovies =
                    case movies.eagerAdding of
                        Nothing ->
                            movies.allMovies

                        Just eagerAdding ->
                            movies.allMovies
                                |> List.filter (\movie -> movie.imdbID /= eagerAdding)
            in
                ( { movies | allMovies = updatedMovies, eagerAdding = Nothing }, Cmd.none )

        MOVIES_DeleteComplete (Ok movie) ->
            ( { movies | eagerDeleting = Nothing }, Cmd.none )

        MOVIES_DeleteComplete (Err error) ->
            let
                updatedMovies =
                    case movies.eagerDeleting of
                        Nothing ->
                            movies.allMovies

                        Just eagerDeleting ->
                            movies.allMovies ++ [ eagerDeleting ]
            in
                ( { movies | allMovies = updatedMovies, eagerDeleting = Nothing }, Cmd.none )

        _ ->
            ( movies, Cmd.none )
