module Movies.List exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Movies.Models exposing (..)
import Messages exposing (Msg(..))


view : Movies -> Html Msg
view movies =
    div [ class "movie-list" ] (viewMovieList movies.allMovies)


viewMovieList : List Movie -> List (Html Msg)
viewMovieList movies =
    List.map viewMovieItem movies


viewMovieItem : Movie -> Html Msg
viewMovieItem movie =
    div [ class "movie" ]
        [ div [ class "poster", style [ ( "backgroundImage", "url(" ++ movie.poster ++ ")" ) ] ] []
        , div [ class "title" ] [ text movie.title ]
        , viewDeleteButton movie
        ]


viewDeleteButton : Movie -> Html Msg
viewDeleteButton movie =
    case movie.id of
        Nothing ->
            div [] []

        Just id ->
            button
                [ class "Delete Movie", onClick (MOVIES_RemoveMovie movie) ]
                [ text "Delete Movie" ]
