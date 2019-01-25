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
import V1.Ecs as Ecs
import V1.Ecs.Select as Select
import V1.Ecs.Spec as Spec


type alias ComponentSpecs =
    { a : ComponentSpec Data.A
    , b : ComponentSpec Data.B
    , c : ComponentSpec Data.C
    }


type alias ComponentSpec a =
    Spec.ComponentSpec Int Ecs a


type alias Ecs =
    Spec.Ecs3 Int A B C


type alias Selector a =
    Select.Selector Int Ecs a


spec : Spec.Spec Int Ecs
spec =
    Spec.spec3


components : ComponentSpecs
components =
    Spec.components3 ComponentSpecs


builder : Data.Builder ( Int, Ecs ) Int
builder =
    { empty = ( 0, Ecs.empty spec )
    , create = \( nextId, ecs ) -> ( ( nextId + 1, ecs ), nextId )
    , insertA =
        \a ( ( nextId, ecs ), entityId ) ->
            ( ( nextId, Ecs.insert components.a entityId a ecs ), entityId )
    , insertB =
        \b ( ( nextId, ecs ), entityId ) ->
            ( ( nextId, Ecs.insert components.b entityId b ecs ), entityId )
    , insertC =
        \c ( ( nextId, ecs ), entityId ) ->
            ( ( nextId, Ecs.insert components.c entityId c ecs ), entityId )
    }


insertA : Int -> A -> ( Int, Ecs ) -> ( Int, Ecs )
insertA entityId a ( x, ecs ) =
    ( x, Ecs.insert components.a entityId a ecs )


insertB : Int -> B -> ( Int, Ecs ) -> ( Int, Ecs )
insertB entityId b ( x, ecs ) =
    ( x, Ecs.insert components.b entityId b ecs )


insertC : Int -> C -> ( Int, Ecs ) -> ( Int, Ecs )
insertC entityId c ( x, ecs ) =
    ( x, Ecs.insert components.c entityId c ecs )


aSelector : Selector A
aSelector =
    Select.component components.a


selectA : ( Int, Ecs ) -> List ( Int, A )
selectA ( _, ecs ) =
    Ecs.selectList aSelector ecs


bSelector : Selector B
bSelector =
    Select.component components.b


selectB : ( Int, Ecs ) -> List ( Int, B )
selectB ( _, ecs ) =
    Ecs.selectList bSelector ecs


cSelector : Selector C
cSelector =
    Select.component components.c


selectC : ( Int, Ecs ) -> List ( Int, C )
selectC ( _, ecs ) =
    Ecs.selectList cSelector ecs


type alias AB =
    { a : A
    , b : B
    }


abSelector : Selector AB
abSelector =
    Select.select2 AB
        components.a
        components.b


selectAB : ( Int, Ecs ) -> List ( Int, AB )
selectAB ( _, ecs ) =
    Ecs.selectList abSelector ecs


type alias BA =
    { b : B
    , a : A
    }


baSelector : Selector BA
baSelector =
    Select.select2 BA
        components.b
        components.a


selectBA : ( Int, Ecs ) -> List ( Int, BA )
selectBA ( _, ecs ) =
    Ecs.selectList baSelector ecs


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


selectABC : ( Int, Ecs ) -> List ( Int, ABC )
selectABC ( _, ecs ) =
    Ecs.selectList abcSelector ecs


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


selectCBA : ( Int, Ecs ) -> List ( Int, CBA )
selectCBA ( _, ecs ) =
    Ecs.selectList cbaSelector ecs
