module TodoStore exposing (..)

import Ports 
import Json.Decode
import TypeAliases exposing (TodoId)

{--
(
        dispatchCreate, 
        dispatchComplete,
        dispatchDestroy, 
        dispatchDestroyCompleted,
        dispatchToggleCompleteAll,
        dispatchUndocomplete,
        dispatchUpdateText 
        )
--}

-- here it starts!

-- MODEL
type alias TodoItem =
    { id : TodoId
    , complete : Bool
    , text : String
    }

type alias Model = 
    { todos : List String
    , uid : Int
    }

{-- port constants from TodoConstants.js to Elm Actions --}
type Action
    = Create String
    | Complete TodoId
    | Destroy TodoId
    | DestroyCompleted
    | ToggleCompleteAll
    | UndoComplete TodoId
    | UpdateText TodoId String


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Action
subscriptions model =
    Sub.batch
        [ Ports.dispatchCreate Create
        , Ports.dispatchComplete Complete
        , Ports.dispatchDestroy Destroy
        , Ports.dispatchDestroyCompleted (always DestroyCompleted)
        , Ports.dispatchToggleCompleteAll (always ToggleCompleteAll)
        , Ports.dispatchUndoComplete UndoComplete
        , Ports.dispatchUpdateText (uncurry UpdateText)
        ]
