module Models exposing (..)

import TypeAliases exposing (TodoId, TodoItem)

type alias Model = 
    { todos : List TodoItem
    , uid : Int
    }


