module World.DelayedOperations exposing
    ( DelayedOperations
    , Operation(..)
    , add
    )

import Core.Collidable exposing (Collidable)


type alias DelayedOperations =
    List ( Float, Operation )


type Operation
    = RemoveEntity
    | InsertCollidable Collidable


add : Float -> Operation -> Maybe DelayedOperations -> Maybe DelayedOperations
add time operation maybeOperations =
    ( time, operation )
        :: Maybe.withDefault [] maybeOperations
        |> Just
