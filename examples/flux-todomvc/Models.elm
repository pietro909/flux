module Models exposing (..)

import TypeAliases exposing (TodoId)

type alias TodoItem =
    { id : TodoId
    , complete : Bool
    , text : String
    }

type alias Model = 
    { todos : List TodoItem
    , uid : Int
    }


