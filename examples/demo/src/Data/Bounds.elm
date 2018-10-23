module Data.Bounds exposing (Bounds, fromPositionAndRadius)


type alias Bounds =
    { left : Float
    , right : Float
    , top : Float
    , bottom : Float
    }


fromPositionAndRadius : Float -> Float -> Float -> Bounds
fromPositionAndRadius x y radius =
    { left = x - radius
    , right = x + radius
    , top = y - radius
    , bottom = y + radius
    }
