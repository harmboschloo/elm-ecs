module Data.Bounds exposing
    ( Bounds
    , fromPoint
    , fromPositionAndRadius
    , intersect
    )


type alias Bounds =
    { left : Float
    , right : Float
    , top : Float
    , bottom : Float
    }


fromPoint : Float -> Float -> Bounds
fromPoint x y =
    fromPositionAndRadius x y 0


fromPositionAndRadius : Float -> Float -> Float -> Bounds
fromPositionAndRadius x y radius =
    { left = x - radius
    , right = x + radius
    , top = y - radius
    , bottom = y + radius
    }


intersect : Bounds -> Bounds -> Bool
intersect a b =
    intersectAxis a.left a.right b.left b.right
        && intersectAxis a.top a.bottom b.top b.bottom


intersectAxis : Float -> Float -> Float -> Float -> Bool
intersectAxis a0 a1 b0 b1 =
    a0 < b1 && a1 > b0
