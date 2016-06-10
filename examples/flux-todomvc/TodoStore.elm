module TodoStore exposing (..)

import Ports
import Json.Decode
import TypeAliases exposing (TodoId)

-- here it starts!

-- MODEL

-- UPDATE

{-- port constants from TodoConstants.js to Elm Actions --}
type Action
    = Create String
    | Complete TodoId
    | Destroy TodoId
    | DestroyCompleted
    | ToggleCompleteAll
    | UndoComplete TodoId
    | UpdateText TodoId String
