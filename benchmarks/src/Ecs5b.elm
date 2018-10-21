module Ecs5b exposing
    ( Ecs, empty
    , EntityId, Entity, create, destroy, reset, get, size, activeSize, idToInt, intToId
    , EntityUpdate, apply, update, insert, remove, modify, entityId
    , NodeType, iterate, iterateAndUpdate, nodeSize
    , aComponent, bComponent, cComponent
    , ANode, AbNode, AbcNode
    , aNode, abNode, abcNode
    )

{-| Your Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, Entity, create, destroy, reset, get, size, activeSize, idToInt, intToId


# Entity Update

@docs EntityUpdate, apply, update, insert, remove, modify, entityId, initialEnitity


# Nodes

@docs NodeType, iterate, iterateAndUpdate, nodeSize


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
create : (EntityUpdate -> EntityUpdate) -> Ecs -> Ecs
create updater (Ecs model) =
    let
        ( id, newModel ) =
            case model.destroyedEntitiesCache of
                [] ->
                    ( entitiesSize model
                    , { model | entities = Array.push emptyEntity model.entities }
                    )

                head :: tail ->
                    ( head
                    , { model | destroyedEntitiesCache = tail }
                    )

        entityUpdate =
            EntityUpdate
                { id = id
                , entity = emptyEntity
                , updates = []
                }
    in
    Ecs (applyUpdate (updater entityUpdate) newModel)


{-| -}
destroy : EntityId -> Ecs -> Ecs
destroy (EntityId id) (Ecs model) =
    { model | destroyedEntitiesCache = id :: model.destroyedEntitiesCache }
        |> resetEntity id
        |> Ecs


{-| -}
reset : EntityId -> Ecs -> Ecs
reset (EntityId id) (Ecs model) =
    model
        |> resetEntity id
        |> Ecs


resetEntity : Int -> Model -> Model
resetEntity id model =
    { model
        | entities = Array.set id emptyEntity model.entities
        , aEntities = Set.remove id model.aEntities
        , abEntities = Set.remove id model.abEntities
        , abcEntities = Set.remove id model.abcEntities
    }


{-| -}
get : EntityId -> Ecs -> Entity
get (EntityId id) (Ecs model) =
    getEntity id model


getEntity : Int -> Model -> Entity
getEntity id model =
    Array.get id model.entities |> Maybe.withDefault emptyEntity



-- set : EntityId -> Entity -> Ecs -> Ecs
-- set (EntityId entityId) entity (Ecs model) =
--     let
--         entitySetUpdater =
--             updateInEntitySet entityId entity
--     in
--     Ecs
--         { model
--             | entities = Array.set entityId entity model.entities
--             , aEntities = entitySetUpdater aEntitySet model.aEntities
--             , abEntities = entitySetUpdater abEntitySet model.abEntities
--             , abcEntities = entitySetUpdater abcEntitySet model.abcEntities
--         }
-- updateEntitySets : (EntitySetType -> Set.Set Int -> Set.Set Int) -> Model -> Model
-- updateEntitySets updater model =
--     { model
--         | aEntities = updater aEntitySet model.aEntities
--         , abEntities = updater abEntitySet model.abEntities
--         , abcEntities = updater abcEntitySet model.abcEntities
--     }
-- insertInEntitySet : Int -> Entity -> EntitySetType -> Set.Set Int -> Set.Set Int
-- insertInEntitySet entityId entity entitySetType entitySet =
--     if entitySetType.member entity then
--         Set.insert entityId entitySet
--     else
--         entitySet
-- updateInEntitySet : Int -> Entity -> EntitySetType -> Set.Set Int -> Set.Set Int
-- updateInEntitySet entityId entity entitySetType entitySet =
--     if entitySetType.member entity then
--         Set.insert entityId entitySet
--     else
--         Set.remove entityId entitySet
-- modify : EntityId -> (Entity -> Entity) -> Ecs -> Ecs
-- modify (EntityId entityId) updater (Ecs model) =
--     case Array.get entityId model.entities of
--         Nothing ->
--             Ecs model
--         Just entity ->
--             set (EntityId entityId) (updater entity) (Ecs model)


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



-- Entity Update --


{-| -}
type EntityUpdate
    = EntityUpdate EntityUpdateModel


type alias EntityUpdateModel =
    { id : Int
    , entity : Entity
    , updates : List (( Entity, Model ) -> ( Entity, Model ))
    }


{-| -}
apply : EntityUpdate -> Ecs -> Ecs
apply entityUpdate (Ecs model) =
    Ecs (applyUpdate entityUpdate model)


applyUpdate : EntityUpdate -> Model -> Model
applyUpdate (EntityUpdate { id, entity, updates }) model =
    case updates of
        [] ->
            model

        _ ->
            let
                ( newEntity, newModel ) =
                    List.foldl (<|) ( entity, model ) updates
            in
            { newModel | entities = Array.set id newEntity newModel.entities }


{-| -}
update : EntityId -> (EntityUpdate -> EntityUpdate) -> Ecs -> Ecs
update (EntityId id) updater (Ecs model) =
    let
        entityUpdate =
            EntityUpdate
                { id = id
                , entity = getEntity id model
                , updates = []
                }
    in
    Ecs (applyUpdate (updater entityUpdate) model)


{-| -}
insert : ComponentType a -> a -> EntityUpdate -> EntityUpdate
insert componentType component (EntityUpdate entityUpdate) =
    EntityUpdate
        { entityUpdate
            | updates =
                insertComponent
                    entityUpdate.id
                    componentType
                    component
                    :: entityUpdate.updates
        }


insertComponent : Int -> ComponentType a -> a -> ( Entity, Model ) -> ( Entity, Model )
insertComponent id (ComponentType componentType) component ( entity, model ) =
    let
        newEntity =
            componentType.setComponent (Just component) entity
    in
    case componentType.getComponent entity of
        Nothing ->
            ( newEntity
            , insertInEntitySets id newEntity componentType model
            )

        Just _ ->
            ( newEntity, model )


insertInEntitySets : Int -> Entity -> ComponentTypeModel a -> Model -> Model
insertInEntitySets id entity componentType model =
    List.foldl (insertInEntitySet id entity) model componentType.entitySets


insertInEntitySet : Int -> Entity -> EntitySetType -> Model -> Model
insertInEntitySet id entity entitySetType model =
    if entitySetType.member entity then
        entitySetType.setEntities
            (Set.insert id (entitySetType.getEntities model))
            model

    else
        model


{-| -}
remove : ComponentType a -> EntityUpdate -> EntityUpdate
remove componentType (EntityUpdate entityUpdate) =
    EntityUpdate
        { entityUpdate
            | updates =
                removeComponent
                    entityUpdate.id
                    componentType
                    :: entityUpdate.updates
        }


removeComponent : Int -> ComponentType a -> ( Entity, Model ) -> ( Entity, Model )
removeComponent id (ComponentType componentType) ( entity, model ) =
    let
        newEntity =
            componentType.setComponent Nothing entity
    in
    case componentType.getComponent entity of
        Nothing ->
            ( newEntity, model )

        Just _ ->
            ( newEntity
            , removeFromEntitySets id componentType model
            )


removeFromEntitySets : Int -> ComponentTypeModel a -> Model -> Model
removeFromEntitySets id componentType model =
    List.foldl (removeFromEntitySet id) model componentType.entitySets


removeFromEntitySet : Int -> EntitySetType -> Model -> Model
removeFromEntitySet id entitySetType model =
    entitySetType.setEntities
        (Set.remove id (entitySetType.getEntities model))
        model


{-| -}
modify : ComponentType a -> (Maybe a -> Maybe a) -> EntityUpdate -> EntityUpdate
modify componentType updater (EntityUpdate entityUpdate) =
    EntityUpdate
        { entityUpdate
            | updates =
                modifyComponent
                    entityUpdate.id
                    componentType
                    updater
                    :: entityUpdate.updates
        }


modifyComponent :
    Int
    -> ComponentType a
    -> (Maybe a -> Maybe a)
    -> ( Entity, Model )
    -> ( Entity, Model )
modifyComponent id (ComponentType componentType) updater ( entity, model ) =
    let
        component =
            componentType.getComponent entity

        newComponent =
            updater component
    in
    case ( component, newComponent ) of
        ( Nothing, Nothing ) ->
            ( entity, model )

        ( Nothing, Just _ ) ->
            let
                newEntity =
                    componentType.setComponent newComponent entity
            in
            ( newEntity
            , insertInEntitySets id newEntity componentType model
            )

        ( Just _, Nothing ) ->
            ( componentType.setComponent newComponent entity
            , removeFromEntitySets id componentType model
            )

        ( Just _, Just _ ) ->
            ( componentType.setComponent newComponent entity
            , model
            )


entityId : EntityUpdate -> EntityId
entityId (EntityUpdate { id }) =
    EntityId id


intialEntity : EntityUpdate -> Entity
intialEntity (EntityUpdate { entity }) =
    entity



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
    -> (EntityId -> Entity -> node -> context -> context)
    -> Ecs
    -> context
    -> context
iterate (NodeType nodeType) callback (Ecs model) context =
    Set.foldl
        (\id x ->
            case Array.get id model.entities of
                Nothing ->
                    x

                Just entity ->
                    case nodeType.getNode entity of
                        Nothing ->
                            x

                        Just node ->
                            callback (EntityId id) entity node x
        )
        context
        (nodeType.getEntities model)


{-| -}
iterateAndUpdate :
    NodeType node
    -> (EntityUpdate -> node -> ( Ecs, context ) -> ( Ecs, context ))
    -> ( Ecs, context )
    -> ( Ecs, context )
iterateAndUpdate (NodeType nodeType) callback ( Ecs model, context ) =
    Set.foldl
        (\id result ->
            case Array.get id model.entities of
                Nothing ->
                    result

                Just entity ->
                    case nodeType.getNode entity of
                        Nothing ->
                            result

                        Just node ->
                            callback
                                (EntityUpdate
                                    { id = id
                                    , entity = entity
                                    , updates = []
                                    }
                                )
                                node
                                result
        )
        ( Ecs model, context )
        (nodeType.getEntities model)


{-| -}
nodeSize : NodeType a -> Ecs -> Int
nodeSize (NodeType nodeType) (Ecs model) =
    Set.size (nodeType.getEntities model)



-- YOUR COMPONENT TYPES --


{-| -}
type ComponentType a
    = ComponentType (ComponentTypeModel a)


type alias ComponentTypeModel a =
    { getComponent : Entity -> Maybe a
    , setComponent : Maybe a -> Entity -> Entity
    , entitySets : List EntitySetType
    }


{-| -}
aComponent : ComponentType Components.A
aComponent =
    ComponentType
        { getComponent = .a
        , setComponent = \component entity -> { entity | a = component }
        , entitySets = [ aEntitySet, abEntitySet, abcEntitySet ]
        }


{-| -}
bComponent : ComponentType Components.B
bComponent =
    ComponentType
        { getComponent = .b
        , setComponent = \component entity -> { entity | b = component }
        , entitySets = [ abEntitySet, abcEntitySet ]
        }


{-| -}
cComponent : ComponentType Components.C
cComponent =
    ComponentType
        { getComponent = .c
        , setComponent = \component entity -> { entity | c = component }
        , entitySets = [ abcEntitySet ]
        }



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
    { getEntities : Model -> Set.Set Int
    , setEntities : Set.Set Int -> Model -> Model
    , member : Entity -> Bool
    }


aEntitySet : EntitySetType
aEntitySet =
    { getEntities = .aEntities
    , setEntities = \entities model -> { model | aEntities = entities }
    , member =
        \entity ->
            entity.a /= Nothing
    }


abEntitySet : EntitySetType
abEntitySet =
    { getEntities = .abEntities
    , setEntities = \entities model -> { model | abEntities = entities }
    , member =
        \entity ->
            (entity.a /= Nothing)
                && (entity.b /= Nothing)
    }


abcEntitySet : EntitySetType
abcEntitySet =
    { getEntities = .abcEntities
    , setEntities = \entities model -> { model | abcEntities = entities }
    , member =
        \entity ->
            (entity.a /= Nothing)
                && (entity.b /= Nothing)
                && (entity.c /= Nothing)
    }
