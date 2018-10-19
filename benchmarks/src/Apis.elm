module Apis exposing
    ( EcsApi
    , ecs1
    , ecs2
    , ecs3
    , ecs4
    , ecs4b
    , ecs5
    )

import Ecs1
import Ecs2
import Ecs3
import Ecs4
import Ecs4b
import Ecs5



-- APIS --


type alias EcsApi ecs entityId =
    { label : String
    , empty : ecs
    , createA : ecs -> ( ecs, entityId )
    , createB : ecs -> ( ecs, entityId )
    , createC : ecs -> ( ecs, entityId )
    , createAB : ecs -> ( ecs, entityId )
    , createAC : ecs -> ( ecs, entityId )
    , createABC : ecs -> ( ecs, entityId )
    , iterateA : ecs -> ecs
    , iterateAB : ecs -> ecs
    , iterateABC : ecs -> ecs
    }


ecs1 : EcsApi Ecs1.Ecs Ecs1.EntityId
ecs1 =
    { label = "Ecs1 record of dicts"
    , empty = Ecs1.empty
    , createA = createAndInsert Ecs1.createEntity Ecs1.insertComponent Ecs1.a
    , createB = createAndInsert Ecs1.createEntity Ecs1.insertComponent Ecs1.b
    , createC = createAndInsert Ecs1.createEntity Ecs1.insertComponent Ecs1.c
    , createAB = createAndInsert2 Ecs1.createEntity Ecs1.insertComponent Ecs1.a Ecs1.b
    , createAC = createAndInsert2 Ecs1.createEntity Ecs1.insertComponent Ecs1.a Ecs1.c
    , createABC = createAndInsert3 Ecs1.createEntity Ecs1.insertComponent Ecs1.a Ecs1.b Ecs1.c
    , iterateA = Ecs1.iterateEntities Ecs1.a (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1.iterateEntities2 Ecs1.a Ecs1.b (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs1.iterateEntities3 Ecs1.a Ecs1.b Ecs1.c (\_ _ _ _ x -> x) |> withContext
    }


ecs2 : EcsApi Ecs2.Ecs Ecs2.EntityId
ecs2 =
    { label = "Ecs2 record of arrays"
    , empty = Ecs2.empty
    , createA = createAndInsert Ecs2.createEntity Ecs2.insertComponent Ecs2.a
    , createB = createAndInsert Ecs2.createEntity Ecs2.insertComponent Ecs2.b
    , createC = createAndInsert Ecs2.createEntity Ecs2.insertComponent Ecs2.c
    , createAB = createAndInsert2 Ecs2.createEntity Ecs2.insertComponent Ecs2.a Ecs2.b
    , createAC = createAndInsert2 Ecs2.createEntity Ecs2.insertComponent Ecs2.a Ecs2.c
    , createABC = createAndInsert3 Ecs2.createEntity Ecs2.insertComponent Ecs2.a Ecs2.b Ecs2.c
    , iterateA = Ecs2.iterateEntities Ecs2.a (\_ _ x -> x) |> withContext
    , iterateAB = Ecs2.iterateEntities2 Ecs2.a Ecs2.b (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs2.iterateEntities3 Ecs2.a Ecs2.b Ecs2.c (\_ _ _ _ x -> x) |> withContext
    }


ecs3 : EcsApi Ecs3.Ecs Ecs3.EntityId
ecs3 =
    { label = "Ecs3 record of dicts with nodes"
    , empty = Ecs3.empty
    , createA = createAndInsert Ecs3.createEntity Ecs3.insertComponent Ecs3.a
    , createB = createAndInsert Ecs3.createEntity Ecs3.insertComponent Ecs3.b
    , createC = createAndInsert Ecs3.createEntity Ecs3.insertComponent Ecs3.c
    , createAB = createAndInsert2 Ecs3.createEntity Ecs3.insertComponent Ecs3.a Ecs3.b
    , createAC = createAndInsert2 Ecs3.createEntity Ecs3.insertComponent Ecs3.a Ecs3.c
    , createABC = createAndInsert3 Ecs3.createEntity Ecs3.insertComponent Ecs3.a Ecs3.b Ecs3.c
    , iterateA = Ecs3.iterateEntitiesWithA (\_ _ x -> x) |> withContext
    , iterateAB = Ecs3.iterateEntitiesWithAB (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs3.iterateEntitiesWithABC (\_ _ _ _ x -> x) |> withContext
    }


ecs4 : EcsApi Ecs4.Ecs Ecs4.EntityId
ecs4 =
    { label = "Ecs4 record of arrays with nodes"
    , empty = Ecs4.empty
    , createA = createAndInsert Ecs4.createEntity Ecs4.insertComponent Ecs4.a
    , createB = createAndInsert Ecs4.createEntity Ecs4.insertComponent Ecs4.b
    , createC = createAndInsert Ecs4.createEntity Ecs4.insertComponent Ecs4.c
    , createAB = createAndInsert2 Ecs4.createEntity Ecs4.insertComponent Ecs4.a Ecs4.b
    , createAC = createAndInsert2 Ecs4.createEntity Ecs4.insertComponent Ecs4.a Ecs4.c
    , createABC = createAndInsert3 Ecs4.createEntity Ecs4.insertComponent Ecs4.a Ecs4.b Ecs4.c
    , iterateA = Ecs4.iterateEntitiesWithA (\_ _ x -> x) |> withContext
    , iterateAB = Ecs4.iterateEntitiesWithAB (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs4.iterateEntitiesWithABC (\_ _ _ _ x -> x) |> withContext
    }


ecs4b : EcsApi Ecs4b.Ecs Ecs4b.EntityId
ecs4b =
    { label = "Ecs4b record of arrays with nodes"
    , empty = Ecs4b.empty
    , createA = createAndInsert Ecs4b.create Ecs4b.insert Ecs4b.aComponent
    , createB = createAndInsert Ecs4b.create Ecs4b.insert Ecs4b.bComponent
    , createC = createAndInsert Ecs4b.create Ecs4b.insert Ecs4b.cComponent
    , createAB = createAndInsert2 Ecs4b.create Ecs4b.insert Ecs4b.aComponent Ecs4b.bComponent
    , createAC = createAndInsert2 Ecs4b.create Ecs4b.insert Ecs4b.aComponent Ecs4b.cComponent
    , createABC = createAndInsert3 Ecs4b.create Ecs4b.insert Ecs4b.aComponent Ecs4b.bComponent Ecs4b.cComponent
    , iterateA = Ecs4b.iterate Ecs4b.aNode (\_ _ x -> x) |> withContext
    , iterateAB = Ecs4b.iterate Ecs4b.abNode (\_ _ x -> x) |> withContext
    , iterateABC = Ecs4b.iterate Ecs4b.abcNode (\_ _ x -> x) |> withContext
    }


ecs5 : EcsApi Ecs5.Ecs Ecs5.EntityId
ecs5 =
    let
        emptyEntity =
            Ecs5.emptyEntity
    in
    { label = "Ecs5 array of records with nodes"
    , empty = Ecs5.empty
    , createA = Ecs5.insert { emptyEntity | a = Just () }
    , createB = Ecs5.insert { emptyEntity | b = Just () }
    , createC = Ecs5.insert { emptyEntity | c = Just () }
    , createAB = Ecs5.insert { emptyEntity | a = Just (), b = Just () }
    , createAC = Ecs5.insert { emptyEntity | a = Just (), c = Just () }
    , createABC = Ecs5.insert { emptyEntity | a = Just (), b = Just (), c = Just () }
    , iterateA = Ecs5.iterate Ecs5.aNode (\_ _ _ x -> x) |> withContext
    , iterateAB = Ecs5.iterate Ecs5.abNode (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs5.iterate Ecs5.abcNode (\_ _ _ x -> x) |> withContext
    }



-- HELPERS --


createAndInsert create insert componentType ecs =
    let
        ( newEcs, entityId ) =
            create ecs
    in
    ( insert entityId componentType () newEcs
    , entityId
    )


createAndInsert2 create insert componentType1 componentType2 ecs =
    let
        ( newEcs, entityId ) =
            create ecs
    in
    ( newEcs
        |> insert entityId componentType1 ()
        |> insert entityId componentType2 ()
    , entityId
    )


createAndInsert3 create insert componentType1 componentType2 componentType3 ecs =
    let
        ( newEcs, entityId ) =
            create ecs
    in
    ( newEcs
        |> insert entityId componentType1 ()
        |> insert entityId componentType2 ()
        |> insert entityId componentType3 ()
    , entityId
    )


withContext f ecs =
    f ( ecs, () ) |> Tuple.first
