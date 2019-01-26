module V2W.Ecs exposing
    ( ComponentConfig, ComponentSpec
    , componentSpecsStart, componentSpec, componentSpecsEnd
    , Ecs, empty
    , EntityId, create, destroy, member, entityCount
    , ComponentEntry, entry, insertAll, insertEntry
    , insert, update, remove, get, getAll, has
    , componentCount, totalComponentCount
    , select, selectAll
    , apply
    )

{-|

@docs ComponentConfig, ComponentSpec
@docs componentSpecsStart, componentSpec, componentSpecsEnd
@docs Ecs, empty
@docs EntityId, create, destroy, member, entityCount
@docs ComponentEntry, entry, insertAll, insertEntry
@docs insert, update, remove, get, getAll, has
@docs componentCount, totalComponentCount
@docs select, selectAll
@docs apply

-}

import Array exposing (Array)
import Dict exposing (Dict)
import Set
import V2W.Ecs.Internal as Internal exposing (Model, Operation(..), Selector(..))



-- COMPONENT SPECS --


type alias ComponentConfig data a =
    { wrap : a -> data
    , unwrap : data -> Maybe a
    }


type alias ComponentSpec data a =
    Internal.ComponentSpec data a


type ComponentSpecsBuilder specs
    = ComponentSpecsBuilder ( Int, specs )


componentSpecsStart : specs -> ComponentSpecsBuilder specs
componentSpecsStart fn =
    ComponentSpecsBuilder ( 0, fn )


componentSpec :
    ComponentConfig data a
    -> ComponentSpecsBuilder (ComponentSpec data a -> specs)
    -> ComponentSpecsBuilder specs
componentSpec config (ComponentSpecsBuilder ( id, fn )) =
    ComponentSpecsBuilder
        ( id + 1
        , fn
            (Internal.ComponentSpec
                { id = id + 1
                , wrap = config.wrap
                , unwrap = config.unwrap
                }
            )
        )


componentSpecsEnd : ComponentSpecsBuilder specs -> specs
componentSpecsEnd (ComponentSpecsBuilder ( id, fn )) =
    fn



-- ECS --


type alias Ecs data =
    Internal.Ecs data


empty : Ecs data
empty =
    Internal.Ecs
        { containers = Array.empty
        , nextId = 0
        , activeIds = Set.empty
        }



-- ENTITY --


type alias EntityId =
    Internal.EntityId


create : List (ComponentEntry data) -> Ecs data -> ( Ecs data, EntityId )
create entries (Internal.Ecs model) =
    let
        entityId =
            model.nextId
    in
    ( Internal.Ecs
        { containers = model.containers
        , nextId = entityId + 1
        , activeIds = Set.insert entityId model.activeIds
        }
        |> insertComponentEntries entityId entries
    , Internal.EntityId entityId
    )


destroy : EntityId -> Ecs data -> Ecs data
destroy (Internal.EntityId entityId) (Internal.Ecs model) =
    Internal.Ecs
        { containers = Array.map (Dict.remove entityId) model.containers
        , nextId = model.nextId
        , activeIds = Set.remove entityId model.activeIds
        }


member : EntityId -> Ecs data -> Bool
member (Internal.EntityId entityId) (Internal.Ecs model) =
    Set.member entityId model.activeIds


entityCount : Ecs data -> Int
entityCount (Internal.Ecs model) =
    Set.size model.activeIds



-- COMPONENT ENTRY --


type alias ComponentEntry data =
    Internal.ComponentEntry data


entry : ComponentSpec data a -> a -> ComponentEntry data
entry (Internal.ComponentSpec spec) value =
    Internal.ComponentEntry
        { id = spec.id
        , data = spec.wrap value
        }


insertAll : EntityId -> List (ComponentEntry data) -> Ecs data -> Ecs data
insertAll (Internal.EntityId entityId) entries ecs =
    if member (Internal.EntityId entityId) ecs then
        insertComponentEntries entityId entries ecs

    else
        ecs


insertEntry : EntityId -> ComponentEntry data -> Ecs data -> Ecs data
insertEntry (Internal.EntityId entityId) componentEntry ecs =
    if member (Internal.EntityId entityId) ecs then
        insertComponentEntry entityId componentEntry ecs

    else
        ecs


insertComponentEntries :
    Int
    -> List (ComponentEntry data)
    -> Ecs data
    -> Ecs data
insertComponentEntries entityId entries ecs =
    List.foldl (insertComponentEntry entityId) ecs entries


insertComponentEntry : Int -> ComponentEntry data -> Ecs data -> Ecs data
insertComponentEntry entityId (Internal.ComponentEntry componentEntry) ecs =
    updateComponents
        componentEntry.id
        (Dict.insert entityId componentEntry.data)
        ecs



