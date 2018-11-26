module Ecs.AR exposing
    ( Ecs, empty, fromList, toList, size, isEmpty
    , EntityId, create, destroy
    , member, get, set, update
    , process, processSystems
    , map, fold
    )

{-|


# The a structure.

@docs Ecs, empty, fromList, toList, size, isEmpty


# Creating and destroying entities.

@docs EntityId, create, destroy


# Querying and updating entities.

@docs member, get, set, update


# Processing

@docs process, processSystems


# Transforming

@docs map, fold

-}

import Array exposing (Array)
import Ecs.AR.Internal.Ecs as Ecs exposing (Model, ProcessState)
import Ecs.AR.Internal.Entity as Entity exposing (Entity, Id, Index)
import Ecs.AR.Internal.Process as Process exposing (Process(..))
import Ecs.AR.Internal.System exposing (System(..), SystemModel)



-- TYPES --


{-| -}
type alias Ecs a =
    Ecs.Ecs a


{-| -}
type alias EntityId =
    Entity.EntityId



-- MODEL --


{-| -}
empty : Ecs a
empty =
    fromArray Array.empty


fromArray : Array (Entity a) -> Ecs a
fromArray entities =
    Ecs.Ecs
        { all = entities
        , nextId = Array.length entities
        , destroyed = []
        }


{-| -}
fromList : List a -> Ecs a
fromList entities =
    fromArray
        (entities
            |> List.indexedMap Entity.Exists
            |> Array.fromList
        )


{-| -}
toList : Ecs a -> List a
toList (Ecs.Ecs model) =
    model.all
        |> Array.toList
        |> List.filterMap entityToMaybe


entityToMaybe : Entity a -> Maybe a
entityToMaybe entity =
    case entity of
        Entity.Exists _ a ->
            Just a

        Entity.Destroyed ->
            Nothing


{-| -}
size : Ecs a -> Int
size (Ecs.Ecs model) =
    Array.length model.all - List.length model.destroyed


{-| -}
isEmpty : Ecs a -> Bool
isEmpty ecs =
    size ecs == 0


{-| -}
map : (a -> b) -> Ecs a -> Ecs b
map fn (Ecs.Ecs model) =
    Ecs.Ecs
        { all =
            Array.map
                (\entity ->
                    case entity of
                        Entity.Exists id a ->
                            Entity.Exists id (fn a)

                        Entity.Destroyed ->
                            Entity.Destroyed
                )
                model.all
        , nextId = model.nextId
        , destroyed = model.destroyed
        }


{-| -}
fold : (a -> b -> b) -> b -> Ecs a -> b
fold fn b0 (Ecs.Ecs model) =
    Array.foldl
        (\entity b ->
            case entity of
                Entity.Exists id a ->
                    fn a b

                Entity.Destroyed ->
                    b
        )
        b0
        model.all


{-| -}
process : (Process a -> b -> ( Process a, b )) -> Ecs a -> b -> ( Ecs a, b )
process fn (Ecs.Ecs model) b =
    let
        ( _, state ) =
            Array.foldl
                (processEntity fn)
                ( 0
                , { ecs = Ecs.Ecs model
                  , b = b
                  , update = []
                  }
                )
                model.all

        ecs2 =
            List.foldl
                (\( entityId, updateFn ) ecs -> update entityId updateFn ecs)
                state.ecs
                state.update
    in
    ( ecs2, state.b )


processEntity :
    (Process a -> b -> ( Process a, b ))
    -> Entity a
    -> ( Index, ProcessState a b )
    -> ( Index, ProcessState a b )
processEntity fn entity ( index, state ) =
    case entity of
        Entity.Destroyed ->
            ( index + 1, state )

        Entity.Exists id a ->
            let
                entityId =
                    Entity.EntityId id index

                process1 =
                    Process
                        { ecs = state.ecs
                        , current =
                            { id = entityId
                            , a = a
                            , status = Process.NotModified
                            }
                        , update = state.update
                        }

                ( Process process2, b2 ) =
                    fn process1 state.b

                { current } =
                    process2

                ecs2 =
                    case current.status of
                        Process.NotModified ->
                            process2.ecs

                        Process.Modified ->
                            set current.id current.a process2.ecs

                        Process.Destroyed ->
                            destroy current.id process2.ecs
            in
            ( index + 1
            , { ecs = ecs2
              , b = b2
              , update = process2.update
              }
            )


