module Ecs2 exposing
    ( builder
    , insertA
    , insertB
    , insertC
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


type alias ComponentSpecs =
    { a : ComponentSpec Data.A
    , b : ComponentSpec Data.B
    , c : ComponentSpec Data.C
    }


type alias ComponentSpec a =
    Spec.ComponentSpec Data a


type alias Data =
    Spec.Data3 A B C


type alias World =
    Ecs.World Data


type alias Selector a =
    Select.Selector Data a


spec : Spec.Spec Data
spec =
    Spec.spec3


components : ComponentSpecs
components =
    Spec.components3 ComponentSpecs


builder : Data.Builder World EntityId
builder =
    { empty = Ecs.empty spec
    , create = \world -> Ecs.create world
    , insertA =
        \a ( world, entityId ) ->
            ( Ecs.insert components.a entityId a world, entityId )
    , insertB =
        \b ( world, entityId ) ->
            ( Ecs.insert components.b entityId b world, entityId )
    , insertC =
        \c ( world, entityId ) ->
            ( Ecs.insert components.c entityId c world, entityId )
    }


insertA : EntityId -> A -> World -> World
insertA entityId a world =
    Ecs.insert components.a entityId a world


insertB : EntityId -> B -> World -> World
insertB entityId b world =
    Ecs.insert components.b entityId b world


insertC : EntityId -> C -> World -> World
insertC entityId c world =
    Ecs.insert components.c entityId c world


aSelector : Selector A
aSelector =
    Select.component components.a


selectA : World -> List ( EntityId, A )
selectA world =
    Ecs.selectList aSelector world


bSelector : Selector B
bSelector =
    Select.component components.b


selectB : World -> List ( EntityId, B )
selectB world =
    Ecs.selectList bSelector world


cSelector : Selector C
cSelector =
    Select.component components.c


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
        components.a
        components.b


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
        components.b
        components.a


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
        components.a
        components.b
        components.c


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
        components.c
        components.b
        components.a


selectCBA : World -> List ( EntityId, CBA )
selectCBA world =
    Ecs.selectList cbaSelector world
