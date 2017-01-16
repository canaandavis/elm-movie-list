module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onSubmit, onInput)
import Json.Decode as Decode exposing (Decoder)
import Http
import Models exposing (Model, initialModel)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)
import Movies.Commands as MovieCommands


init : ( Model, Cmd Msg )
init =
    ( initialModel, MovieCommands.getCurrentMovies )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
