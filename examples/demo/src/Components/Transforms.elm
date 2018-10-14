module Components.Transforms exposing
    ( Transform
    , TransformType(..)
    , Transforms
    , add
    )

import Components


type alias Transforms =
    List Transform


type alias Transform =
    { time : Float, type_ : TransformType }


type TransformType
    = DestroyEntity
    | InsertCollectable Components.Collectable


add : Float -> TransformType -> Maybe Transforms -> Maybe Transforms
add time type_ maybeTransforms =
    Transform time type_
        :: Maybe.withDefault [] maybeTransforms
        |> Just
