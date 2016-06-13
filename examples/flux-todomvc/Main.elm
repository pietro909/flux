import Html.App as Html
import Html exposing (..)
import Ports
import Models exposing (Model)
import Actions exposing (Action)
import TypeAliases exposing (TodoId)
import Ports 
import Json.Decode
import Debug
import TodoStore

main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


-- MODEL

init : (Model, Cmd Action)
init = 
    let
        model = { todos = []
                , uid = 0
                }
    in
       (model, Cmd.none)


-- UPDATE
update : Action -> Model -> (Model, Cmd Action)
update = TodoStore.update

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Action
subscriptions = Ports.subscriptions

view : Model -> Html Action
view model = 
    div[][]
