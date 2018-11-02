module Ecs6 exposing
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

import Components
import Dict



-- MODEL --


{-| -}
type Ecs
    = Ecs Model


type alias Model =
    { aComponents : Dict.Dict Int Components.A
    , bComponents : Dict.Dict Int Components.B
    , cComponents : Dict.Dict Int Components.C
    , aNodes : Dict.Dict Int ANode
    , abNodes : Dict.Dict Int AbNode
    , abcNodes : Dict.Dict Int AbcNode
    , numberOfCreatedEntities : Int
    , destroyedEntities : List Int
    }


{-| -}
empty : Ecs
empty =
    Ecs
        { aComponents = Dict.empty
        , bComponents = Dict.empty
        , cComponents = Dict.empty
        , aNodes = Dict.empty
        , abNodes = Dict.empty
        , abcNodes = Dict.empty
        , numberOfCreatedEntities = 0
        , destroyedEntities = []
        }



-- ENTITIES --


{-| -}
type EntityId
    = EntityId Int


{-| -}
create : Ecs -> ( Ecs, EntityId )
create (Ecs model) =
    case model.destroyedEntities of
        [] ->
            ( Ecs
                { aComponents = model.aComponents
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities + 1
                , destroyedEntities = model.destroyedEntities
                }
            , EntityId model.numberOfCreatedEntities
            )

        head :: tail ->
            ( Ecs
                { aComponents = model.aComponents
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = tail
                }
            , EntityId head
            )


{-| -}
destroy : EntityId -> Ecs -> Ecs
destroy (EntityId entityId) (Ecs model) =
    Ecs
        { aComponents = Dict.remove entityId model.aComponents
        , bComponents = Dict.remove entityId model.bComponents
        , cComponents = Dict.remove entityId model.cComponents
        , aNodes = Dict.remove entityId model.aNodes
        , abNodes = Dict.remove entityId model.abNodes
        , abcNodes = Dict.remove entityId model.abcNodes
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = entityId :: model.destroyedEntities
        }


{-| -}
reset : EntityId -> Ecs -> Ecs
reset (EntityId entityId) (Ecs model) =
    Ecs
        { aComponents = Dict.remove entityId model.aComponents
        , bComponents = Dict.remove entityId model.bComponents
        , cComponents = Dict.remove entityId model.cComponents
        , aNodes = Dict.remove entityId model.aNodes
        , abNodes = Dict.remove entityId model.abNodes
        , abcNodes = Dict.remove entityId model.abcNodes
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = model.destroyedEntities
        }


{-| -}
size : Ecs -> Int
size (Ecs model) =
    model.numberOfCreatedEntities


{-| -}
activeSize : Ecs -> Int
activeSize (Ecs model) =
    model.numberOfCreatedEntities - List.length model.destroyedEntities


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
    = ComponentType (ComponentTypeModel a)


type alias ComponentTypeModel a =
    { id : Int
    , getComponents : Model -> Dict.Dict Int a
    , setComponents : Dict.Dict Int a -> Model -> Model
    }


getComponentTypeId : ComponentType a -> Int
getComponentTypeId (ComponentType componentType) =
    componentType.id


{-| -}
get : EntityId -> ComponentType a -> Ecs -> Maybe a
get (EntityId entityId) (ComponentType { getComponents }) (Ecs model) =
    Dict.get entityId (getComponents model)


{-| -}
insert : EntityId -> ComponentType a -> a -> Ecs -> Ecs
insert (EntityId entityId) (ComponentType componentType) component (Ecs model) =
    model
        |> insertComponent entityId componentType component
        |> insertNodes entityId componentType component
        |> Ecs


insertComponent : Int -> ComponentTypeModel a -> a -> Model -> Model
insertComponent entityId componentType component model =
    componentType.setComponents
        (Dict.insert entityId component (componentType.getComponents model))
        model


insertNodes : Int -> ComponentTypeModel c -> c -> Model -> Model
insertNodes entityId componentType component model =
    model
        |> insertNode entityId componentType component aNode
        |> insertNode entityId componentType component abNode
        |> insertNode entityId componentType component abcNode


insertNode : Int -> ComponentTypeModel c -> c -> NodeType n -> Model -> Model
insertNode entityId componentType component (NodeType nodeType) model =
    if List.member componentType.id nodeType.componentTypeIds then
        nodeType.setNodes
            (Dict.update entityId
                (\maybeNode ->
                    case maybeNode of
                        Nothing ->
                            nodeType.getNode entityId model

                        Just node ->
                            --FIXME
                            -- Just (componentType.updateIn component node)
                            Just node
                )
                (nodeType.getNodes model)
            )
            model

    else
        model


