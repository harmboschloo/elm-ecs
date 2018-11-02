module Apis exposing
    ( EcsApi
    , ecs1
    , ecs5
    , ecs6
    )

import Ecs1
import Ecs5
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


ecs5 : EcsApi Ecs5.Ecs
ecs5 =
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
    , iterateABModifyA = Ecs5.iterateAndUpdate Ecs5.abNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent ()) ecs, x )) |> withContext
    , iterateABCModifyA = Ecs5.iterateAndUpdate Ecs5.abcNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent ()) ecs, x )) |> withContext
    , iterateAModifyAB = Ecs5.iterateAndUpdate Ecs5.aNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent () |> Ecs5.insert Ecs5.bComponent ()) ecs, x )) |> withContext
    , iterateAModifyABC = Ecs5.iterateAndUpdate Ecs5.aNode (\update _ ( ecs, x ) -> ( Ecs5.apply (update |> Ecs5.insert Ecs5.aComponent () |> Ecs5.insert Ecs5.bComponent () |> Ecs5.insert Ecs5.cComponent ()) ecs, x )) |> withContext
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


withContext f ecs =
    f ( ecs, () ) |> Tuple.first


withContext2 f ecs =
    f ecs () |> always ecs
