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
    , createBC : ecs -> ( ecs, entityId )
    , createABC : ecs -> ( ecs, entityId )
    , iterateA : ecs -> ecs
    , iterateAB : ecs -> ecs
    , iterateABC : ecs -> ecs
    , iterateAModifyA : ecs -> ecs
    , iterateABModifyA : ecs -> ecs
    , iterateABCModifyA : ecs -> ecs
    , iterateAModifyAB : ecs -> ecs
    , iterateAModifyABC : ecs -> ecs
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
    , createBC = createAndInsert2 Ecs1.createEntity Ecs1.insertComponent Ecs1.b Ecs1.c
    , createABC = createAndInsert3 Ecs1.createEntity Ecs1.insertComponent Ecs1.a Ecs1.b Ecs1.c
    , iterateA = Ecs1.iterateEntities Ecs1.a (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1.iterateEntities2 Ecs1.a Ecs1.b (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs1.iterateEntities3 Ecs1.a Ecs1.b Ecs1.c (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs1.iterateEntities Ecs1.a (\entityId _ -> insert (Ecs1.insertComponent entityId) Ecs1.a) |> withContext
    , iterateABModifyA = Ecs1.iterateEntities2 Ecs1.a Ecs1.b (\entityId _ _ -> insert (Ecs1.insertComponent entityId) Ecs1.a) |> withContext
    , iterateABCModifyA = Ecs1.iterateEntities3 Ecs1.a Ecs1.b Ecs1.c (\entityId _ _ _ -> insert (Ecs1.insertComponent entityId) Ecs1.a) |> withContext
    , iterateAModifyAB = Ecs1.iterateEntities Ecs1.a (\entityId _ -> insert (Ecs1.insertComponent entityId) Ecs1.a >> insert (Ecs1.insertComponent entityId) Ecs1.b) |> withContext
    , iterateAModifyABC = Ecs1.iterateEntities Ecs1.a (\entityId _ -> insert (Ecs1.insertComponent entityId) Ecs1.a >> insert (Ecs1.insertComponent entityId) Ecs1.b >> insert (Ecs1.insertComponent entityId) Ecs1.c) |> withContext
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
    , createBC = createAndInsert2 Ecs2.createEntity Ecs2.insertComponent Ecs2.b Ecs2.c
    , createABC = createAndInsert3 Ecs2.createEntity Ecs2.insertComponent Ecs2.a Ecs2.b Ecs2.c
    , iterateA = Ecs2.iterateEntities Ecs2.a (\_ _ x -> x) |> withContext
    , iterateAB = Ecs2.iterateEntities2 Ecs2.a Ecs2.b (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs2.iterateEntities3 Ecs2.a Ecs2.b Ecs2.c (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs2.iterateEntities Ecs2.a (\entityId _ -> insert (Ecs2.insertComponent entityId) Ecs2.a) |> withContext
    , iterateABModifyA = Ecs2.iterateEntities2 Ecs2.a Ecs2.b (\entityId _ _ -> insert (Ecs2.insertComponent entityId) Ecs2.a) |> withContext
    , iterateABCModifyA = Ecs2.iterateEntities3 Ecs2.a Ecs2.b Ecs2.c (\entityId _ _ _ -> insert (Ecs2.insertComponent entityId) Ecs2.a) |> withContext
    , iterateAModifyAB = Ecs2.iterateEntities Ecs2.a (\entityId _ -> insert (Ecs2.insertComponent entityId) Ecs2.a >> insert (Ecs2.insertComponent entityId) Ecs2.b) |> withContext
    , iterateAModifyABC = Ecs2.iterateEntities Ecs2.a (\entityId _ -> insert (Ecs2.insertComponent entityId) Ecs2.a >> insert (Ecs2.insertComponent entityId) Ecs2.b >> insert (Ecs2.insertComponent entityId) Ecs2.c) |> withContext
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
    , createBC = createAndInsert2 Ecs3.createEntity Ecs3.insertComponent Ecs3.b Ecs3.c
    , createABC = createAndInsert3 Ecs3.createEntity Ecs3.insertComponent Ecs3.a Ecs3.b Ecs3.c
    , iterateA = Ecs3.iterateEntitiesWithA (\_ _ x -> x) |> withContext
    , iterateAB = Ecs3.iterateEntitiesWithAB (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs3.iterateEntitiesWithABC (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs3.iterateEntitiesWithA (\entityId _ -> insert (Ecs3.insertComponent entityId) Ecs3.a) |> withContext
    , iterateABModifyA = Ecs3.iterateEntitiesWithAB (\entityId _ _ -> insert (Ecs3.insertComponent entityId) Ecs3.a) |> withContext
    , iterateABCModifyA = Ecs3.iterateEntitiesWithABC (\entityId _ _ _ -> insert (Ecs3.insertComponent entityId) Ecs3.a) |> withContext
    , iterateAModifyAB = Ecs3.iterateEntitiesWithA (\entityId _ -> insert (Ecs3.insertComponent entityId) Ecs3.a >> insert (Ecs3.insertComponent entityId) Ecs3.b) |> withContext
    , iterateAModifyABC = Ecs3.iterateEntitiesWithA (\entityId _ -> insert (Ecs3.insertComponent entityId) Ecs3.a >> insert (Ecs3.insertComponent entityId) Ecs3.b >> insert (Ecs3.insertComponent entityId) Ecs3.c) |> withContext
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
    , createBC = createAndInsert2 Ecs4.createEntity Ecs4.insertComponent Ecs4.b Ecs4.c
    , createABC = createAndInsert3 Ecs4.createEntity Ecs4.insertComponent Ecs4.a Ecs4.b Ecs4.c
    , iterateA = Ecs4.iterateEntitiesWithA (\_ _ x -> x) |> withContext
    , iterateAB = Ecs4.iterateEntitiesWithAB (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs4.iterateEntitiesWithABC (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs4.iterateEntitiesWithA (\entityId _ -> insert (Ecs4.insertComponent entityId) Ecs4.a) |> withContext
    , iterateABModifyA = Ecs4.iterateEntitiesWithAB (\entityId _ _ -> insert (Ecs4.insertComponent entityId) Ecs4.a) |> withContext
    , iterateABCModifyA = Ecs4.iterateEntitiesWithABC (\entityId _ _ _ -> insert (Ecs4.insertComponent entityId) Ecs4.a) |> withContext
    , iterateAModifyAB = Ecs4.iterateEntitiesWithA (\entityId _ -> insert (Ecs4.insertComponent entityId) Ecs4.a >> insert (Ecs4.insertComponent entityId) Ecs4.b) |> withContext
    , iterateAModifyABC = Ecs4.iterateEntitiesWithA (\entityId _ -> insert (Ecs4.insertComponent entityId) Ecs4.a >> insert (Ecs4.insertComponent entityId) Ecs4.b >> insert (Ecs4.insertComponent entityId) Ecs4.c) |> withContext
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
    , createBC = createAndInsert2 Ecs4b.create Ecs4b.insert Ecs4b.bComponent Ecs4b.cComponent
    , createABC = createAndInsert3 Ecs4b.create Ecs4b.insert Ecs4b.aComponent Ecs4b.bComponent Ecs4b.cComponent
    , iterateA = Ecs4b.iterate Ecs4b.aNode (\_ _ x -> x) |> withContext
    , iterateAB = Ecs4b.iterate Ecs4b.abNode (\_ _ x -> x) |> withContext
    , iterateABC = Ecs4b.iterate Ecs4b.abcNode (\_ _ x -> x) |> withContext
    , iterateAModifyA = Ecs4b.iterate Ecs4b.aNode (\entityId _ -> insert (Ecs4b.insert entityId) Ecs4b.aComponent) |> withContext
    , iterateABModifyA = Ecs4b.iterate Ecs4b.abNode (\entityId _ -> insert (Ecs4b.insert entityId) Ecs4b.aComponent) |> withContext
    , iterateABCModifyA = Ecs4b.iterate Ecs4b.abcNode (\entityId _ -> insert (Ecs4b.insert entityId) Ecs4b.aComponent) |> withContext
    , iterateAModifyAB = Ecs4b.iterate Ecs4b.aNode (\entityId _ -> insert (Ecs4b.insert entityId) Ecs4b.aComponent >> insert (Ecs4b.insert entityId) Ecs4b.bComponent) |> withContext
    , iterateAModifyABC = Ecs4b.iterate Ecs4b.aNode (\entityId _ -> insert (Ecs4b.insert entityId) Ecs4b.aComponent >> insert (Ecs4b.insert entityId) Ecs4b.bComponent >> insert (Ecs4b.insert entityId) Ecs4b.cComponent) |> withContext
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
    , createBC = Ecs5.insert { emptyEntity | b = Just (), c = Just () }
    , createABC = Ecs5.insert { emptyEntity | a = Just (), b = Just (), c = Just () }
    , iterateA = Ecs5.iterate Ecs5.aNode (\_ _ _ x -> x) |> withContext
    , iterateAB = Ecs5.iterate Ecs5.abNode (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs5.iterate Ecs5.abcNode (\_ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateABModifyA = Ecs5.iterate Ecs5.abNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateABCModifyA = Ecs5.iterate Ecs5.abcNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateAModifyAB = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just (), b = Just () } ecs, x )) |> withContext
    , iterateAModifyABC = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just (), b = Just (), c = Just () } ecs, x )) |> withContext
    }



-- HELPERS --


createAndInsert createEntity insertComponent componentType ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    ( insertComponent entityId componentType () newEcs
    , entityId
    )


createAndInsert2 createEntity insertComponent componentType1 componentType2 ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    ( newEcs
        |> insertComponent entityId componentType1 ()
        |> insertComponent entityId componentType2 ()
    , entityId
    )


createAndInsert3 createEntity insertComponent componentType1 componentType2 componentType3 ecs =
    let
        ( newEcs, entityId ) =
            createEntity ecs
    in
    ( newEcs
        |> insertComponent entityId componentType1 ()
        |> insertComponent entityId componentType2 ()
        |> insertComponent entityId componentType3 ()
    , entityId
    )


insert insertComponent componentType ( ecs, x ) =
    ( insertComponent componentType () ecs
    , x
    )


insert2 insertComponent componentType1 componentType2 ( ecs, x ) =
    ( ecs
        |> insertComponent componentType1 ()
        |> insertComponent componentType2 ()
    , x
    )


insert3 insertComponent componentType1 componentType2 componentType3 ( ecs, x ) =
    ( ecs
        |> insertComponent componentType1 ()
        |> insertComponent componentType2 ()
        |> insertComponent componentType3 ()
    , x
    )


withContext f ecs =
    f ( ecs, () ) |> Tuple.first
