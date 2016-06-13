module TodoStore exposing (..)

import Ports exposing (subscriptions, todoListChanges)
import Json.Decode
import TypeAliases exposing (TodoId)
import Actions exposing (..)
import Models exposing (..)
import Debug
import String

-- here it starts!

-- MODEL
init : Model
init = 
    { todos = []
    , uid = 0
    }

update : Action -> Model -> (Model, Cmd Action)
update action model =
    case action of
        Create untrimmedText ->
            let
                text = String.trim untrimmedText
                newModel = if String.isEmpty text then
                                model
                           else
                                { model
                                    | todos = model.todos ++ [ TodoItem model.uid False text ]
                                    , uid = model.uid + 1
                                }
            in
               (newModel, todoListChanges newModel.todos)

        Destroy id ->
            let
                todosWithoutId = List.filter (\todo -> todo.id /= id) model.todos
                newModel = 
                    { model
                        | todos = todosWithoutId
                    }
            in
                (newModel, todoListChanges newModel.todos)                 

        _ ->
            let 
                msg = Debug.log "action: " action
            in
                (model, Cmd.none)
