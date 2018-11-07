module Ecs8.Entity3 exposing
    ( Ecs, empty
    , Entity, create, createWith, destroy, reset, renew, size, activeSize, id
    , set, get, insert, update, remove
    , ComponentSpec, componentSpecs
    , EntityUpdate, nodeUpdate1, nodeUpdate2, nodeUpdate3, updateAll
    )

{-| Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs Entity, create, createWith, destroy, reset, renew, size, activeSize, id


# Components

@docs Components, set, get, insert, update, remove


# Iterate Entities

@docs iterate


# Component Specs

@docs ComponentSpec, componentSpecs


# Node Specs

@docs NodeSpec, nodeSpec1, nodeSpec2, nodeSpec3

-}

-- TODO
-- list (without id?)
-- system update?
-- processAll
-- postProcess (for other entities?)
-- track modified/destroyed in entity

import Array exposing (Array)



-- MODEL --


{-| -}
type Ecs c1 c2 c3
    = Ecs (Model c1 c2 c3)


type alias Model c1 c2 c3 =
    { entities : Array (EntityModel c1 c2 c3)
    , destroyedEntities : List Int
    }


{-| -}
empty : Ecs c1 c2 c3
empty =
    Ecs
        { entities = Array.empty
        , destroyedEntities = []
        }


{-| -}
create : Ecs c1 c2 c3 -> ( Ecs c1 c2 c3, Entity c1 c2 c3 )
create (Ecs model) =
    case model.destroyedEntities of
        [] ->
            ( Ecs
                { entities = Array.push emptyEntityModel model.entities
                , destroyedEntities = model.destroyedEntities
                }
            , Entity (Array.length model.entities) Unmodified emptyEntityModel
            )

        head :: tail ->
            ( Ecs
                { entities = model.entities
                , destroyedEntities = tail
                }
            , Entity head Unmodified emptyEntityModel
            )


{-| -}
createWith : (Entity c1 c2 c3 -> Entity c1 c2 c3) -> Ecs c1 c2 c3 -> ( Ecs c1 c2 c3, Entity c1 c2 c3 )
createWith updater (Ecs model) =
    let
        (Entity _ flags entity) =
            updater (Entity -1 Unmodified emptyEntityModel)
    in
    case model.destroyedEntities of
        [] ->
            ( Ecs
                { entities = Array.push entity model.entities
                , destroyedEntities = model.destroyedEntities
                }
            , Entity (Array.length model.entities) Unmodified emptyEntityModel
            )

        head :: tail ->
            ( Ecs
                { entities = Array.set head entity model.entities
                , destroyedEntities = tail
                }
            , Entity head Unmodified entity
            )


{-| -}
destroy : Entity c1 c2 c3 -> Ecs c1 c2 c3 -> Ecs c1 c2 c3
destroy (Entity entityId _ _) (Ecs model) =
    Ecs
        { entities = Array.set entityId emptyEntityModel model.entities
        , destroyedEntities = entityId :: model.destroyedEntities
        }


{-| -}
reset : Entity c1 c2 c3 -> Ecs c1 c2 c3 -> Ecs c1 c2 c3
reset (Entity entityId _ _) (Ecs model) =
    Ecs
        { entities = Array.set entityId emptyEntityModel model.entities
        , destroyedEntities = model.destroyedEntities
        }


{-| -}
insert : Entity c1 c2 c3 -> Ecs c1 c2 c3 -> Ecs c1 c2 c3
insert (Entity entityId _ entity) (Ecs model) =
    Ecs
        { entities = Array.set entityId entity model.entities
        , destroyedEntities = model.destroyedEntities
        }


{-| -}
renew : Entity c1 c2 c3 -> Ecs c1 c2 c3 -> Entity c1 c2 c3
renew (Entity entityId _ _) (Ecs model) =
    case Array.get entityId model.entities of
        Nothing ->
            Entity entityId Unmodified emptyEntityModel

        Just entity ->
            Entity entityId Unmodified entity


{-| -}
size : Ecs c1 c2 c3 -> Int
size (Ecs model) =
    Array.length model.entities


