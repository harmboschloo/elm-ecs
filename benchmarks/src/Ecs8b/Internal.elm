module Ecs8b.Internal exposing
    ( ComponentSpec(..)
    , Ecs
    , Entity
    , EntitySpec(..)
    , NodeSpec(..)
    , SystemSpec
    , clear
    , create
    , destroy
    , empty
    , find
    , get
    , getId
    , insert
    , process
    , processor
    , remove
    , set
    , size
    , system
    , update
    )

import Array exposing (Array)



-- MODEL --


type Ecs components
    = Ecs (Model components)


type alias Model components =
    { entities : Array (Maybe components)
    , destroyedEntities : List Int
    }


empty : Ecs components
empty =
    Ecs
        { entities = Array.empty
        , destroyedEntities = []
        }


create :
    EntitySpec components
    -> (Entity components -> Entity components)
    -> Ecs components
    -> ( Entity components, Ecs components )
create (EntitySpec spec) updater (Ecs model) =
    let
        (Entity _ components status) =
            updater (Entity invalidId spec.empty Unmodified)
    in
    case status of
        Unmodified ->
            addEntity components model

        Modified ->
            addEntity components model

        Destroyed ->
            let
                id =
                    Array.length model.entities
            in
            ( Entity id spec.empty Destroyed
            , Ecs
                { entities = Array.push Nothing model.entities
                , destroyedEntities = id :: model.destroyedEntities
                }
            )


addEntity : components -> Model components -> ( Entity components, Ecs components )
addEntity components model =
    case model.destroyedEntities of
        [] ->
            ( Entity (Array.length model.entities) components Unmodified
            , Ecs
                { entities = Array.push (Just components) model.entities
                , destroyedEntities = model.destroyedEntities
                }
            )

        head :: tail ->
            ( Entity head components Unmodified
            , Ecs
                { entities = Array.set head (Just components) model.entities
                , destroyedEntities = tail
                }
            )


insert : Entity components -> Ecs components -> Ecs components
insert (Entity id components status) (Ecs model) =
    case status of
        Unmodified ->
            Ecs model

        Modified ->
            Ecs
                { entities = Array.set id (Just components) model.entities
                , destroyedEntities = model.destroyedEntities
                }

        Destroyed ->
            Ecs
                { entities = Array.set id Nothing model.entities
                , destroyedEntities = id :: model.destroyedEntities
                }


find : Entity components -> Ecs components -> Maybe (Entity components)
find (Entity id _ _) (Ecs model) =
    case Array.get id model.entities of
        Just (Just components) ->
            Just (Entity id components Unmodified)

        _ ->
            Nothing


size : Ecs components -> Int
size (Ecs model) =
    Array.length model.entities - List.length model.destroyedEntities



-- ENTITIES --


type EntitySpec components
    = EntitySpec { empty : components }


type Entity components
    = Entity Int components Status


type Status
    = Unmodified
    | Modified
    | Destroyed


invalidId : Int
invalidId =
    -1


modifyStatus : Status -> Status
modifyStatus status =
    case status of
        Unmodified ->
            Modified

        Modified ->
            Modified

        Destroyed ->
            Destroyed


clear : EntitySpec components -> Entity components -> Entity components
clear (EntitySpec spec) (Entity id components status) =
    Entity id spec.empty (modifyStatus status)


destroy : Entity components -> Entity components
destroy (Entity id components status) =
    Entity id components Destroyed


getId : Entity components -> Int
getId (Entity id _ _) =
    id



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
set (ComponentSpec spec) component (Entity id components status) =
    Entity id
        (spec.setComponent (Just component) components)
        (modifyStatus status)


update :
    ComponentSpec components component
    -> (Maybe component -> Maybe component)
    -> Entity components
    -> Entity components
update (ComponentSpec spec) updater (Entity id components status) =
    Entity id
        (spec.setComponent (updater (spec.getComponent components)) components)
        (modifyStatus status)


remove :
    ComponentSpec components component
    -> Entity components
    -> Entity components
remove (ComponentSpec spec) (Entity id components status) =
    Entity id
        (spec.setComponent Nothing components)
        (modifyStatus status)



-- SYSTEMS --


type SystemSpec components a
    = SystemSpec (SystemSpecModel components a)


type alias SystemSpecModel components a =
    { preProcess : ( Ecs components, a ) -> ( Ecs components, a )
    , process : ( Entity components, a ) -> ( Entity components, a )
    , postProcess : ( Ecs components, a ) -> ( Ecs components, a )
    }


type alias SystemConfig components node a =
    { node : NodeSpec components node
    , preProcess : ( Ecs components, a ) -> ( Ecs components, a )
    , process : node -> ( Entity components, a ) -> ( Entity components, a )
    , postProcess : ( Ecs components, a ) -> ( Ecs components, a )
    }


type NodeSpec components node
    = NodeSpec { getNode : components -> Maybe node }


system : SystemConfig components node a -> SystemSpec components a
system config =
    let
        (NodeSpec nodeSpec) =
            config.node
    in
    SystemSpec
        { preProcess = config.preProcess
        , process =
            \( (Entity _ components _) as entity, a ) ->
                case nodeSpec.getNode components of
                    Nothing ->
                        ( entity, a )

                    Just node ->
                        config.process node ( entity, a )
        , postProcess = config.postProcess
        }


processor :
    NodeSpec components node
    -> (node -> ( Entity components, a ) -> ( Entity components, a ))
    -> SystemSpec components a
processor node doProcess =
    system
        { node = node
        , preProcess = identity
        , process = doProcess
        , postProcess = identity
        }


process :
    List (SystemSpec components a)
    -> ( Ecs components, a )
    -> ( Ecs components, a )
process systems ( ecs1, a1 ) =
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
    (SystemSpecModel components a -> (b -> b))
    -> List (SystemSpec components a)
    -> (b -> b)
compose getter list =
    list
        |> List.map (\(SystemSpec model) -> getter model)
        |> List.foldl (<<) identity


processEntity :
    (( Entity components, a ) -> ( Entity components, a ))
    -> Maybe components
    -> ( Int, Ecs components, a )
    -> ( Int, Ecs components, a )
processEntity doProcess maybeComponents ( id, ecs, a ) =
    case maybeComponents of
        Nothing ->
            ( id + 1, ecs, a )

        Just components ->
            let
                ( newEntity, newX ) =
                    doProcess ( Entity id components Unmodified, a )
            in
            ( id + 1, insert newEntity ecs, newX )
