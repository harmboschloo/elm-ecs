module Data.CollisionGrid exposing
    ( CollisionGrid
    , Config
    , cellCollisionsBetween
    , empty
    , insert
    , insertAtPoint
    )

import Data.Bounds exposing (Bounds)
import Dict exposing (Dict)


type CollisionGrid a
    = CollisionGrid (Model a)


type alias Model a =
    { cellWidth : Float
    , cellHeight : Float
    , cells : Cells a
    , idCount : Int
    }


type alias Cells a =
    Dict ( Int, Int ) (List ( Id, a ))


type alias Id =
    Int


type alias Config =
    { cellWidth : Float
    , cellHeight : Float
    }


empty : Config -> CollisionGrid a
empty { cellWidth, cellHeight } =
    CollisionGrid
        { cellWidth = cellWidth
        , cellHeight = cellHeight
        , cells = Dict.empty
        , idCount = 0
        }


insert : Bounds -> a -> CollisionGrid a -> CollisionGrid a
insert bounds a (CollisionGrid model) =
    let
        xRange =
            List.range
                (toCellIndex bounds.left model.cellWidth)
                (toCellIndex bounds.right model.cellWidth)

        yRange =
            List.range
                (toCellIndex bounds.top model.cellHeight)
                (toCellIndex bounds.bottom model.cellHeight)

        data =
            ( model.idCount, a )

        newCells =
            foldAxB
                (\x y -> insertAt ( x, y ) data)
                model.cells
                xRange
                yRange
    in
    CollisionGrid
        { model
            | cells = newCells
            , idCount = model.idCount + 1
        }


insertAtPoint : ( Float, Float ) -> a -> CollisionGrid a -> CollisionGrid a
insertAtPoint ( x, y ) a (CollisionGrid model) =
    CollisionGrid
        { model
            | cells =
                insertAt
                    ( toCellIndex x model.cellWidth
                    , toCellIndex y model.cellHeight
                    )
                    ( model.idCount, a )
                    model.cells
            , idCount = model.idCount + 1
        }


insertAt : ( Int, Int ) -> ( Id, a ) -> Cells a -> Cells a
insertAt key data cells =
    Dict.update key (Maybe.withDefault [] >> (::) data >> Just) cells


toCellIndex : Float -> Float -> Int
toCellIndex a cellSize =
    floor (a / cellSize)


foldAxB : (a -> b -> c -> c) -> c -> List a -> List b -> c
foldAxB process initial aList bList =
    List.foldl
        (\a c1 ->
            List.foldl (\b c2 -> process a b c2) c1 bList
        )
        initial
        aList


cellCollisionsBetween : CollisionGrid a -> CollisionGrid b -> List ( a, b )
cellCollisionsBetween (CollisionGrid modelA) (CollisionGrid modelB) =
    Dict.foldl
        (\key dataListA pairs ->
            case Dict.get key modelB.cells of
                Nothing ->
                    pairs

                Just dataListB ->
                    foldAxB
                        (\( idA, a ) ( idB, b ) ->
                            Dict.insert ( idA, idB ) ( a, b )
                        )
                        pairs
                        dataListA
                        dataListB
        )
        Dict.empty
        modelA.cells
        |> Dict.values
