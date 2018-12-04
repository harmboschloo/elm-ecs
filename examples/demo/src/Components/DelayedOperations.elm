module Components.DelayedOperations exposing
    ( DelayedOperations
    , Operation(..)
    , add
    )

import Components.CollisionShape exposing (CollisionShape)


type alias DelayedOperations =
    List ( Float, Operation )


type Operation
    = RemoveEntity
    | InsertCollisionShape CollisionShape


add : Float -> Operation -> Maybe DelayedOperations -> Maybe DelayedOperations
add time operation maybeOperations =
    ( time, operation )
        :: Maybe.withDefault [] maybeOperations
        |> Just
