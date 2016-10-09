module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation
import String
import UrlParser exposing (Parser, (</>), format, int, oneOf, s, string)
import Routes.Routes exposing(..)

-- Component import
import Components.Header as MainHeader


init : Route -> (Route, Cmd Msg)
init route =
  case route of
    _ ->
      ( route, Cmd.none )


-- APP
main : Program Never
main =
  Navigation.program urlParser
    { init = init
    , view = view
    , update = update
    , urlUpdate = urlUpdate
    , subscriptions = subscriptions
    }


-- UPDATE

type Msg = String

update : Msg -> Route -> (Route, Cmd Msg)
update msg route =
  let newRoute = route
  in
    (newRoute, Cmd.none)

-- URL PARSERS

urlUpdate : Route -> Route -> (Route, Cmd Msg)
urlUpdate route msg =
  case route of
    _ ->
      (msg, Cmd.none)

urlParser : Navigation.Parser Route
urlParser =
  Navigation.makeParser parse

parse : Navigation.Location -> Route
parse {pathname} =
  let
    path =
      if String.startsWith "/" pathname then
        String.dropLeft 1 pathname
      else
        pathname

    result =
      UrlParser.parse identity routeParser path

  in
    case result of
      Err err -> NotFound

      Ok route -> route

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ format HomeRoute homeParser
    ]


homeParser : Parser a a
homeParser =
  oneOf
    [ (UrlParser.s "index.html")
    , (UrlParser.s "")
    ]

-- SUBSCRIPTIONS

subscriptions : Route -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Route -> Html a
view route =
  div [ class "container" ] [
    div [] [ MainHeader.component ]
  ]
