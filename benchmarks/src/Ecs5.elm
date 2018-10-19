module Ecs5 exposing
    ( Ecs, empty
    , EntityId, create, destroy, reset, size, activeSize, idToInt, intToId
    , ComponentType, get, insert, update, remove
    , NodeType, iterate, nodeSize
    , aComponent, bComponent, cComponent
    , ANode, AbNode, AbcNode
    , aNode, abNode, abcNode
    )

{-| Your Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, create, destroy, reset, size, activeSize, idToInt, intToId


# Components

@docs ComponentType, get, insert, update, remove


# Nodes

@docs NodeType, iterate, nodeSize


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


defaultEntity : Entity
defaultEntity =
    { a = Nothing
    , b = Nothing
    , c = Nothing
    }


{-| -}
create : Ecs -> ( Ecs, EntityId )
create (Ecs model) =
    case model.destroyedEntitiesCache of
        [] ->
            ( Ecs { model | entities = Array.push defaultEntity model.entities }
            , EntityId (entitiesSize model)
            )

        head :: tail ->
            ( Ecs { model | destroyedEntitiesCache = tail }
            , EntityId head
            )


{-| -}
destroy : EntityId -> Ecs -> Ecs
destroy (EntityId entityId) (Ecs model) =
    { model | destroyedEntitiesCache = entityId :: model.destroyedEntitiesCache }
        |> resetEntity entityId
        |> Ecs


{-| -}
reset : EntityId -> Ecs -> Ecs
reset (EntityId entityId) (Ecs model) =
    Ecs (resetEntity entityId model)


resetEntity : Int -> Model -> Model
resetEntity entityId model =
    { model
        | entities = Array.set entityId defaultEntity model.entities
        , aEntities = Set.remove entityId model.aEntities
        , abEntities = Set.remove entityId model.abEntities
        , abcEntities = Set.remove entityId model.abcEntities
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
idToInt (EntityId id) =
    id


{-| -}
intToId : Int -> Ecs -> Maybe EntityId
intToId id ecs =
    if id < size ecs then
        Just (EntityId id)

    else
        Nothing



-- COMPONENTS --


{-| -}
type ComponentType a
    = ComponentType
        { getComponent : Entity -> Maybe a
        , setComponent : Maybe a -> Entity -> Entity
        , entitySets : List EntitySetType
        }


{-| -}
get : EntityId -> ComponentType a -> Ecs -> Maybe a
get (EntityId entityId) (ComponentType componentType) (Ecs model) =
    Array.get entityId model.entities
        |> Maybe.map componentType.getComponent
        |> Maybe.withDefault Nothing


{-| -}
insert : EntityId -> ComponentType a -> a -> Ecs -> Ecs
insert (EntityId entityId) (ComponentType componentType) component (Ecs model) =
    let
        updatedModel =
            case Array.get entityId model.entities of
                Nothing ->
                    model

                Just entity ->
                    { model
                        | entities =
                            Array.set
                                entityId
                                (componentType.setComponent (Just component) entity)
                                model.entities
                    }
    in
    Ecs
        (List.foldl (insertEntityInSet entityId) updatedModel componentType.entitySets)


insertEntityInSet : Int -> EntitySetType -> Model -> Model
insertEntityInSet entityId entitySetType model =
    if entitySetType.member entityId model then
        entitySetType.setEntities
            (Set.insert entityId (entitySetType.getEntities model))
            model

    else
        model


{-| -}
update : EntityId -> ComponentType a -> (Maybe a -> Maybe a) -> Ecs -> Ecs
update (EntityId entityId) (ComponentType componentType) updater (Ecs model) =
    case Array.get entityId model.entities of
        Nothing ->
            Ecs model

        Just entity ->
            let
                maybeComponent =
                    componentType.getComponent entity
            in
            case ( maybeComponent, updater maybeComponent ) of
                ( _, Just component ) ->
                    Ecs
                        { model
                            | entities =
                                Array.set
                                    entityId
                                    (componentType.setComponent (Just component) entity)
                                    model.entities
                        }

                ( Just _, Nothing ) ->
                    Ecs
                        { model
                            | entities =
                                Array.set
                                    entityId
                                    (componentType.setComponent Nothing entity)
                                    model.entities
                        }

                ( Nothing, Nothing ) ->
                    Ecs model


{-| -}
remove : EntityId -> ComponentType a -> Ecs -> Ecs
remove (EntityId entityId) (ComponentType componentType) (Ecs model) =
    componentType.entitySets
        |> List.foldl (removeEntityFromSet entityId) model
        |> (\m ->
                case Array.get entityId model.entities of
                    Nothing ->
                        m

                    Just entity ->
                        { m
                            | entities =
                                Array.set
                                    entityId
                                    (componentType.setComponent Nothing entity)
                                    model.entities
                        }
           )
        |> Ecs


removeEntityFromSet : Int -> EntitySetType -> Model -> Model
removeEntityFromSet entityId entitySetType model =
    entitySetType.setEntities
        (Set.remove entityId (entitySetType.getEntities model))
        model



-- NODES --


{-| -}
type NodeType node
    = NodeType
        { getEntities : Model -> Set.Set Int
        , getNode : Int -> Model -> Maybe node
        }


{-| -}
iterate :
    NodeType node
    -> (EntityId -> node -> ( Ecs, context ) -> ( Ecs, context ))
    -> ( Ecs, context )
    -> ( Ecs, context )
iterate (NodeType nodeType) callback ( Ecs model, context ) =
    Set.foldl
        (\entityId result ->
            case nodeType.getNode entityId model of
                Nothing ->
                    result

                Just node ->
                    callback (EntityId entityId) node result
        )
        ( Ecs model, context )
        (nodeType.getEntities model)


{-| -}
nodeSize : NodeType a -> Ecs -> Int
nodeSize (NodeType nodeType) (Ecs model) =
    Set.size (nodeType.getEntities model)



-- YOUR COMPONENT TYPES --


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
            \entityId model ->
                Array.get entityId model.entities
                    |> Maybe.map
                        (\entity ->
                            ANode
                                |> nextComponent entity.a
                        )
                    |> Maybe.withDefault Nothing
        }


{-| -}
abNode : NodeType AbNode
abNode =
    NodeType
        { getEntities = .abEntities
        , getNode =
            \entityId model ->
                Array.get entityId model.entities
                    |> Maybe.map
                        (\entity ->
                            AbNode
                                |> nextComponent entity.a
                                |> Maybe.andThen (nextComponent entity.b)
                        )
                    |> Maybe.withDefault Nothing
        }


{-| -}
abcNode : NodeType AbcNode
abcNode =
    NodeType
        { getEntities = .abcEntities
        , getNode =
            \entityId model ->
                Array.get entityId model.entities
                    |> Maybe.map
                        (\entity ->
                            AbcNode
                                |> nextComponent entity.a
                                |> Maybe.andThen (nextComponent entity.b)
                                |> Maybe.andThen (nextComponent entity.c)
                        )
                    |> Maybe.withDefault Nothing
        }


nextComponent : Maybe a -> (a -> b) -> Maybe b
nextComponent component callback =
    Maybe.map callback component



-- YOUR ENTITY SET TYPES --


type alias EntitySetType =
    { getEntities : Model -> Set.Set Int
    , setEntities : Set.Set Int -> Model -> Model
    , member : Int -> Model -> Bool
    }


aEntitySet : EntitySetType
aEntitySet =
    { getEntities = .aEntities
    , setEntities = \entities model -> { model | aEntities = entities }
    , member =
        \entityId model ->
            Array.get entityId model.entities
                |> Maybe.map
                    (\entity ->
                        entity.a /= Nothing
                    )
                |> Maybe.withDefault False
    }


abEntitySet : EntitySetType
abEntitySet =
    { getEntities = .abEntities
    , setEntities = \entities model -> { model | abEntities = entities }
    , member =
        \entityId model ->
            Array.get entityId model.entities
                |> Maybe.map
                    (\entity ->
                        (entity.a /= Nothing)
                            && (entity.b /= Nothing)
                    )
                |> Maybe.withDefault False
    }


abcEntitySet : EntitySetType
abcEntitySet =
    { getEntities = .abcEntities
    , setEntities = \entities model -> { model | abcEntities = entities }
    , member =
        \entityId model ->
            Array.get entityId model.entities
                |> Maybe.map
                    (\entity ->
                        (entity.a /= Nothing)
                            && (entity.b /= Nothing)
                            && (entity.c /= Nothing)
                    )
                |> Maybe.withDefault False
    }
