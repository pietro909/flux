module TodoStore exposing (..)

import Ports exposing (subscriptions, todoListChanges)
import Json.Decode
import TypeAliases exposing (TodoId, TodoItem)
import Actions exposing (..)
import Models exposing (..)
import Debug
import String


-- MODEL
init : Model
init = 
    { todos = []
    , uid = 0
    }


-- UPDATE
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

        UndoComplete id ->
            let
                newModel =
                    { model
                        | todos = applyToItem (\x -> { x | complete = False }) id model.todos
                    }
            in
                (newModel, todoListChanges newModel.todos)

        ToggleCompleteAll ->
            let
                areAllComplete = List.foldr (\a -> (\b -> a.complete && b)) True model.todos
                newModel =
                    if areAllComplete then
                        { model
                            | todos = List.map (\a -> { a | complete = False }) model.todos
                        }
                    else
                        { model
                            | todos = List.map (\a -> { a | complete = True }) model.todos
                        }
            in
                (newModel, todoListChanges newModel.todos)

applyToItem : (TodoItem -> TodoItem) -> TodoId -> List TodoItem -> List TodoItem
applyToItem f id list =
    List.map (\t -> if t.id == id then (f t) else t) list
