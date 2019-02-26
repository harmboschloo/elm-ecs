module Core.Collision.Shape exposing
    ( Shape
    , point, circle
    , bounds
    , intersect
    )

{-|

@docs Shape
@docs point, circle
@docs bounds
@docs intersect

-}

import Core.Collision.Bounds exposing (Bounds)
import Core.Collision.Position exposing (Position)


type Shape
    = Point
    | Circle Float



-- | Composite List (Position, Shape)


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


intersect : Position -> Shape -> Position -> Shape -> Bool
intersect positionA shapeA positionB shapeB =
    case ( shapeA, shapeB ) of
        ( Point, Point ) ->
            positionA.x == positionB.x && positionA.y == positionB.y

        ( Point, Circle radius ) ->
            insersectPointCirlce positionA positionB radius

        ( Circle radius, Point ) ->
            insersectPointCirlce positionB positionA radius

        ( Circle radiusA, Circle radiusB ) ->
            insersectCircleCirlce positionA radiusA positionB radiusB


insersectPointCirlce : Position -> Position -> Float -> Bool
insersectPointCirlce pointPosition centerPosition radius =
    let
        deltaX =
            pointPosition.x - centerPosition.x

        deltaY =
            pointPosition.y - centerPosition.y

        distanceSquared =
            deltaX * deltaX + deltaY * deltaY

        radiusSquared =
            radius * radius
    in
    distanceSquared < radiusSquared


insersectCircleCirlce : Position -> Float -> Position -> Float -> Bool
insersectCircleCirlce positionA radiusA positionB radiusB =
    insersectPointCirlce positionA positionB (radiusA + radiusB)
