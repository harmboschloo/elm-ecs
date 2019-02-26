module Core.Collision.Grid exposing
    ( CollisionGrid, Item
    , empty
    , insert, clear
    , collisions
    )

{-|

@docs CollisionGrid, Item
@docs empty
@docs insert, clear
@docs collisions

-}

import Dict exposing (Dict)
import Core.Collision.Bounds as Bounds exposing (Bounds)
import Core.Collision.Position exposing (Position)
import Core.Collision.Shape as Shape exposing (Shape)


type CollisionGrid c a
    = CollisionGrid Size (List (Category c a))


type alias Size =
    { width : Float
    , height : Float
    }


type alias Category c a =
    { type_ : c
    , cells : Cells a
    , nextId : Id
    }


type alias Cells a =
    Dict ( Int, Int ) (List ( Id, Bounds, Item a ))


type alias Id =
    Int


type alias Item a =
    { position : Position
    , shape : Shape
    , data : a
    }


empty : Float -> Float -> CollisionGrid c a
empty cellWidth cellHeight =
    CollisionGrid (Size cellWidth cellHeight) []


emptyCategory : c -> Category c a
emptyCategory type_ =
    { type_ = type_
    , cells = Dict.empty
    , nextId = 0
    }


insert : Position -> Shape -> a -> c -> CollisionGrid c a -> CollisionGrid c a
insert position shape data categoryType (CollisionGrid cellSize categories) =
    CollisionGrid
        cellSize
        (updateCategory
            categoryType
            (\category ->
                insertItem
                    (Shape.bounds position shape)
                    { position = position
                    , shape = shape
                    , data = data
                    }
                    cellSize
                    category
            )
            categories
        )


clear : c -> CollisionGrid c a -> CollisionGrid c a
clear categoryType (CollisionGrid cellSize categories) =
    CollisionGrid
        cellSize
        (List.filter (\c -> c.type_ /= categoryType) categories)


updateCategory :
    c
    -> (Category c a -> Category c a)
    -> List (Category c a)
    -> List (Category c a)
updateCategory type_ updater categories =
    case categories of
        [] ->
            [ updater (emptyCategory type_) ]

        head :: tail ->
            if head.type_ == type_ then
                updater head :: tail

            else
                head :: updateCategory type_ updater tail


insertItem : Bounds -> Item a -> Size -> Category c a -> Category c a
insertItem bounds item cellSize category =
    let
        xRange =
            List.range
                (toCellIndex bounds.left cellSize.width)
                (toCellIndex bounds.right cellSize.width)

        yRange =
            List.range
                (toCellIndex bounds.top cellSize.height)
                (toCellIndex bounds.bottom cellSize.height)

        entry =
            ( category.nextId, bounds, item )

        cells =
            foldAxB
                (\x y -> insertAt ( x, y ) entry)
                category.cells
                xRange
                yRange
    in
    { type_ = category.type_
    , cells = cells
    , nextId = category.nextId + 1
    }


insertAt : ( Int, Int ) -> ( Id, Bounds, Item a ) -> Cells a -> Cells a
insertAt key entry cells =
    Dict.update key
        (\maybeItems ->
            case maybeItems of
                Nothing ->
                    Just [ entry ]

                Just entries ->
                    Just (entry :: entries)
        )
        cells


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


collisions : c -> c -> CollisionGrid c a -> List ( Item a, Item a )
collisions categoryTypeA categoryTypeB (CollisionGrid size categories) =
    if categoryTypeA == categoryTypeB then
        case findCategory categoryTypeA categories of
            Just category ->
                -- TODO collisionsAA size category
                []

            _ ->
                []

    else
        case
            ( findCategory categoryTypeA categories
            , findCategory categoryTypeB categories
            )
        of
            ( Just categoryA, Just categoryB ) ->
                collisionsAB size categoryA categoryB

            _ ->
                []


collisionsAB : Size -> Category c a -> Category c a -> List ( Item a, Item a )
collisionsAB cellSize categoryA categoryB =
    categoryA.cells
        |> Dict.foldl
            (\key dataListA pairs ->
                case Dict.get key categoryB.cells of
                    Nothing ->
                        pairs

                    Just dataListB ->
                        foldAxB
                            (\( idA, boundsA, itemA ) ( idB, boundsB, itemB ) ->
                                if Bounds.intersect boundsA boundsB then
                                    if shapeIntersect itemA itemB then
                                        Dict.insert ( idA, idB ) ( itemA, itemB )

                                    else
                                        identity

                                else
                                    identity
                            )
                            pairs
                            dataListA
                            dataListB
            )
            Dict.empty
        |> Dict.values


shapeIntersect : Item a -> Item a -> Bool
shapeIntersect itemA itemB =
    Shape.intersect itemA.position itemA.shape itemB.position itemB.shape


findCategory : c -> List (Category c a) -> Maybe (Category c a)
findCategory categoryType categories =
    case categories of
        [] ->
            Nothing

        head :: tail ->
            if head.type_ == categoryType then
                Just head

            else
                findCategory categoryType tail
