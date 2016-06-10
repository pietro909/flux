module TodoStore exposing (..)

import Ports 
import Json.Decode
import TypeAliases exposing (TodoId)
import Actions exposing (..)
import Models exposing (..)
import Debug

-- here it starts!

-- MODEL
init : Model
init = 
    { todos = []
    , uid = 0
    }

update : Action -> Model -> Model
update action model =
    let
        theMsg = Debug.log "action: " action
    in
        model
