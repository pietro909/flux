import Html.App as Html
import Html exposing (..)
-- import Html.Attributes exposing (..)
-- import Html.Events exposing (..)
import TodoStore 
import Ports
import Models exposing (Model)
import Actions exposing (Action)

-- UPDATE
update : Action -> Model -> (Model, Cmd Action)
update msg model =
    (model, Cmd.none)


{--
    let
        model = TodoStore.update msg model
    in
       (model, Cmd.none)
--}

init = TodoStore.init

subscriptions = Ports.subscriptions

main : Program Never
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


view : Model -> Html Action
view model = 
    div[][]