{-| -}
activeSize : Ecs c1 c2 c3 -> Int
activeSize (Ecs model) =
    Array.length model.entities - List.length model.destroyedEntities



-- ENTITIES --


{-| -}
type
    Entity c1 c2 c3
    -- TODO only use commit to update in ecs, and return new entity (updated flag)
    -- TODO check if Entity gets unwrapped with two parems
    -- otherwise tuple may be better?
    -- TODO destroyed flag
    = Entity Int Flag (EntityModel c1 c2 c3)


type Flag
    = Unmodified
    | Modified


type alias EntityModel c1 c2 c3 =
    { component1 : Maybe c1
    , component2 : Maybe c2
    , component3 : Maybe c3
    }


emptyEntityModel : EntityModel c1 c2 c3
emptyEntityModel =
    { component1 = Nothing
    , component2 = Nothing
    , component3 = Nothing
    }


{-| -}
copy : Entity c1 c2 c3 -> Entity c1 c2 c3 -> Entity c1 c2 c3
copy (Entity _ _ entity) (Entity entityId _ _) =
    Entity entityId Modified entity


{-| -}
clear : Entity c1 c2 c3 -> Entity c1 c2 c3
clear (Entity entityId _ entity) =
    Entity entityId Modified emptyEntityModel


{-| -}
id : Entity c1 c2 c3 -> Int
id (Entity entityId _ _) =
    entityId



-- COMPONENTS --


{-| -}
get :
    Entity c1 c2 c3
    -> ComponentSpec c1 c2 c3 component
    -> Maybe component
get (Entity _ _ entity) (ComponentSpec spec) =
    spec.getComponent entity


{-| -}
set :
    ComponentSpec c1 c2 c3 component
    -> component
    -> Entity c1 c2 c3
    -> Entity c1 c2 c3
set (ComponentSpec spec) component (Entity entityId _ entity) =
    Entity entityId Modified (spec.setComponent (Just component) entity)


{-| -}
update :
    ComponentSpec c1 c2 c3 component
    -> (Maybe component -> Maybe component)
    -> Entity c1 c2 c3
    -> Entity c1 c2 c3
update (ComponentSpec spec) updater (Entity entityId _ entity) =
    Entity
        entityId
        Modified
        (spec.setComponent (updater (spec.getComponent entity)) entity)


{-| -}
remove :
    ComponentSpec c1 c2 c3 component
    -> Entity c1 c2 c3
    -> Entity c1 c2 c3
remove (ComponentSpec spec) (Entity entityId _ entity) =
    Entity entityId Modified (spec.setComponent Nothing entity)



-- UPDATE ENTITIES --


{-| -}
updateAll : EntityUpdate c1 c2 c3 x -> ( Ecs c1 c2 c3, x ) -> ( Ecs c1 c2 c3, x )
updateAll updater ( Ecs model, x ) =
    let
        ( _, newEcs, newX ) =
            Array.foldl
                (updateEntity updater)
                ( 0, Ecs model, x )
                model.entities
    in
    ( newEcs, newX )


updateEntity :
    EntityUpdate c1 c2 c3 x
    -> EntityModel c1 c2 c3
    -> ( Int, Ecs c1 c2 c3, x )
    -> ( Int, Ecs c1 c2 c3, x )
updateEntity updater entity ( entityId, ecs, x ) =
    let
        ( (Entity _ flag _) as newEntity, newEcs, newX ) =
            updater ( Entity entityId Unmodified entity, ecs, x )
    in
    --FIXME can't destroy entity of update through ecs...
    -- destroy through entity flag (destroyed, modified, ...)
    -- of post process ecs updates?
    ( entityId + 1
    , case flag of
        Modified ->
            insert newEntity newEcs

        Unmodified ->
            newEcs
    , newX
    )



-- COMPONENT SPECS --


{-| -}
type ComponentSpec c1 c2 c3 component
    = ComponentSpec
        { getComponent : EntityModel c1 c2 c3 -> Maybe component
        , setComponent :
            Maybe component
            -> EntityModel c1 c2 c3
            -> EntityModel c1 c2 c3
        }


