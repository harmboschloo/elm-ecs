module Ecs7 exposing
    ( Ecs, empty
    , EntityId, Entity, emptyEntity, create, destroy, reset, get, set, size, activeSize, idToInt, intToId
    , NodeSpec, updateAll, viewAll
    , ANode, AbNode, AbcNode
    , aNode, abNode, abcNode
    )

{-| Your Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, Entity, emptyEntity, create, destroy, reset, get, set, size, activeSize, idToInt, intToId


# Nodes

@docs NodeSpec, updateAll, viewAll


# Your Component Types

@docs aComponent, bComponent, cComponent


# Your Nodes

@docs ANode, AbNode, AbcNode


# Your Node Types

@docs aNode, abNode, abcNode

-}

import Array
import Components
import Set



-- MODEL --


{-| -}
type Ecs
    = Ecs Model


type alias Model =
    { entities : Array.Array Entity
    , destroyedEntitiesCache : List Int
    }


{-| -}
empty : Ecs
empty =
    Ecs
        { entities = Array.empty
        , destroyedEntitiesCache = []
        }



-- ENTITIES --


{-| -}
type EntityId
    = EntityId Int


type alias Entity =
    { a : Maybe Components.A
    , b : Maybe Components.B
    , c : Maybe Components.B
    }


emptyEntity : Entity
emptyEntity =
    { a = Nothing
    , b = Nothing
    , c = Nothing
    }


{-| -}
create : Entity -> Ecs -> ( Ecs, EntityId )
create entity (Ecs model) =
    case model.destroyedEntitiesCache of
        [] ->
            ( Ecs
                { entities = Array.push entity model.entities
                , destroyedEntitiesCache = model.destroyedEntitiesCache
                }
            , EntityId (entitiesSize model)
            )

        head :: tail ->
            ( Ecs
                { entities = Array.set head entity model.entities
                , destroyedEntitiesCache = tail
                }
            , EntityId head
            )


{-| -}
destroy : EntityId -> Ecs -> Ecs
destroy (EntityId entityId) (Ecs model) =
    Ecs
        { entities = Array.set entityId emptyEntity model.entities
        , destroyedEntitiesCache = entityId :: model.destroyedEntitiesCache
        }


{-| -}
reset : EntityId -> Ecs -> Ecs
reset (EntityId entityId) (Ecs model) =
    Ecs
        { entities = Array.set entityId emptyEntity model.entities
        , destroyedEntitiesCache = model.destroyedEntitiesCache
        }


{-| -}
get : EntityId -> Ecs -> Entity
get (EntityId entityId) (Ecs model) =
    getEntity entityId model


getEntity : Int -> Model -> Entity
getEntity entityId model =
    Array.get entityId model.entities |> Maybe.withDefault emptyEntity


{-| -}
set : EntityId -> Entity -> Ecs -> Ecs
set (EntityId entityId) entity (Ecs model) =
    Ecs
        { entities = Array.set entityId entity model.entities
        , destroyedEntitiesCache = model.destroyedEntitiesCache
        }


{-| -}
update : EntityId -> (Entity -> Entity) -> Ecs -> Ecs
update (EntityId entityId) updater (Ecs model) =
    Ecs
        { entities =
            Array.set
                entityId
                (getEntity entityId model |> updater)
                model.entities
        , destroyedEntitiesCache = model.destroyedEntitiesCache
        }


{-| -}
size : Ecs -> Int
size (Ecs model) =
    entitiesSize model


{-| -}
activeSize : Ecs -> Int
activeSize (Ecs model) =
    entitiesSize model - List.length model.destroyedEntitiesCache


entitiesSize : Model -> Int
entitiesSize model =
    Array.length model.entities


{-| -}
idToInt : EntityId -> Int
idToInt (EntityId entityId) =
    entityId


{-| -}
intToId : Int -> Ecs -> Maybe EntityId
intToId entityId ecs =
    if entityId < size ecs then
        Just (EntityId entityId)

    else
        Nothing



-- ITERATE NODES --


