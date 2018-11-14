module Ecs8b.System exposing
    ( System
    , Update
    , create
    , destroy
    , process
    , processWithUpdate
    , system
    )

import Array
import Ecs8b.Entity exposing (EntityId)
import Ecs8b.Internal as Internal
    exposing
        ( Ecs(..)
        , Entity(..)
        , NodeSpec(..)
        , Status(..)
        )



-- SYSTEM --


type System components a
    = System (SystemModel components a)


type alias SystemModel components a =
    { preProcess : Maybe (( Ecs components, a ) -> ( Ecs components, a ))
    , process :
        Maybe
            (( Entity components, Update components, a )
             -> ( Entity components, Update components, a )
            )
    , postProcess : Maybe (( Ecs components, a ) -> ( Ecs components, a ))
    }


system :
    { preProcess : Maybe (Ecs components -> a -> ( Ecs components, a ))
    , process : Maybe (Process components a)
    , postProcess : Maybe (Ecs components -> a -> ( Ecs components, a ))
    }
    -> System components a
system config =
    System
        { preProcess = Maybe.map preOrPostProcess config.preProcess
        , process = Maybe.map (\(Process p) -> p) config.process
        , postProcess = Maybe.map preOrPostProcess config.postProcess
        }


preOrPostProcess :
    (Ecs components -> a -> ( Ecs components, a ))
    -> (( Ecs components, a ) -> ( Ecs components, a ))
preOrPostProcess processor =
    \( ecs, a ) -> processor ecs a



-- PROCESS --


type Process components a
    = Process
        (( Entity components, Update components, a )
         -> ( Entity components, Update components, a )
        )


process :
    NodeSpec components node
    -> (node -> Entity components -> a -> ( Entity components, a ))
    -> Process components a
process (NodeSpec spec) processor =
    Process
        (\( (Entity _ components _) as entity1, update, a1 ) ->
            case spec.getNode components of
                Nothing ->
                    ( entity1, update, a1 )

                Just node ->
                    let
                        ( entity2, a2 ) =
                            processor node entity1 a1
                    in
                    ( entity2, update, a2 )
        )


processWithUpdate :
    NodeSpec components node
    ->
        (node
         -> Entity components
         -> Update components
         -> a
         -> ( Entity components, Update components, a )
        )
    -> Process components a
processWithUpdate (NodeSpec spec) processor =
    Process
        (\( (Entity _ components _) as entity, update, a ) ->
            case spec.getNode components of
                Nothing ->
                    ( entity, update, a )

                Just node ->
                    processor node entity update a
        )



-- UPDATE --


type Update components
    = Update
        { create : List (Entity components -> Entity components)
        , destroy : List EntityId
        }


empty : Update components
empty =
    Update
        { create = []
        , destroy = []
        }


create :
    (Entity components -> Entity components)
    -> Update components
    -> Update components
create creator (Update update) =
    Update
        { create = creator :: update.create
        , destroy = update.destroy
        }


destroy : EntityId -> Update components -> Update components
destroy entityId (Update update) =
    Update
        { create = update.create
        , destroy = entityId :: update.destroy
        }


processEntities :
    List (System components a)
    -> ( Ecs components, a )
    -> ( Ecs components, a )
processEntities systems ( ecs1, a1 ) =
    let
        doPreProcess =
            compose .preProcess systems

        doProcess =
            compose .process systems

        doPostProcess =
            compose .postProcess systems

        ( (Ecs model2) as ecs2, a2 ) =
            doPreProcess ( ecs1, a1 )

        ( _, ecs3, a3 ) =
            Array.foldl
                (\components state -> processEntity doProcess components state)
                ( 0, ecs2, a2 )
                model2.entities

        ( ecs4, a4 ) =
            doPostProcess ( ecs3, a3 )
    in
    ( ecs4, a4 )


compose :
    (SystemModel components a -> (b -> b))
    -> List (System components a)
    -> (b -> b)
compose getter list =
    list
        |> List.map (\(System model) -> getter model)
        |> List.foldl (<<) identity


processEntity :
    (( Entity components, a ) -> ( Entity components, a ))
    -> Maybe components
    -> ( Int, Ecs components, a )
    -> ( Int, Ecs components, a )
processEntity doProcess maybeComponents ( index, ecs, a ) =
    case maybeComponents of
        Nothing ->
            ( index + 1, ecs, a )

        Just components ->
            let
                ( newEntity, newX ) =
                    doProcess
                        ( Entity index components Unmodified
                        , a
                        )
            in
            ( index + 1, insert newEntity ecs, newX )
