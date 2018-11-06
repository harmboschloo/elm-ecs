module Apis exposing
    ( EcsApi
    , ecs1
    , ecs1b
    , ecs5
    , ecs6
    , ecs7
    )

import Ecs1
import Ecs1.Ecs3
import Ecs1b
import Ecs5
import Ecs6
import Ecs7



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
            Ecs1.iterate2 Ecs1.aComponent Ecs1.bComponent (\entityId _ _ -> insert (Ecs1.insert entityId) Ecs1.aComponent) |> withContext
    in
    { label = "Ecs1 record of dicts"
    , empty = Ecs1.empty
    , createA = createAndInsert Ecs1.create Ecs1.insert Ecs1.aComponent
    , createB = createAndInsert Ecs1.create Ecs1.insert Ecs1.bComponent
    , createC = createAndInsert Ecs1.create Ecs1.insert Ecs1.cComponent
    , createAB = createAndInsert2 Ecs1.create Ecs1.insert Ecs1.aComponent Ecs1.bComponent
    , createAC = createAndInsert2 Ecs1.create Ecs1.insert Ecs1.aComponent Ecs1.cComponent
    , createBC = createAndInsert2 Ecs1.create Ecs1.insert Ecs1.bComponent Ecs1.cComponent
    , createABC = createAndInsert3 Ecs1.create Ecs1.insert Ecs1.aComponent Ecs1.bComponent Ecs1.cComponent
    , iterateA = Ecs1.iterate Ecs1.aComponent (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1.iterate2 Ecs1.aComponent Ecs1.bComponent (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs1.iterate3 Ecs1.aComponent Ecs1.bComponent Ecs1.cComponent (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs1.iterate Ecs1.aComponent (\entityId _ -> insert (Ecs1.insert entityId) Ecs1.aComponent) |> withContext
    , iterateABModifyA = update_AB_A
    , iterateABCModifyA = Ecs1.iterate3 Ecs1.aComponent Ecs1.bComponent Ecs1.cComponent (\entityId _ _ _ -> insert (Ecs1.insert entityId) Ecs1.aComponent) |> withContext
    , iterateAModifyAB = Ecs1.iterate Ecs1.aComponent (\entityId _ -> insert (Ecs1.insert entityId) Ecs1.aComponent >> insert (Ecs1.insert entityId) Ecs1.bComponent) |> withContext
    , iterateAModifyABC = Ecs1.iterate Ecs1.aComponent (\entityId _ -> insert (Ecs1.insert entityId) Ecs1.aComponent >> insert (Ecs1.insert entityId) Ecs1.bComponent >> insert (Ecs1.insert entityId) Ecs1.cComponent) |> withContext
    , update2_XX_X = update_AB_A >> update_AB_A
    , update3_XX_X = update_AB_A >> update_AB_A >> update_AB_A
    , update4_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    , update5_XX_X = update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A >> update_AB_A
    }


ecs1b : EcsApi Ecs1b.Ecs
ecs1b =
    let
        update_AB_A =
            Ecs1.Ecs3.iterate Ecs1b.abNode (\entityId _ -> insert (Ecs1.Ecs3.insert entityId) Ecs1b.a) |> withContext
    in
    { label = "Ecs1b/Ecs1.Ecs3"
    , empty = Ecs1.Ecs3.empty
    , createA = createAndInsert Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.a
    , createB = createAndInsert Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.b
    , createC = createAndInsert Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.c
    , createAB = createAndInsert2 Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.a Ecs1b.b
    , createAC = createAndInsert2 Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.a Ecs1b.c
    , createBC = createAndInsert2 Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.b Ecs1b.c
    , createABC = createAndInsert3 Ecs1.Ecs3.create Ecs1.Ecs3.insert Ecs1b.a Ecs1b.b Ecs1b.c
    , iterateA = Ecs1.Ecs3.iterate Ecs1b.aNode (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1.Ecs3.iterate Ecs1b.abNode (\_ _ x -> x) |> withContext
    , iterateABC = Ecs1.Ecs3.iterate Ecs1b.abcNode (\_ _ x -> x) |> withContext
    , iterateAModifyA = Ecs1.Ecs3.iterate Ecs1b.aNode (\entityId _ -> insert (Ecs1.Ecs3.insert entityId) Ecs1b.a) |> withContext
    , iterateABModifyA = update_AB_A
    , iterateABCModifyA = Ecs1.Ecs3.iterate Ecs1b.abcNode (\entityId _ -> insert (Ecs1.Ecs3.insert entityId) Ecs1b.a) |> withContext
    , iterateAModifyAB = Ecs1.Ecs3.iterate Ecs1b.aNode (\entityId _ -> insert (Ecs1.Ecs3.insert entityId) Ecs1b.a >> insert (Ecs1.Ecs3.insert entityId) Ecs1b.b) |> withContext
    , iterateAModifyABC = Ecs1.Ecs3.iterate Ecs1b.aNode (\entityId _ -> insert (Ecs1.Ecs3.insert entityId) Ecs1b.a >> insert (Ecs1.Ecs3.insert entityId) Ecs1b.b >> insert (Ecs1.Ecs3.insert entityId) Ecs1b.c) |> withContext
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
