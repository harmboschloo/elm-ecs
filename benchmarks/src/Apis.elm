module Apis exposing
    ( EcsApi
    , ecs1
    , ecs8
    , ecs8b
    )

import Ecs1
import Ecs1.Dict3
import Ecs8
import Ecs8.Ecs
import Ecs8b
import Ecs8b.Ecs



-- APIS --


type alias EcsApi ecs =
    { label : String
    , empty : ecs
    , createA : ecs -> ecs
    , createB : ecs -> ecs
    , createC : ecs -> ecs
    , createAB : ecs -> ecs
    , createAC : ecs -> ecs
    , createBC : ecs -> ecs
    , createABC : ecs -> ecs
    , iterateA : ecs -> ecs
    , iterateAB : ecs -> ecs
    , iterateABC : ecs -> ecs
    , iterateAModifyA : ecs -> ecs
    , iterateABModifyA : ecs -> ecs
    , iterateABCModifyA : ecs -> ecs
    , iterateAModifyAB : ecs -> ecs
    , iterateAModifyABC : ecs -> ecs
    , update2_XX_X : ecs -> ecs
    , update3_XX_X : ecs -> ecs
    , update4_XX_X : ecs -> ecs
    , update5_XX_X : ecs -> ecs
    }


ecs1 : EcsApi Ecs1.Ecs
ecs1 =
    let
        update_AB_A =
            Ecs1.Dict3.iterate Ecs1.nodes.ab (\entityId _ -> insert (Ecs1.Dict3.insert entityId) Ecs1.components.a) |> withContext
    in
    { label = "Ecs1"
    , empty = Ecs1.Dict3.empty
    , createA = createAndInsert Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.a
    , createB = createAndInsert Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.b
    , createC = createAndInsert Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.c
    , createAB = createAndInsert2 Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.a Ecs1.components.b
    , createAC = createAndInsert2 Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.a Ecs1.components.c
    , createBC = createAndInsert2 Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.b Ecs1.components.c
    , createABC = createAndInsert3 Ecs1.Dict3.create Ecs1.Dict3.insert Ecs1.components.a Ecs1.components.b Ecs1.components.c
    , iterateA = Ecs1.Dict3.iterate Ecs1.nodes.a (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1.Dict3.iterate Ecs1.nodes.ab (\_ _ x -> x) |> withContext
    , iterateABC = Ecs1.Dict3.iterate Ecs1.nodes.abc (\_ _ x -> x) |> withContext
    , iterateAModifyA = Ecs1.Dict3.iterate Ecs1.nodes.a (\entityId _ -> insert (Ecs1.Dict3.insert entityId) Ecs1.components.a) |> withContext
    , iterateABModifyA = update_AB_A
    , iterateABCModifyA = Ecs1.Dict3.iterate Ecs1.nodes.abc (\entityId _ -> insert (Ecs1.Dict3.insert entityId) Ecs1.components.a) |> withContext
    , iterateAModifyAB = Ecs1.Dict3.iterate Ecs1.nodes.a (\entityId _ -> insert (Ecs1.Dict3.insert entityId) Ecs1.components.a >> insert (Ecs1.Dict3.insert entityId) Ecs1.components.b) |> withContext
    , iterateAModifyABC = Ecs1.Dict3.iterate Ecs1.nodes.a (\entityId _ -> insert (Ecs1.Dict3.insert entityId) Ecs1.components.a >> insert (Ecs1.Dict3.insert entityId) Ecs1.components.b >> insert (Ecs1.Dict3.insert entityId) Ecs1.components.c) |> withContext
    , update2_XX_X = update_AB_A >> update_AB_A
    , update3_XX_X = update_AB_A >> update_AB_A >> update_AB_A
    , update4_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    , update5_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    }


ecs8 : EcsApi Ecs8.Ecs
ecs8 =
    let
        create updater ecs =
            Ecs8.Ecs.create Ecs8.entity updater ecs |> Tuple.second

        set =
            Ecs8.Ecs.set

        process =
            Ecs8.Ecs.process >> withContext

        a =
            Ecs8.components.a

        b =
            Ecs8.components.b

        c =
            Ecs8.components.c

        aNode =
            Ecs8.nodes.a

        abNode =
            Ecs8.nodes.ab

        abcNode =
            Ecs8.nodes.abc

        ab_aSystem =
            Ecs8.Ecs.processor abNode (\_ ( e, x ) -> ( e |> set a (), x ))
    in
    { label = "Ecs8"
    , empty = Ecs8.Ecs.empty
    , createA = create (set a ())
    , createB = create (set b ())
    , createC = create (set c ())
    , createAB = create (set a () >> set b ())
    , createAC = create (set a () >> set c ())
    , createBC = create (set b () >> set c ())
    , createABC = create (set a () >> set b () >> set c ())
    , iterateA = process [ Ecs8.Ecs.processor aNode (\_ s -> s) ]
    , iterateAB = process [ Ecs8.Ecs.processor abNode (\_ s -> s) ]
    , iterateABC = process [ Ecs8.Ecs.processor abcNode (\_ s -> s) ]
    , iterateAModifyA = process [ Ecs8.Ecs.processor aNode (\_ ( e, x ) -> ( e |> set a (), x )) ]
    , iterateABModifyA = process [ Ecs8.Ecs.processor abNode (\_ ( e, x ) -> ( e |> set a (), x )) ]
    , iterateABCModifyA = process [ Ecs8.Ecs.processor abcNode (\_ ( e, x ) -> ( e |> set a (), x )) ]
    , iterateAModifyAB = process [ Ecs8.Ecs.processor aNode (\_ ( e, x ) -> ( e |> set a () |> set b (), x )) ]
    , iterateAModifyABC = process [ Ecs8.Ecs.processor aNode (\_ ( e, x ) -> ( e |> set a () |> set b () |> set c (), x )) ]
    , update2_XX_X = process [ ab_aSystem, ab_aSystem ]
    , update3_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem ]
    , update4_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem ]
    , update5_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem ]
    }


