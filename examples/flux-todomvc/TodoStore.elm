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

        DestroyCompleted ->
            let
                notCompleted = List.filter (\todo -> todo.complete == False) model.todos
                newModel =
                    { model
                        | todos = notCompleted
                    }
            in
                (newModel, todoListChanges newModel.todos)

        UpdateText id untrimmedText ->
            let
                text = String.trim untrimmedText
                newModel = 
                    if String.isEmpty text then 
                       model
                    else
                        { model
                        | todos = applyToItem (\x -> { x | text = text }) id model.todos
                        }
            in
                (newModel, todoListChanges newModel.todos)

        Complete id ->
            let
                newModel =
                    { model
                        | todos = applyToItem (\x -> { x | complete = True }) id model.todos
                    }
            in
                (newModel, todoListChanges newModel.todos)

        _ ->
            let 
                msg = Debug.log "action: " action
            in
                (model, Cmd.none)

applyToItem : (TodoItem -> TodoItem) -> TodoId -> List TodoItem -> List TodoItem
applyToItem f id list =
    List.map (\t -> if t.id == id then (f t) else t) list
