module Models exposing (..)

import Routes.Routes exposing (Route)

type alias Error =
  { id: String
  , message: String
  }

-- APP STATE
type alias State =
  { route : Route
  , fetching : Bool
  , error : Maybe Error
  , posts : Maybe (List Post)
  , current : Maybe Post 
  }

-- SINGLE POST
type alias Post =
  { id : Int
  , author : String
  , title : String
  , body : String
  }

-- INIT STATE
newState : Route -> Maybe Post -> State
newState route post =
  { route = route
  , fetching = False
  , posts = Nothing
  , error = Nothing
  , current = post
  }
