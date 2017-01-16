module Movies.Commands exposing (getCurrentMovies, saveMovie, deleteMovie)

import Json.Encode as Encode
import Json.Decode as Decode exposing (field)
import Movies.Models exposing (Movie)
import Messages exposing (Msg(..))
import Http


movieDecoder : Decode.Decoder Movie
movieDecoder =
    Decode.map5 Movie
        (Decode.maybe (field "id" Decode.int))
        (field "title" Decode.string)
        (field "year" Decode.string)
        (field "imdbID" Decode.string)
        (field "poster" Decode.string)


movieEncoder : Movie -> Encode.Value
movieEncoder movie =
    Encode.object
        [ ( "title", Encode.string movie.title )
        , ( "year", Encode.string movie.year )
        , ( "imdbID", Encode.string movie.imdbID )
        , ( "poster", Encode.string movie.poster )
        ]


movieUrl : String
movieUrl =
    "http://localhost:3000/movies"


getCurrentMovies : Cmd Msg
getCurrentMovies =
    Decode.list movieDecoder
        |> Http.get movieUrl
        |> Http.send MOVIES_CurrentMoviesFetched


saveNewMovieRequest : Movie -> Http.Request Movie
saveNewMovieRequest movie =
    Http.request
        { body = movieEncoder movie |> Http.jsonBody
        , expect = Http.expectJson movieDecoder
        , headers = []
        , method = "POST"
        , timeout = Nothing
        , url = movieUrl
        , withCredentials = False
        }


saveMovie : Movie -> Cmd Msg
saveMovie movie =
    saveNewMovieRequest movie
        |> Http.send MOVIES_SaveComplete


deleteUrl : Movie -> String
deleteUrl movie =
    case movie.id of
        Nothing ->
            movieUrl

        Just id ->
            movieUrl ++ "/" ++ (toString id)


deleteMovieRequest : Movie -> Http.Request Movie
deleteMovieRequest movie =
    Http.request
        { body = movieEncoder movie |> Http.jsonBody
        , expect = Http.expectJson (Decode.succeed movie)
        , headers = []
        , method = "DELETE"
        , timeout = Nothing
        , url = deleteUrl movie
        , withCredentials = False
        }


deleteMovie : Movie -> Cmd Msg
deleteMovie movie =
    deleteMovieRequest movie
        |> Http.send MOVIES_DeleteComplete
