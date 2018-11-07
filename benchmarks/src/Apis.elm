module Apis exposing
    ( EcsApi
    , ecs1
    , ecs5
    , ecs6
    , ecs7
    , ecs8
    )

import Ecs1
import Ecs1.Dict3
import Ecs5
import Ecs6
import Ecs7
import Ecs8
import Ecs8.Entity3



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
    { label = "Ecs1/Dict3 record of dicts"
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


ecs5 : EcsApi Ecs5.Ecs
ecs5 =
    let
        update_AB_A =
            Ecs5.iterateAndUpdate Ecs5.abNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent ()) ecs, x )) |> withContext
    in
    { label = "Ecs5 array of records with nodes"
    , empty = Ecs5.empty
    , createA = Ecs5.create (Ecs5.insert Ecs5.aComponent ())
    , createB = Ecs5.create (Ecs5.insert Ecs5.bComponent ())
    , createC = Ecs5.create (Ecs5.insert Ecs5.cComponent ())
    , createAB = Ecs5.create (Ecs5.insert Ecs5.aComponent () >> Ecs5.insert Ecs5.bComponent ())
    , createAC = Ecs5.create (Ecs5.insert Ecs5.aComponent () >> Ecs5.insert Ecs5.cComponent ())
    , createBC = Ecs5.create (Ecs5.insert Ecs5.bComponent () >> Ecs5.insert Ecs5.cComponent ())
    , createABC = Ecs5.create (Ecs5.insert Ecs5.aComponent () >> Ecs5.insert Ecs5.bComponent () >> Ecs5.insert Ecs5.cComponent ())
    , iterateA = Ecs5.iterate Ecs5.aNode (\_ _ _ x -> x) |> withContext2
    , iterateAB = Ecs5.iterate Ecs5.abNode (\_ _ _ x -> x) |> withContext2
    , iterateABC = Ecs5.iterate Ecs5.abcNode (\_ _ _ x -> x) |> withContext2
    , iterateAModifyA = Ecs5.iterateAndUpdate Ecs5.aNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent ()) ecs, x )) |> withContext
    , iterateABModifyA = update_AB_A
    , iterateABCModifyA = Ecs5.iterateAndUpdate Ecs5.abcNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent ()) ecs, x )) |> withContext
    , iterateAModifyAB = Ecs5.iterateAndUpdate Ecs5.aNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent () |> Ecs5.insert Ecs5.bComponent ()) ecs, x )) |> withContext
    , iterateAModifyABC = Ecs5.iterateAndUpdate Ecs5.aNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent () |> Ecs5.insert Ecs5.bComponent () |> Ecs5.insert Ecs5.cComponent ()) ecs, x )) |> withContext
    , update2_XX_X = update_AB_A >> update_AB_A
    , update3_XX_X = update_AB_A >> update_AB_A >> update_AB_A
    , update4_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    , update5_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    }


ecs6 : EcsApi Ecs6.Ecs
ecs6 =
    let
        update_AB_A =
            Ecs6.iterate Ecs6.abNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent) |> withContext
    in
    { label = "Ecs6 record of dicts with nodes"
    , empty = Ecs6.empty
    , createA = createAndInsert Ecs6.create Ecs6.insert Ecs6.aComponent
    , createB = createAndInsert Ecs6.create Ecs6.insert Ecs6.bComponent
    , createC = createAndInsert Ecs6.create Ecs6.insert Ecs6.cComponent
    , createAB = createAndInsert2 Ecs6.create Ecs6.insert Ecs6.aComponent Ecs6.bComponent
    , createAC = createAndInsert2 Ecs6.create Ecs6.insert Ecs6.aComponent Ecs6.cComponent
    , createBC = createAndInsert2 Ecs6.create Ecs6.insert Ecs6.bComponent Ecs6.cComponent
    , createABC = createAndInsert3 Ecs6.create Ecs6.insert Ecs6.aComponent Ecs6.bComponent Ecs6.cComponent
    , iterateA = Ecs6.iterate Ecs6.aNode (\_ _ x -> x) |> withContext
    , iterateAB = Ecs6.iterate Ecs6.abNode (\_ _ x -> x) |> withContext
    , iterateABC = Ecs6.iterate Ecs6.abcNode (\_ _ x -> x) |> withContext
    , iterateAModifyA = Ecs6.iterate Ecs6.aNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent) |> withContext
    , iterateABModifyA = update_AB_A
    , iterateABCModifyA = Ecs6.iterate Ecs6.abcNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent) |> withContext
    , iterateAModifyAB = Ecs6.iterate Ecs6.aNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent >> insert (Ecs6.insert entityId) Ecs6.bComponent) |> withContext
    , iterateAModifyABC = Ecs6.iterate Ecs6.aNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent >> insert (Ecs6.insert entityId) Ecs6.bComponent >> insert (Ecs6.insert entityId) Ecs6.cComponent) |> withContext
    , update2_XX_X = update_AB_A >> update_AB_A
    , update3_XX_X = update_AB_A >> update_AB_A >> update_AB_A
    , update4_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    , update5_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    }