{-| -}
processSystems : List (System a b) -> Ecs a -> b -> ( Ecs a, b )
processSystems systems ecs1 b1 =
    let
        doPreProcess =
            compose .preProcess systems

        systemsToProcess =
            List.filterMap (\(System system) -> system.process) systems

        doPostProcess =
            compose .postProcess systems

        ( ecs2, b2 ) =
            doPreProcess ( ecs1, b1 )

        ( ecs3, b3 ) =
            process (doProcessSystems systemsToProcess) ecs2 b2
    in
    doPostProcess ( ecs3, b3 )


doProcessSystems :
    List (Process a -> b -> ( Process a, b ))
    -> Process a
    -> b
    -> ( Process a, b )
doProcessSystems processors process1 b1 =
    case processors of
        [] ->
            ( process1, b1 )

        processor :: nextProcessors ->
            let
                ( Process process2, b2 ) =
                    processor process1 b1
            in
            case process2.current.status of
                Process.Destroyed ->
                    ( Process process2, b2 )

                _ ->
                    doProcessSystems
                        nextProcessors
                        (Process process2)
                        b2


compose :
    (SystemModel a b -> Maybe (( Ecs a, b ) -> ( Ecs a, b )))
    -> List (System a b)
    -> (( Ecs a, b ) -> ( Ecs a, b ))
compose getter systems =
    case List.filterMap (\(System model) -> getter model) systems of
        [] ->
            identity

        head :: tail ->
            List.foldl (<<) head tail



-- ENTITIES --


{-| -}
create : a -> Ecs a -> ( EntityId, Ecs a )
create a (Ecs.Ecs model) =
    let
        id =
            model.nextId

        entity =
            Entity.Exists id a

        ( index, all, destroyed ) =
            case model.destroyed of
                [] ->
                    ( Array.length model.all
                    , Array.push entity model.all
                    , []
                    )

                head :: tail ->
                    ( head
                    , Array.set head entity model.all
                    , tail
                    )

        entityId =
            Entity.EntityId id index
    in
    ( entityId
    , Ecs.Ecs
        { all = all
        , nextId = id + 1
        , destroyed = destroyed
        }
    )


{-| -}
destroy : EntityId -> Ecs a -> Ecs a
destroy (Entity.EntityId id index) (Ecs.Ecs model) =
    getWith
        (\a ->
            Ecs.Ecs
                { all = Array.set index Entity.Destroyed model.all
                , nextId = model.nextId
                , destroyed = index :: model.destroyed
                }
        )
        (Ecs.Ecs model)
        id
        index
        model


{-| -}
member : EntityId -> Ecs a -> Bool
member (Entity.EntityId id index) (Ecs.Ecs model) =
    getWith (\_ -> True) False id index model


{-| -}
get : EntityId -> Ecs a -> Maybe a
get (Entity.EntityId id index) (Ecs.Ecs model) =
    getWith Just Nothing id index model


{-| -}
set : EntityId -> a -> Ecs a -> Ecs a
set (Entity.EntityId id index) a (Ecs.Ecs model) =
    getWith
        (\_ ->
            Ecs.Ecs
                { all = Array.set index (Entity.Exists id a) model.all
                , nextId = model.nextId
                , destroyed = model.destroyed
                }
        )
        (Ecs.Ecs model)
        id
        index
        model


{-| -}
update : EntityId -> (a -> a) -> Ecs a -> Ecs a
update (Entity.EntityId id index) fn (Ecs.Ecs model) =
    getWith
        (\a ->
            Ecs.Ecs
                { all = Array.set index (Entity.Exists id (fn a)) model.all
                , nextId = model.nextId
                , destroyed = model.destroyed
                }
        )
        (Ecs.Ecs model)
        id
        index
        model


getWith : (a -> b) -> b -> Id -> Index -> Model a -> b
getWith withValue withoutValue id index model =
    case Array.get index model.all of
        Just (Entity.Exists dataId a) ->
            if id == dataId then
                withValue a

            else
                withoutValue

        _ ->
            withoutValue
