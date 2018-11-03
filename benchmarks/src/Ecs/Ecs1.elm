module Ecs.Ecs1 exposing
    ( Ecs, empty
    , EntityId, create, size, activeSize, idToInt, intToId
    , Components, get, insert, update, remove
    , iterate, iterate2, iterate3
    , Specs, ContainerSpec, ComponentSpec
    , specs3
    )

{-| Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, create, destroy, reset, size, activeSize, idToInt, intToId


# Components

@docs Components, get, insert, update, remove


# Iterate Entities

@docs iterate, iterate2, iterate3


# Specs

@docs Specs, ContainerSpec, ComponentSpec
@docs spec3

-}

import Dict exposing (Dict)



-- MODEL --


{-| -}
type Ecs container
    = Ecs (Model container)


type alias Model container =
    { container : container
    , numberOfCreatedEntities : Int
    , destroyedEntities : List Int
    }


{-| -}
empty : ContainerSpec container -> Ecs container
empty (ContainerSpec spec) =
    from spec.empty


from : container -> Ecs container
from container =
    Ecs
        { container = container
        , numberOfCreatedEntities = 0
        , destroyedEntities = []
        }



-- ENTITIES --


{-| -}
type EntityId
    = EntityId Int


{-| -}
create : Ecs container -> ( Ecs container, EntityId )
create (Ecs model) =
    case model.destroyedEntities of
        [] ->
            ( Ecs
                { container = model.container
                , numberOfCreatedEntities = model.numberOfCreatedEntities + 1
                , destroyedEntities = model.destroyedEntities
                }
            , EntityId model.numberOfCreatedEntities
            )

        head :: tail ->
            ( Ecs
                { container = model.container
                , numberOfCreatedEntities = model.numberOfCreatedEntities
                , destroyedEntities = tail
                }
            , EntityId head
            )


{-| -}
destroy : ContainerSpec container -> EntityId -> Ecs container -> Ecs container
destroy (ContainerSpec spec) (EntityId entityId) (Ecs model) =
    Ecs
        { container = spec.removeEntity entityId model.container
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = entityId :: model.destroyedEntities
        }


{-| -}
reset : ContainerSpec container -> EntityId -> Ecs container -> Ecs container
reset (ContainerSpec spec) (EntityId entityId) (Ecs model) =
    Ecs
        { container = spec.removeEntity entityId model.container
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = model.destroyedEntities
        }


{-| -}
size : Ecs container -> Int
size (Ecs model) =
    model.numberOfCreatedEntities


{-| -}
activeSize : Ecs container -> Int
activeSize (Ecs model) =
    model.numberOfCreatedEntities - List.length model.destroyedEntities


{-| -}
idToInt : EntityId -> Int
idToInt (EntityId id) =
    id


{-| -}
intToId : Int -> Ecs container -> Maybe EntityId
intToId id ecs =
    if id < size ecs then
        Just (EntityId id)

    else
        Nothing



-- COMPONENTS --


{-| -}
type Components component
    = Components (Dict Int component)


emptyComponents : Components a
emptyComponents =
    Components Dict.empty


{-| -}
get :
    EntityId
    -> ComponentSpec container component
    -> Ecs container
    -> Maybe component
get (EntityId entityId) (ComponentSpec spec) (Ecs model) =
    getComponent entityId (spec.getComponents model.container)


getComponent : Int -> Components component -> Maybe component
getComponent entityId (Components components) =
    Dict.get entityId components


{-| -}
insert :
    EntityId
    -> ComponentSpec container component
    -> component
    -> Ecs container
    -> Ecs container
insert (EntityId entityId) (ComponentSpec spec) component (Ecs model) =
    Ecs
        { container =
            spec.updateComponents
                (insertComponent entityId component)
                model.container
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = model.destroyedEntities
        }


insertComponent :
    Int
    -> component
    -> Components component
    -> Components component
insertComponent entityId component (Components components) =
    Components (Dict.insert entityId component components)


{-| -}
update :
    EntityId
    -> ComponentSpec container component
    -> (Maybe component -> Maybe component)
    -> Ecs container
    -> Ecs container
update (EntityId entityId) (ComponentSpec spec) updater (Ecs model) =
    Ecs
        { container =
            spec.updateComponents
                (updateComponent entityId updater)
                model.container
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = model.destroyedEntities
        }


updateComponent :
    Int
    -> (Maybe component -> Maybe component)
    -> Components component
    -> Components component
updateComponent entityId updater (Components components) =
    Components (Dict.update entityId updater components)


{-| -}
remove :
    EntityId
    -> ComponentSpec container component
    -> Ecs container
    -> Ecs container
