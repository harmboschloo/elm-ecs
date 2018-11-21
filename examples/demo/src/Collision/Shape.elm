module Collision.Shape exposing
    ( Shape, Position
    , point, circle
    , bounds
    )

{-|

@docs Shape, Position
@docs point, circle
@docs bounds

-}

import Collision.Bounds exposing (Bounds)


type Shape
    = Point
    | Circle Float



-- | Composite List (Position, Shape)


type alias Position =
    { x : Float
    , y : Float
    , angle : Float
    }


point : Shape
point =
    Point


circle : Float -> Shape
circle radius =
    Circle radius


bounds : Position -> Shape -> Bounds
bounds position shape =
    case shape of
        Point ->
            { left = position.x
            , top = position.y
            , bottom = position.y
            , right = position.x
            }

        Circle radius ->
            { left = position.x - radius
            , top = position.y - radius
            , bottom = position.y + radius
            , right = position.x + radius
            }
