module EcsV2b_Singletons exposing
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
import V2b_Singletons.Ecs as Ecs
import V2b_Singletons.Ecs.Components as Components
import V2b_Singletons.Ecs.Select as Select


label : String
label =
    "Ecs v2b Singletons"


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


type alias Selector a =
    Select.Selector Components a


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


aSelector : Selector A
aSelector =
    Select.component specs.a


selectA : World -> List ( Ecs.EntityId, A )
selectA world =
    Ecs.selectAll aSelector world


bSelector : Selector B
bSelector =
    Select.component specs.b


selectB : World -> List ( Ecs.EntityId, B )
selectB world =
    Ecs.selectAll bSelector world


cSelector : Selector C
cSelector =
    Select.component specs.c


selectC : World -> List ( Ecs.EntityId, C )
selectC world =
    Ecs.selectAll cSelector world


type alias AB =
    { a : A
    , b : B
    }


abSelector : Selector AB
abSelector =
    Select.select2 AB
        specs.a
        specs.b


selectAB : World -> List ( Ecs.EntityId, AB )
selectAB world =
    Ecs.selectAll abSelector world


type alias BA =
    { b : B
    , a : A
    }


baSelector : Selector BA
baSelector =
    Select.select2 BA
        specs.b
        specs.a


selectBA : World -> List ( Ecs.EntityId, BA )
selectBA world =
    Ecs.selectAll baSelector world


type alias ABC =
    { a : A
    , b : B
    , c : C
    }


abcSelector : Selector ABC
abcSelector =
    Select.select3 ABC
        specs.a
        specs.b
        specs.c


selectABC : World -> List ( Ecs.EntityId, ABC )
selectABC world =
    Ecs.selectAll abcSelector world


type alias CBA =
    { c : C
    , b : B
    , a : A
    }


cbaSelector : Selector CBA
cbaSelector =
    Select.select3 CBA
        specs.c
        specs.b
        specs.a


selectCBA : World -> List ( Ecs.EntityId, CBA )
selectCBA world =
    Ecs.selectAll cbaSelector world
