module Apis exposing
    ( EcsApi
    , ecs1
    , ecs1b
    , ecs2
    , ecs3
    , ecs4
    , ecs4b
    , ecs5
    , ecs5b
    , ecs6
    )

import Ecs1
import Ecs1b
import Ecs2
import Ecs3
import Ecs4
import Ecs4b
import Ecs5
import Ecs5b
import Ecs6



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
    }


ecs1 : EcsApi Ecs1.Ecs
ecs1 =
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
    , iterateABModifyA = Ecs1.iterate2 Ecs1.aComponent Ecs1.bComponent (\entityId _ _ -> insert (Ecs1.insert entityId) Ecs1.aComponent) |> withContext
    , iterateABCModifyA = Ecs1.iterate3 Ecs1.aComponent Ecs1.bComponent Ecs1.cComponent (\entityId _ _ _ -> insert (Ecs1.insert entityId) Ecs1.aComponent) |> withContext
    , iterateAModifyAB = Ecs1.iterate Ecs1.aComponent (\entityId _ -> insert (Ecs1.insert entityId) Ecs1.aComponent >> insert (Ecs1.insert entityId) Ecs1.bComponent) |> withContext
    , iterateAModifyABC = Ecs1.iterate Ecs1.aComponent (\entityId _ -> insert (Ecs1.insert entityId) Ecs1.aComponent >> insert (Ecs1.insert entityId) Ecs1.bComponent >> insert (Ecs1.insert entityId) Ecs1.cComponent) |> withContext
    }


ecs1b : EcsApi Ecs1b.Ecs
ecs1b =
    { label = "Ecs1b record of dicts"
    , empty = Ecs1b.empty
    , createA = createAndInsert Ecs1b.create Ecs1b.insert Ecs1b.aComponent
    , createB = createAndInsert Ecs1b.create Ecs1b.insert Ecs1b.bComponent
    , createC = createAndInsert Ecs1b.create Ecs1b.insert Ecs1b.cComponent
    , createAB = createAndInsert2 Ecs1b.create Ecs1b.insert Ecs1b.aComponent Ecs1b.bComponent
    , createAC = createAndInsert2 Ecs1b.create Ecs1b.insert Ecs1b.aComponent Ecs1b.cComponent
    , createBC = createAndInsert2 Ecs1b.create Ecs1b.insert Ecs1b.bComponent Ecs1b.cComponent
    , createABC = createAndInsert3 Ecs1b.create Ecs1b.insert Ecs1b.aComponent Ecs1b.bComponent Ecs1b.cComponent
    , iterateA = Ecs1b.iterate Ecs1b.aComponent (\_ _ x -> x) |> withContext
    , iterateAB = Ecs1b.iterate2 Ecs1b.aComponent Ecs1b.bComponent (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs1b.iterate3 Ecs1b.aComponent Ecs1b.bComponent Ecs1b.cComponent (\_ _ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs1b.iterate Ecs1b.aComponent (\entityId _ -> insert (Ecs1b.insert entityId) Ecs1b.aComponent) |> withContext
    , iterateABModifyA = Ecs1b.iterate2 Ecs1b.aComponent Ecs1b.bComponent (\entityId _ _ -> insert (Ecs1b.insert entityId) Ecs1b.aComponent) |> withContext
    , iterateABCModifyA = Ecs1b.iterate3 Ecs1b.aComponent Ecs1b.bComponent Ecs1b.cComponent (\entityId _ _ _ -> insert (Ecs1b.insert entityId) Ecs1b.aComponent) |> withContext
    , iterateAModifyAB = Ecs1b.iterate Ecs1b.aComponent (\entityId _ -> insert (Ecs1b.insert entityId) Ecs1b.aComponent >> insert (Ecs1b.insert entityId) Ecs1b.bComponent) |> withContext
    , iterateAModifyABC = Ecs1b.iterate Ecs1b.aComponent (\entityId _ -> insert (Ecs1b.insert entityId) Ecs1b.aComponent >> insert (Ecs1b.insert entityId) Ecs1b.bComponent >> insert (Ecs1b.insert entityId) Ecs1b.cComponent) |> withContext
    }


ecs2 : EcsApi Ecs2.Ecs
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


ecs3 : EcsApi Ecs3.Ecs
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


ecs4 : EcsApi Ecs4.Ecs
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


ecs4b : EcsApi Ecs4b.Ecs
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


ecs5 : EcsApi Ecs5.Ecs
ecs5 =
    let
        emptyEntity =
            Ecs5.emptyEntity
    in
    { label = "Ecs5 array of records with nodes"
    , empty = Ecs5.empty
    , createA = Ecs5.insert { emptyEntity | a = Just () } >> Tuple.first
    , createB = Ecs5.insert { emptyEntity | b = Just () } >> Tuple.first
    , createC = Ecs5.insert { emptyEntity | c = Just () } >> Tuple.first
    , createAB = Ecs5.insert { emptyEntity | a = Just (), b = Just () } >> Tuple.first
    , createAC = Ecs5.insert { emptyEntity | a = Just (), c = Just () } >> Tuple.first
    , createBC = Ecs5.insert { emptyEntity | b = Just (), c = Just () } >> Tuple.first
    , createABC = Ecs5.insert { emptyEntity | a = Just (), b = Just (), c = Just () } >> Tuple.first
    , iterateA = Ecs5.iterate Ecs5.aNode (\_ _ _ x -> x) |> withContext
    , iterateAB = Ecs5.iterate Ecs5.abNode (\_ _ _ x -> x) |> withContext
    , iterateABC = Ecs5.iterate Ecs5.abcNode (\_ _ _ x -> x) |> withContext
    , iterateAModifyA = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateABModifyA = Ecs5.iterate Ecs5.abNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateABCModifyA = Ecs5.iterate Ecs5.abcNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just () } ecs, x )) |> withContext
    , iterateAModifyAB = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just (), b = Just () } ecs, x )) |> withContext
    , iterateAModifyABC = Ecs5.iterate Ecs5.aNode (\entityId entity _ ( ecs, x ) -> ( Ecs5.set entityId { entity | a = Just (), b = Just (), c = Just () } ecs, x )) |> withContext
    }


