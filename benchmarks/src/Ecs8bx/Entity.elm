module Ecs8b.Entity exposing
    ( EntitySpec, Entity
    , EntityId, id
    , ComponentSpec, get, set, update, remove
    , NodeSpec, getNode, setNode
    , clear, destroy
    )

{-|

@docs EntitySpec, Entity


# EntityId

@docs EntityId, id


# Components

@docs ComponentSpec, get, set, update, remove


# Nodes

@docs NodeSpec, getNode, setNode


# Entity

@docs clear, destroy

-}


type EntitySpec components
    = EntitySpec { empty : components }


type Entity components
    = Entity Int components Status



-- STATUS --


type Status
    = Unmodified
    | Modified
    | Destroyed


modifyStatus : Status -> Status
modifyStatus status =
    case status of
        Unmodified ->
            Modified

        Modified ->
            Modified

        Destroyed ->
            Destroyed



-- ENTITY ID --


type EntityId
    = EntityId Int


id : Entity components -> EntityId
id (Entity index _ _) =
    EntityId index



-- COMPONENTS --


type ComponentSpec components component
    = ComponentSpec
        { getComponent : components -> Maybe component
        , setComponent : Maybe component -> components -> components
        }


get :
    ComponentSpec components component
    -> Entity components
    -> Maybe component
get (ComponentSpec spec) (Entity _ components status) =
    case status of
        Destroyed ->
            Nothing

        _ ->
            spec.getComponent components


set :
    ComponentSpec components component
    -> component
    -> Entity components
    -> Entity components
set (ComponentSpec spec) component (Entity index components status) =
    Entity index
        (spec.setComponent (Just component) components)
        (modifyStatus status)


update :
    ComponentSpec components component
    -> (Maybe component -> Maybe component)
    -> Entity components
    -> Entity components
update (ComponentSpec spec) updater (Entity index components status) =
    Entity index
        (spec.setComponent (updater (spec.getComponent components)) components)
        (modifyStatus status)


remove :
    ComponentSpec components component
    -> Entity components
    -> Entity components
remove (ComponentSpec spec) (Entity index components status) =
    Entity index
        (spec.setComponent Nothing components)
        (modifyStatus status)



-- NODES --


type NodeSpec components node
    = NodeSpec
        { getNode : components -> Maybe node
        , setNode : node -> components -> components
        }


getNode :
    NodeSpec components node
    -> Entity components
    -> Maybe node
getNode (NodeSpec spec) (Entity _ components status) =
    case status of
        Destroyed ->
            Nothing

        _ ->
            spec.getNode components


setNode :
    NodeSpec components node
    -> node
    -> Entity components
    -> Entity components
setNode (NodeSpec spec) node (Entity index components status) =
    Entity index
        (spec.setNode node components)
        (modifyStatus status)



-- MODIFY ENTITY --


clear : EntitySpec components -> Entity components -> Entity components
clear (EntitySpec spec) (Entity index components status) =
    Entity index spec.empty (modifyStatus status)


destroy : Entity components -> Entity components
destroy (Entity index components status) =
    Entity index components Destroyed