{-| -}
update : EntityId -> ComponentType a -> (Maybe a -> Maybe a) -> Ecs -> Ecs
update (EntityId entityId) (ComponentType componentType) updater (Ecs model) =
    let
        component =
            Dict.get entityId (componentType.getComponents model)
    in
    case ( component, updater component ) of
        ( Nothing, Nothing ) ->
            Ecs model

        ( Just _, Nothing ) ->
            model
                |> removeComponent entityId componentType
                |> removeNodes entityId componentType
                |> Ecs

        ( _, Just newComponent ) ->
            model
                |> insertComponent entityId componentType newComponent
                |> insertNodes entityId componentType newComponent
                |> Ecs


{-| -}
remove : EntityId -> ComponentType a -> Ecs -> Ecs
remove (EntityId entityId) (ComponentType componentType) (Ecs model) =
    model
        |> removeComponent entityId componentType
        |> removeNodes entityId componentType
        |> Ecs


removeComponent : Int -> ComponentTypeModel a -> Model -> Model
removeComponent entityId componentType model =
    componentType.setComponents
        (Dict.remove entityId (componentType.getComponents model))
        model


removeNodes : Int -> ComponentTypeModel c -> Model -> Model
removeNodes entityId componentType model =
    model
        |> removeNode entityId componentType aNode
        |> removeNode entityId componentType abNode
        |> removeNode entityId componentType abcNode


removeNode : Int -> ComponentTypeModel c -> NodeType n -> Model -> Model
removeNode entityId componentType (NodeType nodeType) model =
    -- TODO check if check is needed
    if List.member componentType.id nodeType.componentTypeIds then
        nodeType.setNodes
            (Dict.remove entityId (nodeType.getNodes model))
            model

    else
        model



-- NODES --


{-| -}
type NodeType node
    = NodeType
        { getNodes : Model -> Dict.Dict Int node
        , setNodes : Dict.Dict Int node -> Model -> Model
        , getNode : Int -> Model -> Maybe node
        , componentTypeIds : List Int
        }


{-| -}
iterate :
    NodeType node
    -> (EntityId -> node -> ( Ecs, x ) -> ( Ecs, x ))
    -> ( Ecs, x )
    -> ( Ecs, x )
iterate (NodeType nodeType) callback ( Ecs model, x ) =
    Dict.foldl
        (EntityId >> callback)
        ( Ecs model, x )
        (nodeType.getNodes model)


{-| -}
nodeSize : NodeType a -> Ecs -> Int
nodeSize (NodeType nodeType) (Ecs model) =
    Dict.size (nodeType.getNodes model)



-- YOUR COMPONENT TYPES --


{-| -}
aComponent : ComponentType Components.A
aComponent =
    ComponentType
        { id = 0
        , getComponents = .aComponents
        , setComponents =
            \components model ->
                { aComponents = components
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
        }


{-| -}
bComponent : ComponentType Components.B
bComponent =
    ComponentType
        { id = 1
        , getComponents = .bComponents
        , setComponents =
            \components model ->
                { aComponents = model.aComponents
                , bComponents = components
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
        }


{-| -}
cComponent : ComponentType Components.C
cComponent =
    ComponentType
        { id = 2
        , getComponents = .cComponents
        , setComponents =
            \components model ->
                { aComponents = model.aComponents
                , bComponents = components
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
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
        { getNodes = .aNodes
        , setNodes =
            \nodes model ->
                { aComponents = model.aComponents
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = nodes
                , abNodes = model.abNodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
        , getNode =
            \entityId model ->
                Maybe.map ANode (Dict.get entityId model.aComponents)
        , componentTypeIds = [ getComponentTypeId aComponent ]
        }


{-| -}
abNode : NodeType AbNode
abNode =
    NodeType
        { getNodes = .abNodes
        , setNodes =
            \nodes model ->
                { aComponents = model.aComponents
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = nodes
                , abcNodes = model.abcNodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
        , getNode =
            \entityId model ->
                Maybe.map AbNode (Dict.get entityId model.aComponents)
                    |> maybeAndMap (Dict.get entityId model.bComponents)
        , componentTypeIds =
            [ getComponentTypeId aComponent
            , getComponentTypeId bComponent
            ]
        }


{-| -}
abcNode : NodeType AbcNode
abcNode =
    NodeType
        { getNodes = .abcNodes
        , setNodes =
            \nodes model ->
                { aComponents = model.aComponents
                , bComponents = model.bComponents
                , cComponents = model.cComponents
                , aNodes = model.aNodes
                , abNodes = model.abNodes
                , abcNodes = nodes
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = model.destroyedEntities
                }
        , getNode =
            \entityId model ->
                Maybe.map AbcNode (Dict.get entityId model.aComponents)
                    |> maybeAndMap (Dict.get entityId model.bComponents)
                    |> maybeAndMap (Dict.get entityId model.cComponents)
        , componentTypeIds =
            [ getComponentTypeId aComponent
            , getComponentTypeId bComponent
            , getComponentTypeId cComponent
            ]
        }


maybeAndMap : Maybe a -> Maybe (a -> b) -> Maybe b
maybeAndMap =
    Maybe.map2 (|>)