ecs8b : EcsApi Ecs8b.Ecs
ecs8b =
    let
        create builder ecs =
            Ecs8b.Ecs.createWith builder ecs |> Tuple.second

        andSet =
            Ecs8b.Ecs.andSet

        process =
            Ecs8b.Ecs.process >> withContext

        a =
            Ecs8b.components.a

        b =
            Ecs8b.components.b

        c =
            Ecs8b.components.c

        aNode =
            Ecs8b.nodes.a

        abNode =
            Ecs8b.nodes.ab

        abcNode =
            Ecs8b.nodes.abc

        ab_aSystem =
            Ecs8b.Ecs.processor abNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> Tuple.second, x ))
    in
    { label = "Ecs8b"
    , empty = Ecs8b.Ecs.empty Ecs8b.entity
    , createA = create (andSet a ())
    , createB = create (andSet b ())
    , createC = create (andSet c ())
    , createAB = create (andSet a () >> andSet b ())
    , createAC = create (andSet a () >> andSet c ())
    , createBC = create (andSet b () >> andSet c ())
    , createABC = create (andSet a () >> andSet b () >> andSet c ())
    , iterateA = process [ Ecs8b.Ecs.processor aNode (\_ _ ecs x -> ( ecs, x )) ]
    , iterateAB = process [ Ecs8b.Ecs.processor abNode (\_ _ ecs x -> ( ecs, x )) ]
    , iterateABC = process [ Ecs8b.Ecs.processor abcNode (\_ _ ecs x -> ( ecs, x )) ]
    , iterateAModifyA = process [ Ecs8b.Ecs.processor aNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> Tuple.second, x )) ]
    , iterateABModifyA = process [ Ecs8b.Ecs.processor abNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> Tuple.second, x )) ]
    , iterateABCModifyA = process [ Ecs8b.Ecs.processor abcNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> Tuple.second, x )) ]
    , iterateAModifyAB = process [ Ecs8b.Ecs.processor aNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> andSet b () |> Tuple.second, x )) ]
    , iterateAModifyABC = process [ Ecs8b.Ecs.processor aNode (\_ e ecs x -> ( ( e, ecs ) |> andSet a () |> andSet b () |> andSet c () |> Tuple.second, x )) ]
    , update2_XX_X = process [ ab_aSystem, ab_aSystem ]
    , update3_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem ]
    , update4_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem ]
    , update5_XX_X = process [ ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem, ab_aSystem ]
    }



-- HELPERS --


createAndInsert createEntity insertComponent componentType ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    insertComponent entityId componentType () newEcs


createAndInsert2 createEntity insertComponent componentType1 componentType2 ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    newEcs
        |> insertComponent entityId componentType1 ()
        |> insertComponent entityId componentType2 ()


createAndInsert3 createEntity insertComponent componentType1 componentType2 componentType3 ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    newEcs
        |> insertComponent entityId componentType1 ()
        |> insertComponent entityId componentType2 ()
        |> insertComponent entityId componentType3 ()


insert insertComponent componentType ( ecs, x ) =
    ( insertComponent componentType () ecs
    , x
    )


withContext f ecs =
    f ( ecs, () ) |> Tuple.first
