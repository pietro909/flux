module Actions exposing (..)

import TypeAliases exposing (TodoId)

{-- port constants from TodoConstants.js to Elm Actions --}
type Action
    = Create String
    | Complete TodoId
    | Destroy TodoId
    | DestroyCompleted
    | ToggleCompleteAll
    | UndoComplete TodoId
    | UpdateText TodoId String