type NodeSpec x
    = NodeSpec (NodeCallback x)


type alias NodeCallback x =
    EntityId -> ( Entity, Ecs, x ) -> ( Entity, Ecs, x )


{-| -}
updateAll : List (NodeSpec x) -> ( Ecs, x ) -> ( Ecs, x )
updateAll specs ( Ecs model, x ) =
    let
        ( _, ecs2, x2 ) =
            Array.foldl
                (updateCallbacks specs)
                ( 0, Ecs model, x )
                model.entities
    in
    ( ecs2, x2 )


updateCallbacks :
    List (NodeSpec x)
    -> Entity
    -> ( Int, Ecs, x )
    -> ( Int, Ecs, x )
updateCallbacks specs entity ( entityId, ecs, x ) =
    let
        ( entity2, ecs2, x2 ) =
            List.foldl
                (\(NodeSpec callback) -> callback (EntityId entityId))
                ( entity, ecs, x )
                specs
    in
    -- TODO maybe we don't need to set always
    ( entityId + 1, set (EntityId entityId) entity2 ecs2, x2 )


{-| -}
viewAll : List (NodeSpec x) -> ( Ecs, x ) -> ( Ecs, x )
viewAll specs ( Ecs model, x ) =
    let
        ( _, ecs2, x2 ) =
            Array.foldl
                (viewCallbacks specs)
                ( 0, Ecs model, x )
                model.entities
    in
    ( ecs2, x2 )


viewCallbacks :
    List (NodeSpec x)
    -> Entity
    -> ( Int, Ecs, x )
    -> ( Int, Ecs, x )
viewCallbacks specs entity ( entityId, ecs, x ) =
    let
        ( _, _, x2 ) =
            List.foldl
                (\(NodeSpec callback) -> callback (EntityId entityId))
                ( entity, ecs, x )
                specs
    in
    ( entityId + 1, ecs, x2 )



-- YOUR NODES --


{-| -}
type alias ANode =
    { a : Components.A
    }


{-| -}
type alias AbNode =
    { a : Components.A
    , b : Components.B
    }


{-| -}
type alias AbcNode =
    { a : Components.A
    , b : Components.B
    , c : Components.C
    }



-- YOUR NODE TYPES --


applyNode :
    (EntityId -> node -> ( Entity, Ecs, x ) -> ( Entity, Ecs, x ))
    -> EntityId
    -> ( Entity, Ecs, x )
    -> Maybe node
    -> ( Entity, Ecs, x )
applyNode callback entityId state maybeNode =
    case maybeNode of
        Just node ->
            callback entityId node state

        Nothing ->
            state


{-| -}
aNode :
    (EntityId -> ANode -> ( Entity, Ecs, x ) -> ( Entity, Ecs, x ))
    -> NodeSpec x
aNode callback =
    NodeSpec
        (\entityId ( entity, ecs, x ) ->
            entity.a
                |> Maybe.map ANode
                |> applyNode callback entityId ( entity, ecs, x )
        )


{-| -}
abNode :
    (EntityId -> AbNode -> ( Entity, Ecs, x ) -> ( Entity, Ecs, x ))
    -> NodeSpec x
abNode callback =
    NodeSpec
        (\entityId ( entity, ecs, x ) ->
            entity.a
                |> Maybe.map AbNode
                |> maybeAndMap entity.b
                |> applyNode callback entityId ( entity, ecs, x )
        )


{-| -}
abcNode :
    (EntityId -> AbcNode -> ( Entity, Ecs, x ) -> ( Entity, Ecs, x ))
    -> NodeSpec x
abcNode callback =
    NodeSpec
        (\entityId ( entity, ecs, x ) ->
            entity.a
                |> Maybe.map AbcNode
                |> maybeAndMap entity.b
                |> maybeAndMap entity.c
                |> applyNode callback entityId ( entity, ecs, x )
        )


maybeAndMap : Maybe a -> Maybe (a -> b) -> Maybe b
maybeAndMap =
    Maybe.map2 (|>)
