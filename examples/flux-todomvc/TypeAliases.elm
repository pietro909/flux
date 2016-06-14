module TypeAliases exposing (..)

type alias TodoId = Int

type alias TodoItem =
    { id : TodoId
    , complete : Bool
    , text : String
    }
