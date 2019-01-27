module Ecs2 exposing
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
import Ecs as Ecs exposing (EntityId)
import Ecs.Select as Select
import Ecs.Spec as Spec


label : String
label =
    "Ecs v2 latest"


type alias Components =
    Spec.Components3 A B C


type alias Specs =
    { all : Spec.Spec Components
    , a : Spec.ComponentSpec Components Data.A
    , b : Spec.ComponentSpec Components Data.B
    , c : Spec.ComponentSpec Components Data.C
    }


specs : Specs
specs =
    Spec.specs3 Specs

type alias World =
    Ecs.World Components


type alias Selector a =
    Select.Selector Components a



builder : Data.Builder World EntityId
builder =
    { empty = Ecs.empty specs.all
    , create = \world -> Ecs.create world
    , insertA =
        \a ( world, entityId ) ->
            ( Ecs.insert specs.a entityId a world, entityId )
    , insertB =
        \b ( world, entityId ) ->
            ( Ecs.insert specs.b entityId b world, entityId )
    , insertC =
        \c ( world, entityId ) ->
            ( Ecs.insert specs.c entityId c world, entityId )
    }


insertA : EntityId -> A -> World -> World
insertA entityId a world =
    Ecs.insert specs.a entityId a world


insertB : EntityId -> B -> World -> World
insertB entityId b world =
    Ecs.insert specs.b entityId b world


insertC : EntityId -> C -> World -> World
insertC entityId c world =
    Ecs.insert specs.c entityId c world


aSelector : Selector A
aSelector =
    Select.component specs.a


selectA : World -> List ( EntityId, A )
selectA world =
    Ecs.selectList aSelector world


bSelector : Selector B
bSelector =
    Select.component specs.b


selectB : World -> List ( EntityId, B )
selectB world =
    Ecs.selectList bSelector world


cSelector : Selector C
cSelector =
    Select.component specs.c


selectC : World -> List ( EntityId, C )
selectC world =
    Ecs.selectList cSelector world


type alias AB =
    { a : A
    , b : B
    }


abSelector : Selector AB
abSelector =
    Select.select2 AB
        specs.a
        specs.b


selectAB : World -> List ( EntityId, AB )
selectAB world =
    Ecs.selectList abSelector world


type alias BA =
    { b : B
    , a : A
    }


baSelector : Selector BA
baSelector =
    Select.select2 BA
        specs.b
        specs.a


selectBA : World -> List ( EntityId, BA )
selectBA world =
    Ecs.selectList baSelector world


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


selectABC : World -> List ( EntityId, ABC )
selectABC world =
    Ecs.selectList abcSelector world


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


selectCBA : World -> List ( EntityId, CBA )
selectCBA world =
    Ecs.selectList cbaSelector world