ecs5b : EcsApi Ecs5b.Ecs
ecs5b =
    { label = "Ecs5b array of records with nodes"
    , empty = Ecs5b.empty
    , createA = Ecs5b.create (Ecs5b.insert Ecs5b.aComponent ())
    , createB = Ecs5b.create (Ecs5b.insert Ecs5b.bComponent ())
    , createC = Ecs5b.create (Ecs5b.insert Ecs5b.cComponent ())
    , createAB = Ecs5b.create (Ecs5b.insert Ecs5b.aComponent () >> Ecs5b.insert Ecs5b.bComponent ())
    , createAC = Ecs5b.create (Ecs5b.insert Ecs5b.aComponent () >> Ecs5b.insert Ecs5b.cComponent ())
    , createBC = Ecs5b.create (Ecs5b.insert Ecs5b.bComponent () >> Ecs5b.insert Ecs5b.cComponent ())
    , createABC = Ecs5b.create (Ecs5b.insert Ecs5b.aComponent () >> Ecs5b.insert Ecs5b.bComponent () >> Ecs5b.insert Ecs5b.cComponent ())
    , iterateA = Ecs5b.iterate Ecs5b.aNode (\_ _ _ x -> x) |> withContext2
    , iterateAB = Ecs5b.iterate Ecs5b.abNode (\_ _ _ x -> x) |> withContext2
    , iterateABC = Ecs5b.iterate Ecs5b.abcNode (\_ _ _ x -> x) |> withContext2
    , iterateAModifyA = Ecs5b.iterateAndUpdate Ecs5b.aNode (\update _ ( ecs, x ) -> ( Ecs5b.apply (update |> Ecs5b.insert Ecs5b.aComponent ()) ecs, x )) |> withContext
    , iterateABModifyA = Ecs5b.iterateAndUpdate Ecs5b.abNode (\update _ ( ecs, x ) -> ( Ecs5b.apply (update |> Ecs5b.insert Ecs5b.aComponent ()) ecs, x )) |> withContext
    , iterateABCModifyA = Ecs5b.iterateAndUpdate Ecs5b.abcNode (\update _ ( ecs, x ) -> ( Ecs5b.apply (update |> Ecs5b.insert Ecs5b.aComponent ()) ecs, x )) |> withContext
    , iterateAModifyAB = Ecs5b.iterateAndUpdate Ecs5b.aNode (\update _ ( ecs, x ) -> ( Ecs5b.apply (update |> Ecs5b.insert Ecs5b.aComponent () |> Ecs5b.insert Ecs5b.bComponent ()) ecs, x )) |> withContext
    , iterateAModifyABC = Ecs5b.iterateAndUpdate Ecs5b.aNode (\update _ ( ecs, x ) -> ( Ecs5b.apply (update |> Ecs5b.insert Ecs5b.aComponent () |> Ecs5b.insert Ecs5b.bComponent () |> Ecs5b.insert Ecs5b.cComponent ()) ecs, x )) |> withContext
    }


ecs6 : EcsApi Ecs6.Ecs
ecs6 =
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
    , iterateABModifyA = Ecs6.iterate Ecs6.abNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent) |> withContext
    , iterateABCModifyA = Ecs6.iterate Ecs6.abcNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent) |> withContext
    , iterateAModifyAB = Ecs6.iterate Ecs6.aNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent >> insert (Ecs6.insert entityId) Ecs6.bComponent) |> withContext
    , iterateAModifyABC = Ecs6.iterate Ecs6.aNode (\entityId _ -> insert (Ecs6.insert entityId) Ecs6.aComponent >> insert (Ecs6.insert entityId) Ecs6.bComponent >> insert (Ecs6.insert entityId) Ecs6.cComponent) |> withContext
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


withContext2 f ecs =
    f ecs () |> always ecs
