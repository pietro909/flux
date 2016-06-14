port module Ports exposing (..)

import TypeAliases exposing (TodoId, TodoItem)
import Actions exposing (..)
import Models exposing (Model)

-- incoming messages
port dispatchCreate : (String -> msg) -> Sub msg
port dispatchComplete : (TodoId -> msg) -> Sub msg
port dispatchDestroy : (TodoId -> msg) -> Sub msg
port dispatchDestroyCompleted : ({} -> msg) -> Sub msg
port dispatchToggleCompleteAll : ({} -> msg) -> Sub msg
port dispatchUndoComplete : (TodoId -> msg) -> Sub msg
port dispatchUpdateText : ((TodoId, String) -> msg) -> Sub msg

-- outgoing messages
port todoListChanges : (List TodoItem) -> Cmd msg


{-- SUBSCRIPTIONS
 -  need to collect all the inbound ports in one subscription flow
--}
subscriptions : Model -> Sub Action
subscriptions model =
    Sub.batch
        [ dispatchCreate Create
        , dispatchComplete Complete
        , dispatchDestroy Destroy
        , dispatchDestroyCompleted (always DestroyCompleted)
        , dispatchToggleCompleteAll (always ToggleCompleteAll)
        , dispatchUndoComplete UndoComplete
        , dispatchUpdateText (uncurry UpdateText)
        ]
