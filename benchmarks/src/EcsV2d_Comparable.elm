module EcsV2d_Comparable exposing
    ( builder
    , insertA
    , insertB
    , insertC
    , label
    , selectA
    , selectAB
    , selectABC
    , selectB
    , selectBA
    , selectC
    , selectCBA
    )

import Data exposing (A, B, C)
import V2d_Comparable.Ecs as Ecs
import V2d_Comparable.Ecs.Components3 as Components


label : String
label =
    "Ecs v2d Comparable"


type alias Components =
    Components.Components3 Int A B C


type alias Specs =
    { all : Components.MultiComponentSpec Int Components
    , a : Components.ComponentSpec Int Data.A Components
    , b : Components.ComponentSpec Int Data.B Components
    , c : Components.ComponentSpec Int Data.C Components
    }


specs : Specs
specs =
    Components.specs3 Specs


type alias World =
    Ecs.World Int Components ()


builder : Data.Builder World Int
builder =
    { empty = Ecs.emptyWorld specs.all ()
    , create =
        \world ->
            let
                entityId =
                    Ecs.lastEntityId world
                        |> Maybe.map ((+) 1)
                        |> Maybe.withDefault 0
            in
            ( Ecs.insertEntity entityId world, entityId )
    , insertA =
        \a ( world, entityId ) ->
            ( Ecs.insertComponent specs.a entityId a world, entityId )
    , insertB =
        \b ( world, entityId ) ->
            ( Ecs.insertComponent specs.b entityId b world, entityId )
    , insertC =
        \c ( world, entityId ) ->
            ( Ecs.insertComponent specs.c entityId c world, entityId )
    }


insertA : Int -> A -> World -> World
insertA entityId a world =
    Ecs.insertComponent specs.a entityId a world


insertB : Int -> B -> World -> World
insertB entityId b world =
    Ecs.insertComponent specs.b entityId b world


insertC : Int -> C -> World -> World
insertC entityId c world =
    Ecs.insertComponent specs.c entityId c world


selectA : World -> List ( Int, A )
selectA world =
    Ecs.foldComponentsFromBack specs.a (\id a list -> ( id, a ) :: list) [] world


selectB : World -> List ( Int, B )
selectB world =
    Ecs.foldComponentsFromBack specs.b (\id b list -> ( id, b ) :: list) [] world


selectC : World -> List ( Int, C )
selectC world =
    Ecs.foldComponentsFromBack specs.c (\id c list -> ( id, c ) :: list) [] world


type alias AB =
    { a : A
    , b : B
    }


selectAB : World -> List ( Int, AB )
selectAB world =
    Ecs.foldComponents2FromBack specs.a specs.b (\id a b list -> ( id, AB a b ) :: list) [] world


type alias BA =
    { b : B
    , a : A
    }


selectBA : World -> List ( Int, BA )
selectBA world =
    Ecs.foldComponents2FromBack specs.b specs.a (\id b a list -> ( id, BA b a ) :: list) [] world


type alias ABC =
    { a : A
    , b : B
    , c : C
    }


selectABC : World -> List ( Int, ABC )
selectABC world =
    Ecs.foldComponents3FromBack specs.a specs.b specs.c (\id a b c list -> ( id, ABC a b c ) :: list) [] world


type alias CBA =
    { c : C
    , b : B
    , a : A
    }


selectCBA : World -> List ( Int, CBA )
selectCBA world =
    Ecs.foldComponents3FromBack specs.c specs.b specs.a (\id c b a list -> ( id, CBA c b a ) :: list) [] world