-- COMPONENTS --


insert : ComponentSpec data a -> EntityId -> a -> Ecs data -> Ecs data
insert (Internal.ComponentSpec spec) (Internal.EntityId entityId) value ecs =
    if member (Internal.EntityId entityId) ecs then
        updateComponents spec.id (Dict.insert entityId (spec.wrap value)) ecs

    else
        ecs


update :
    ComponentSpec data a
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> Ecs data
    -> Ecs data
update (Internal.ComponentSpec spec) (Internal.EntityId entityId) fn ecs =
    if member (Internal.EntityId entityId) ecs then
        updateComponents
            spec.id
            (Dict.update
                entityId
                (Maybe.andThen spec.unwrap >> fn >> Maybe.map spec.wrap)
            )
            ecs

    else
        ecs


remove : ComponentSpec data a -> EntityId -> Ecs data -> Ecs data
remove (Internal.ComponentSpec spec) entityId ecs =
    removeComponent entityId spec.id ecs


removeComponent : EntityId -> Int -> Ecs data -> Ecs data
removeComponent (Internal.EntityId entityId) componentId (Internal.Ecs model) =
    case Array.get componentId model.containers of
        Just components ->
            Internal.Ecs
                { containers =
                    Array.set
                        componentId
                        (Dict.remove entityId components)
                        model.containers
                , nextId = model.nextId
                , activeIds = model.activeIds
                }

        Nothing ->
            Internal.Ecs model


get : ComponentSpec data a -> EntityId -> Ecs data -> Maybe a
get (Internal.ComponentSpec spec) (Internal.EntityId entityId) (Internal.Ecs model) =
    case Array.get spec.id model.containers of
        Just components ->
            Dict.get entityId components
                |> Maybe.andThen spec.unwrap

        Nothing ->
            Nothing


getAll : ComponentSpec data a -> Ecs data -> List ( EntityId, a )
getAll (Internal.ComponentSpec spec) (Internal.Ecs model) =
    case Array.get spec.id model.containers of
        Just components ->
            Dict.foldr
                (\entityId data list ->
                    case spec.unwrap data of
                        Just value ->
                            ( Internal.EntityId entityId, value ) :: list

                        Nothing ->
                            list
                )
                []
                components

        Nothing ->
            []


has : ComponentSpec data a -> EntityId -> Ecs data -> Bool
has (Internal.ComponentSpec spec) (Internal.EntityId entityId) (Internal.Ecs model) =
    case Array.get spec.id model.containers of
        Just components ->
            Dict.member entityId components

        Nothing ->
            False


componentCount : ComponentSpec data a -> Ecs data -> Int
componentCount (Internal.ComponentSpec spec) (Internal.Ecs model) =
    case Array.get spec.id model.containers of
        Just components ->
            Dict.size components

        Nothing ->
            0


totalComponentCount : Ecs data -> Int
totalComponentCount (Internal.Ecs model) =
    Array.foldl
        (\components count -> count + Dict.size components)
        0
        model.containers


updateComponents :
    Int
    -> (Dict Int data -> Dict Int data)
    -> Ecs data
    -> Ecs data
updateComponents componentId fn (Internal.Ecs model) =
    case Array.get componentId model.containers of
        Just components ->
            Internal.Ecs
                { containers =
                    Array.set componentId (fn components) model.containers
                , nextId = model.nextId
                , activeIds = model.activeIds
                }

        Nothing ->
            Internal.Ecs
                { containers =
                    Array.set
                        componentId
                        (fn Dict.empty)
                        (growArrayTo
                            (componentId + 1)
                            Dict.empty
                            model.containers
                        )
                , nextId = model.nextId
                , activeIds = model.activeIds
                }


growArrayTo : Int -> a -> Array a -> Array a
growArrayTo length value array =
    Array.append array (Array.repeat (length - Array.length array) value)



-- APPLY SELECTORS --


{-| Get a specific set of components of an entity.
-}
select : Selector data a -> EntityId -> Ecs data -> Maybe a
select (Selector selector) (Internal.EntityId entityId) (Internal.Ecs model) =
    selector.select entityId model


{-| Get all entities with a specific set of components.
-}
selectAll : Selector data a -> Ecs data -> List ( EntityId, a )
selectAll (Selector selector) (Internal.Ecs model) =
    selector.selectList model



-- APPLY OPERATIONS --


apply : Operation data -> Ecs data -> Ecs data
apply operation ecs =
    case operation of
        Create entries ->
            create entries ecs |> Tuple.first

        Destroy entityId ->
            destroy entityId ecs

        InsertAll entityId entries ->
            insertAll entityId entries ecs

        Insert entityId componentEntry ->
            insertEntry entityId componentEntry ecs

        Remove entityId componentId ->
            removeComponent entityId componentId ecs
