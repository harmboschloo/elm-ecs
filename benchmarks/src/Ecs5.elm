module Ecs5 exposing
    ( Ecs, empty
    , EntityId, Entity, emptyEntity, insert, remove, reset, get, set, update, size, activeSize, idToInt, intToId
    , NodeType, iterate, nodeSize
    , ANode, AbNode, AbcNode
    , aNode, abNode, abcNode
    )

{-| Your Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, Entity, emptyEntity, insert, remove, reset, get, set, update, size, activeSize, idToInt, intToId


# Nodes

@docs NodeType, iterate, nodeSize


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
    , aEntities : Set.Set Int
    , abEntities : Set.Set Int
    , abcEntities : Set.Set Int
    , destroyedEntitiesCache : List Int
    }


{-| -}
empty : Ecs
empty =
    Ecs
        { entities = Array.empty
        , aEntities = Set.empty
        , abEntities = Set.empty
        , abcEntities = Set.empty
        , destroyedEntitiesCache = []
        }



--TODO
--emptyWith
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
insert : Entity -> Ecs -> ( Ecs, EntityId )
insert entity (Ecs model) =
    case model.destroyedEntitiesCache of
        [] ->
            let
                entityId =
                    entitiesSize model
            in
            ( { model | entities = Array.push entity model.entities }
                |> updateEntitySets (insertInEntitySet entityId entity)
                |> Ecs
            , EntityId entityId
            )

        entityId :: others ->
            ( { model
                | entities = Array.set entityId entity model.entities
                , destroyedEntitiesCache = others
              }
                |> updateEntitySets (insertInEntitySet entityId entity)
                |> Ecs
            , EntityId entityId
            )


{-| -}
remove : EntityId -> Ecs -> Ecs
remove (EntityId entityId) (Ecs model) =
    { model | destroyedEntitiesCache = entityId :: model.destroyedEntitiesCache }
        |> resetEntity entityId
        |> Ecs


{-| -}
reset : EntityId -> Ecs -> Ecs
reset (EntityId entityId) (Ecs model) =
    model
        |> resetEntity entityId
        |> Ecs


resetEntity : Int -> Model -> Model
resetEntity entityId model =
    { model
        | entities = Array.set entityId emptyEntity model.entities
        , aEntities = Set.remove entityId model.aEntities
        , abEntities = Set.remove entityId model.abEntities
        , abcEntities = Set.remove entityId model.abcEntities
    }


{-| -}
get : EntityId -> Ecs -> Entity
get (EntityId entityId) (Ecs model) =
    Array.get entityId model.entities |> Maybe.withDefault emptyEntity


{-| -}
set : EntityId -> Entity -> Ecs -> Ecs
set (EntityId entityId) entity (Ecs model) =
    let
        entitySetUpdater =
            updateInEntitySet entityId entity
    in
    Ecs
        { model
            | entities = Array.set entityId entity model.entities
            , aEntities = entitySetUpdater aEntitySet model.aEntities
            , abEntities = entitySetUpdater abEntitySet model.abEntities
            , abcEntities = entitySetUpdater abcEntitySet model.abcEntities
        }


updateEntitySets : (EntitySetType -> Set.Set Int -> Set.Set Int) -> Model -> Model
updateEntitySets updater model =
    { model
        | aEntities = updater aEntitySet model.aEntities
        , abEntities = updater abEntitySet model.abEntities
        , abcEntities = updater abcEntitySet model.abcEntities
    }


insertInEntitySet : Int -> Entity -> EntitySetType -> Set.Set Int -> Set.Set Int
insertInEntitySet entityId entity entitySetType entitySet =
    if entitySetType.member entity then
        Set.insert entityId entitySet

    else
        entitySet


updateInEntitySet : Int -> Entity -> EntitySetType -> Set.Set Int -> Set.Set Int
updateInEntitySet entityId entity entitySetType entitySet =
    if entitySetType.member entity then
        Set.insert entityId entitySet

    else
        Set.remove entityId entitySet


{-| -}
update : EntityId -> (Entity -> Entity) -> Ecs -> Ecs
update (EntityId entityId) updater (Ecs model) =
    case Array.get entityId model.entities of
        Nothing ->
            Ecs model

        Just entity ->
            set (EntityId entityId) (updater entity) (Ecs model)


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
idToInt (EntityId id) =
    id


{-| -}
intToId : Int -> Ecs -> Maybe EntityId
intToId id ecs =
    if id < size ecs then
        Just (EntityId id)

    else
        Nothing



-- NODES --


{-| -}
type NodeType node
    = NodeType
        { getEntities : Model -> Set.Set Int
        , getNode : Entity -> Maybe node
        }


{-| -}
iterate :
    NodeType node
    -> (EntityId -> Entity -> node -> ( Ecs, context ) -> ( Ecs, context ))
    -> ( Ecs, context )
    -> ( Ecs, context )
iterate (NodeType nodeType) callback ( Ecs model, context ) =
    Set.foldl
        (\entityId result ->
            case Array.get entityId model.entities of
                Nothing ->
                    result

                Just entity ->
                    case nodeType.getNode entity of
                        Nothing ->
                            result

                        Just node ->
                            callback
                                (EntityId entityId)
                                entity
                                node
                                result
        )
        ( Ecs model, context )
        (nodeType.getEntities model)


{-| -}
nodeSize : NodeType a -> Ecs -> Int
nodeSize (NodeType nodeType) (Ecs model) =
    Set.size (nodeType.getEntities model)



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


{-| -}
aNode : NodeType ANode
aNode =
    NodeType
        { getEntities = .aEntities
        , getNode =
            \entity ->
                Maybe.map ANode entity.a
        }


{-| -}
abNode : NodeType AbNode
abNode =
    NodeType
        { getEntities = .abEntities
        , getNode =
            \entity ->
                Maybe.map AbNode entity.a
                    |> maybeAndMap entity.b
        }


{-| -}
abcNode : NodeType AbcNode
abcNode =
    NodeType
        { getEntities = .abcEntities
        , getNode =
            \entity ->
                Maybe.map AbcNode entity.a
                    |> maybeAndMap entity.b
                    |> maybeAndMap entity.c
        }


maybeAndMap : Maybe a -> Maybe (a -> b) -> Maybe b
maybeAndMap =
    Maybe.map2 (|>)



-- YOUR ENTITY SET TYPES --


type alias EntitySetType =
    { member : Entity -> Bool
    }


aEntitySet : EntitySetType
aEntitySet =
    { member =
        \entity ->
            entity.a /= Nothing
    }


abEntitySet : EntitySetType
abEntitySet =
    { member =
        \entity ->
            (entity.a /= Nothing)
                && (entity.b /= Nothing)
    }


abcEntitySet : EntitySetType
abcEntitySet =
    { member =
        \entity ->
            (entity.a /= Nothing)
                && (entity.b /= Nothing)
                && (entity.c /= Nothing)
    }