ecs7 : EcsApi Ecs7.Ecs
ecs7 =
    let
        aNode =
            Ecs7.aNode (\_ _ s -> s)

        abNode =
            Ecs7.abNode (\_ _ s -> s)

        abcNode =
            Ecs7.abcNode (\_ _ s -> s)

        a_aNode =
            Ecs7.aNode (\_ _ ( e, ecs, x ) -> ( { e | a = Just (), b = e.b, c = e.c }, ecs, x ))

        ab_aNode =
            Ecs7.abNode (\_ _ ( e, ecs, x ) -> ( { e | a = Just (), b = e.b, c = e.c }, ecs, x ))

        abc_aNode =
            Ecs7.abcNode (\_ _ ( e, ecs, x ) -> ( { e | a = Just (), b = e.b, c = e.c }, ecs, x ))

        a_abNode =
            Ecs7.aNode (\_ _ ( e, ecs, x ) -> ( { e | a = Just (), b = Just (), c = e.c }, ecs, x ))

        a_abcNode =
            Ecs7.aNode (\_ _ ( e, ecs, x ) -> ( { e | a = Just (), b = Just (), c = Just () }, ecs, x ))
    in
    { label = "Ecs7 array of records"
    , empty = Ecs7.empty
    , createA = Ecs7.create { a = Just (), b = Nothing, c = Nothing } >> Tuple.first
    , createB = Ecs7.create { a = Nothing, b = Just (), c = Nothing } >> Tuple.first
    , createC = Ecs7.create { a = Nothing, b = Nothing, c = Just () } >> Tuple.first
    , createAB = Ecs7.create { a = Just (), b = Just (), c = Nothing } >> Tuple.first
    , createAC = Ecs7.create { a = Just (), b = Nothing, c = Just () } >> Tuple.first
    , createBC = Ecs7.create { a = Nothing, b = Just (), c = Just () } >> Tuple.first
    , createABC = Ecs7.create { a = Just (), b = Just (), c = Just () } >> Tuple.first
    , iterateA = Ecs7.viewAll [ aNode ] |> withContext
    , iterateAB = Ecs7.viewAll [ abNode ] |> withContext
    , iterateABC = Ecs7.viewAll [ abcNode ] |> withContext
    , iterateAModifyA = Ecs7.updateAll [ a_aNode ] |> withContext
    , iterateABModifyA = Ecs7.updateAll [ ab_aNode ] |> withContext
    , iterateABCModifyA = Ecs7.updateAll [ abc_aNode ] |> withContext
    , iterateAModifyAB = Ecs7.updateAll [ a_abNode ] |> withContext
    , iterateAModifyABC = Ecs7.updateAll [ a_abcNode ] |> withContext
    , update2_XX_X = Ecs7.updateAll [ ab_aNode, ab_aNode ] |> withContext
    , update3_XX_X = Ecs7.updateAll [ ab_aNode, ab_aNode, ab_aNode ] |> withContext
    , update4_XX_X = Ecs7.updateAll [ ab_aNode, ab_aNode, ab_aNode, ab_aNode ] |> withContext
    , update5_XX_X = Ecs7.updateAll [ ab_aNode, ab_aNode, ab_aNode, ab_aNode, ab_aNode ] |> withContext
    }


ecs8 : EcsApi Ecs8.Ecs
ecs8 =
    let
        create =
            \ecs -> Ecs8.Entity3.createWith ecs >> Tuple.first

        set =
            Ecs8.Entity3.set

        updateAll =
            Ecs8.Entity3.updateAll >> withContext

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

        ab_aNode =
            abNode (\_ ( e, ecs, x ) -> ( e |> set a (), ecs, x ))
    in
    { label = "Ecs8/Entity3"
    , empty = Ecs8.Entity3.empty
    , createA = create (set a ())
    , createB = create (set b ())
    , createC = create (set c ())
    , createAB = create (set a () >> set b ())
    , createAC = create (set a () >> set c ())
    , createBC = create (set b () >> set c ())
    , createABC = create (set a () >> set b () >> set c ())
    , iterateA = updateAll (aNode (\_ s -> s))
    , iterateAB = updateAll (abNode (\_ s -> s))
    , iterateABC = updateAll (abcNode (\_ s -> s))
    , iterateAModifyA = updateAll (aNode (\_ ( e, ecs, x ) -> ( e |> set a (), ecs, x )))
    , iterateABModifyA = updateAll (abNode (\_ ( e, ecs, x ) -> ( e |> set a (), ecs, x )))
    , iterateABCModifyA = updateAll (abcNode (\_ ( e, ecs, x ) -> ( e |> set a (), ecs, x )))
    , iterateAModifyAB = updateAll (aNode (\_ ( e, ecs, x ) -> ( e |> set a () |> set b (), ecs, x )))
    , iterateAModifyABC = updateAll (aNode (\_ ( e, ecs, x ) -> ( e |> set a () |> set b () |> set c (), ecs, x )))
    , update2_XX_X = updateAll (ab_aNode >> ab_aNode)
    , update3_XX_X = updateAll (ab_aNode >> ab_aNode >> ab_aNode)
    , update4_XX_X = updateAll (ab_aNode >> ab_aNode >> ab_aNode >> ab_aNode)
    , update5_XX_X = updateAll (ab_aNode >> ab_aNode >> ab_aNode >> ab_aNode >> ab_aNode)
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


withContext2 f ecs =
    f ecs () |> always ecs