remove (EntityId entityId) (ComponentSpec spec) (Ecs model) =
    Ecs
        { container =
            spec.updateComponents
                (removeComponent entityId)
                model.container
        , numberOfCreatedEntities = model.numberOfCreatedEntities
        , destroyedEntities = model.destroyedEntities
        }


removeComponent : Int -> Components component -> Components component
removeComponent entityId (Components components) =
    Components (Dict.remove entityId components)



-- ITERATE ENTITIES --


{-| -}
iterate :
    ComponentSpec container component
    -> (EntityId -> component -> ( Ecs container, x ) -> ( Ecs container, x ))
    -> ( Ecs container, x )
    -> ( Ecs container, x )
iterate (ComponentSpec spec) callback ( Ecs model, x ) =
    let
        (Components components) =
            spec.getComponents model.container
    in
    Dict.foldl
        (EntityId >> callback)
        ( Ecs model, x )
        components


{-| -}
iterate2 :
    ComponentSpec container component1
    -> ComponentSpec container component2
    -> (EntityId -> component1 -> component2 -> ( Ecs container, x ) -> ( Ecs container, x ))
    -> ( Ecs container, x )
    -> ( Ecs container, x )
iterate2 (ComponentSpec componentSpec1) (ComponentSpec componentSpec2) callback ( Ecs model, x ) =
    let
        (Components components1) =
            componentSpec1.getComponents model.container

        (Components components2) =
            componentSpec2.getComponents model.container
    in
    Dict.foldl
        (\entityId component1 result ->
            callback (EntityId entityId) component1
                |> next entityId components2
                |> Maybe.map ((|>) result)
                |> Maybe.withDefault result
        )
        ( Ecs model, x )
        components1


{-| -}
iterate3 :
    ComponentSpec container component1
    -> ComponentSpec container component2
    -> ComponentSpec container component3
    -> (EntityId -> component1 -> component2 -> component3 -> ( Ecs container, x ) -> ( Ecs container, x ))
    -> ( Ecs container, x )
    -> ( Ecs container, x )
iterate3 (ComponentSpec componentSpec1) (ComponentSpec componentSpec2) (ComponentSpec componentSpec3) callback ( Ecs model, x ) =
    let
        (Components components1) =
            componentSpec1.getComponents model.container

        (Components components2) =
            componentSpec2.getComponents model.container

        (Components components3) =
            componentSpec3.getComponents model.container
    in
    Dict.foldl
        (\entityId component1 result ->
            callback (EntityId entityId) component1
                |> next entityId components2
                |> Maybe.andThen (next entityId components3)
                |> Maybe.map ((|>) result)
                |> Maybe.withDefault result
        )
        ( Ecs model, x )
        components1


next : Int -> Dict Int component -> (component -> a) -> Maybe a
next entityId components callback =
    Dict.get entityId components |> Maybe.map callback



-- SPECS --


{-| -}
type alias Specs container componentSpecs =
    { container : ContainerSpec container
    , components : componentSpecs
    }


{-| -}
type ContainerSpec container
    = ContainerSpec
        { empty : container
        , removeEntity : Int -> container -> container
        }


{-| -}
type ComponentSpec container component
    = ComponentSpec
        { getComponents : container -> Components component
        , updateComponents :
            (Components component -> Components component)
            -> container
            -> container
        }


{-| -}
specs3 :
    (Components component1 -> Components component2 -> Components component3 -> container)
    -> (ComponentSpec container component1 -> ComponentSpec container component2 -> ComponentSpec container component3 -> componentSpecs)
    -> (container -> Components component1)
    -> (container -> Components component2)
    -> (container -> Components component3)
    -> Specs container componentSpecs
specs3 createContainer createComponentSpecs get1 get2 get3 =
    { container =
        ContainerSpec
            { empty =
                createContainer
                    emptyComponents
                    emptyComponents
                    emptyComponents
            , removeEntity =
                \entityId container ->
                    createContainer
                        (get1 container |> removeComponent entityId)
                        (get2 container |> removeComponent entityId)
                        (get3 container |> removeComponent entityId)
            }
    , components =
        createComponentSpecs
            (ComponentSpec
                { getComponents = get1
                , updateComponents =
                    \updater container ->
                        createContainer
                            (get1 container |> updater)
                            (get2 container)
                            (get3 container)
                }
            )
            (ComponentSpec
                { getComponents = get2
                , updateComponents =
                    \updater container ->
                        createContainer
                            (get1 container)
                            (get2 container |> updater)
                            (get3 container)
                }
            )
            (ComponentSpec
                { getComponents = get3
                , updateComponents =
                    \updater container ->
                        createContainer
                            (get1 container)
                            (get2 container)
                            (get3 container |> updater)
                }
            )
    }
