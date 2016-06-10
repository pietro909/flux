port module Ports exposing (..)

import TypeAliases exposing (TodoId)

-- incoming messages
port dispatchCreate : (String -> msg) -> Sub msg
port dispatchComplete : (TodoId -> msg) -> Sub msg
port dispatchDestroy : (TodoId -> msg) -> Sub msg
port dispatchDestroyCompleted : ({} -> msg) -> Sub msg
port dispatchToggleCompleteAll : ({} -> msg) -> Sub msg
port dispatchUndoComplete : (TodoId -> msg) -> Sub msg
port dispatchUpdateText : ((TodoId, String) -> msg) -> Sub msg
