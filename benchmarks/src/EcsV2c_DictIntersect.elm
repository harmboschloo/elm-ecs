module EcsV2c_DictIntersect exposing
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
import V2c_DictIntersect.Ecs as Ecs
import V2c_DictIntersect.Ecs.Components3 as Components


label : String
label =
    "Ecs v2c DictIntersect"


type alias Components =
    Components.Components3 A B C


type alias Specs =
    { all : Components.AllComponentsSpec Components
    , a : Components.ComponentSpec Components Data.A
    , b : Components.ComponentSpec Components Data.B
    , c : Components.ComponentSpec Components Data.C
    }


specs : Specs
specs =
    Components.specs3 Specs


type alias World =
    Ecs.World Components ()


builder : Data.Builder World Ecs.EntityId
builder =
    { empty = Ecs.emptyWorld specs.all ()
    , create =
        \world ->
            let
                ( entityId, newWorld ) =
                    Ecs.createEntity world
            in
            ( newWorld, entityId )
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


insertA : Ecs.EntityId -> A -> World -> World
insertA entityId a world =
    Ecs.insertComponent specs.a entityId a world


insertB : Ecs.EntityId -> B -> World -> World
insertB entityId b world =
    Ecs.insertComponent specs.b entityId b world


insertC : Ecs.EntityId -> C -> World -> World
insertC entityId c world =
    Ecs.insertComponent specs.c entityId c world


selectA : World -> List ( Ecs.EntityId, A )
selectA world =
    Ecs.foldr specs.a (\id a list -> ( id, a ) :: list) [] world


selectB : World -> List ( Ecs.EntityId, B )
selectB world =
    Ecs.foldr specs.b (\id b list -> ( id, b ) :: list) [] world


selectC : World -> List ( Ecs.EntityId, C )
selectC world =
    Ecs.foldr specs.c (\id c list -> ( id, c ) :: list) [] world


type alias AB =
    { a : A
    , b : B
    }


selectAB : World -> List ( Ecs.EntityId, AB )
selectAB world =
    Ecs.foldr2 specs.a specs.b (\id a b list -> ( id, AB a b ) :: list) [] world


type alias BA =
    { b : B
    , a : A
    }


selectBA : World -> List ( Ecs.EntityId, BA )
selectBA world =
    Ecs.foldr2 specs.b specs.a (\id b a list -> ( id, BA b a ) :: list) [] world


type alias ABC =
    { a : A
    , b : B
    , c : C
    }


selectABC : World -> List ( Ecs.EntityId, ABC )
selectABC world =
    Ecs.foldr3 specs.a specs.b specs.c (\id a b c list -> ( id, ABC a b c ) :: list) [] world


type alias CBA =
    { c : C
    , b : B
    , a : A
    }


selectCBA : World -> List ( Ecs.EntityId, CBA )
selectCBA world =
    Ecs.foldr3 specs.c specs.b specs.a (\id c b a list -> ( id, CBA c b a ) :: list) [] world