{-| -}
componentSpecs :
    (ComponentSpec c1 c2 c3 c1
     -> ComponentSpec c1 c2 c3 c2
     -> ComponentSpec c1 c2 c3 c3
     -> a
    )
    -> a
componentSpecs createSpecs =
    createSpecs component1Spec component2Spec component3Spec


component1Spec : ComponentSpec c1 c2 c3 c1
component1Spec =
    ComponentSpec
        { getComponent = .component1
        , setComponent =
            \component entity ->
                { component1 = component
                , component2 = entity.component2
                , component3 = entity.component3
                }
        }


component2Spec : ComponentSpec c1 c2 c3 c2
component2Spec =
    ComponentSpec
        { getComponent = .component2
        , setComponent =
            \component entity ->
                { component1 = entity.component1
                , component2 = component
                , component3 = entity.component3
                }
        }


component3Spec : ComponentSpec c1 c2 c3 c3
component3Spec =
    ComponentSpec
        { getComponent = .component3
        , setComponent =
            \component entity ->
                { component1 = entity.component1
                , component2 = entity.component2
                , component3 = component
                }
        }



-- ENTITY UPDATE --


type alias EntityUpdate c1 c2 c3 x =
    ( Entity c1 c2 c3, Ecs c1 c2 c3, x ) -> ( Entity c1 c2 c3, Ecs c1 c2 c3, x )


entityUpdate :
    (EntityModel c1 c2 c3 -> EntityUpdate c1 c2 c3 x)
    -> ( Entity c1 c2 c3, Ecs c1 c2 c3, x )
    -> ( Entity c1 c2 c3, Ecs c1 c2 c3, x )
entityUpdate updater ( Entity entityId flags entity, ecs, x ) =
    updater entity ( Entity entityId flags entity, ecs, x )


nodeUpdate1 :
    (component1 -> node)
    -> ComponentSpec c1 c2 c3 component1
    -> (node -> EntityUpdate c1 c2 c3 x)
    -> EntityUpdate c1 c2 c3 x
nodeUpdate1 createNode (ComponentSpec spec1) updater =
    entityUpdate
        (\entity ->
            case spec1.getComponent entity of
                Nothing ->
                    identity

                Just component1 ->
                    updater
                        (createNode
                            component1
                        )
        )


nodeUpdate2 :
    (component1 -> component2 -> node)
    -> ComponentSpec c1 c2 c3 component1
    -> ComponentSpec c1 c2 c3 component2
    -> (node -> EntityUpdate c1 c2 c3 x)
    -> EntityUpdate c1 c2 c3 x
nodeUpdate2 createNode (ComponentSpec spec1) (ComponentSpec spec2) updater =
    entityUpdate
        (\entity ->
            case spec1.getComponent entity of
                Nothing ->
                    identity

                Just component1 ->
                    case spec2.getComponent entity of
                        Nothing ->
                            identity

                        Just component2 ->
                            updater
                                (createNode
                                    component1
                                    component2
                                )
        )


nodeUpdate3 :
    (component1 -> component2 -> component3 -> node)
    -> ComponentSpec c1 c2 c3 component1
    -> ComponentSpec c1 c2 c3 component2
    -> ComponentSpec c1 c2 c3 component3
    -> (node -> EntityUpdate c1 c2 c3 x)
    -> EntityUpdate c1 c2 c3 x
nodeUpdate3 createNode (ComponentSpec spec1) (ComponentSpec spec2) (ComponentSpec spec3) updater =
    entityUpdate
        (\entity ->
            case spec1.getComponent entity of
                Nothing ->
                    identity

                Just component1 ->
                    case spec2.getComponent entity of
                        Nothing ->
                            identity

                        Just component2 ->
                            case spec3.getComponent entity of
                                Nothing ->
                                    identity

                                Just component3 ->
                                    updater
                                        (createNode
                                            component1
                                            component2
                                            component3
                                        )
        )
