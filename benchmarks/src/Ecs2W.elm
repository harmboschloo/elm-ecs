module Ecs2W exposing
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
import V2W.Ecs as Ecs exposing (EntityId)
import V2W.Ecs.Select as Select


label : String
label =
    "Ecs v2 wrapped"


type Component
    = AComponent A
    | BComponent B
    | CComponent C


aConfig : Ecs.ComponentConfig Component A
aConfig =
    { wrap = AComponent
    , unwrap =
        \data ->
            case data of
                AComponent a ->
                    Just a

                _ ->
                    Nothing
    }


bConfig : Ecs.ComponentConfig Component B
bConfig =
    { wrap = BComponent
    , unwrap =
        \data ->
            case data of
                BComponent b ->
                    Just b

                _ ->
                    Nothing
    }


cConfig : Ecs.ComponentConfig Component C
cConfig =
    { wrap = CComponent
    , unwrap =
        \data ->
            case data of
                CComponent c ->
                    Just c

                _ ->
                    Nothing
    }


type alias ComponentSpecs =
    { a : Ecs.ComponentSpec Component A
    , b : Ecs.ComponentSpec Component B
    , c : Ecs.ComponentSpec Component C
    }


type alias World =
    Ecs.Ecs Component


type alias Selector a =
    Select.Selector Component a


componentSpecs : ComponentSpecs
componentSpecs =
    Ecs.componentSpecsStart ComponentSpecs
        |> Ecs.componentSpec aConfig
        |> Ecs.componentSpec bConfig
        |> Ecs.componentSpec cConfig
        |> Ecs.componentSpecsEnd


builder : Data.Builder World EntityId
builder =
    { empty = Ecs.empty
    , create = \world -> Ecs.create [] world
    , insertA =
        \a ( world, entityId ) ->
            ( Ecs.insert componentSpecs.a entityId a world, entityId )
    , insertB =
        \b ( world, entityId ) ->
            ( Ecs.insert componentSpecs.b entityId b world, entityId )
    , insertC =
        \c ( world, entityId ) ->
            ( Ecs.insert componentSpecs.c entityId c world, entityId )
    }


insertA : EntityId -> A -> World -> World
insertA entityId a world =
    Ecs.insert componentSpecs.a entityId a world


insertB : EntityId -> B -> World -> World
insertB entityId b world =
    Ecs.insert componentSpecs.b entityId b world


insertC : EntityId -> C -> World -> World
insertC entityId c world =
    Ecs.insert componentSpecs.c entityId c world


aSelector : Selector A
aSelector =
    Select.component componentSpecs.a


selectA : World -> List ( EntityId, A )
selectA world =
    Ecs.selectAll aSelector world


bSelector : Selector B
bSelector =
    Select.component componentSpecs.b


selectB : World -> List ( EntityId, B )
selectB world =
    Ecs.selectAll bSelector world


cSelector : Selector C
cSelector =
    Select.component componentSpecs.c


selectC : World -> List ( EntityId, C )
selectC world =
    Ecs.selectAll cSelector world


type alias AB =
    { a : A
    , b : B
    }


abSelector : Selector AB
abSelector =
    Select.select2 AB
        componentSpecs.a
        componentSpecs.b


selectAB : World -> List ( EntityId, AB )
selectAB world =
    Ecs.selectAll abSelector world


type alias BA =
    { b : B
    , a : A
    }


baSelector : Selector BA
baSelector =
    Select.select2 BA
        componentSpecs.b
        componentSpecs.a


selectBA : World -> List ( EntityId, BA )
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
        componentSpecs.a
        componentSpecs.b
        componentSpecs.c


selectABC : World -> List ( EntityId, ABC )
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
        componentSpecs.c
        componentSpecs.b
        componentSpecs.a


selectCBA : World -> List ( EntityId, CBA )
selectCBA world =
    Ecs.selectAll cbaSelector world
