module Collision.Bounds exposing
    ( Bounds
    , intersect
    )


type alias Bounds =
    { left : Float
    , top : Float
    , right : Float
    , bottom : Float
    }


intersect : Bounds -> Bounds -> Bool
intersect a b =
    intersectAxis a.left a.right b.left b.right
        && intersectAxis a.top a.bottom b.top b.bottom


intersectAxis : Float -> Float -> Float -> Float -> Bool
intersectAxis a0 a1 b0 b1 =
    a0 < b1 && a1 > b0
