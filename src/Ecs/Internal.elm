module Ecs.Internal exposing
    ( ComponentSpec(..)
    , Ecs
    , Entity
    , EntitySpec(..)
    , NodeSpec(..)
    , SystemSpec
    , activeSize
    , checkout
    , clear
    , commit
    , copy
    , create
    , destroy
    , empty
    , get
    , getId
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
    { entities : Array (EntityData components)
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
        (Entity _ ( data, status )) =
            updater (Entity invalidId ( spec.empty, Unmodified ))
    in
    case status of
        Unmodified ->
            addEntity ( data, Unmodified ) model

        Modified ->
            addEntity ( data, Unmodified ) model

        Destroyed ->
            let
                id =
                    Array.length model.entities
            in
            ( Entity id ( data, Destroyed )
            , Ecs
                { entities = Array.push ( data, Destroyed ) model.entities
                , destroyedEntities = id :: model.destroyedEntities
                }
            )


addEntity :
    EntityData components
    -> Model components
    -> ( Entity components, Ecs components )
addEntity data model =
    case model.destroyedEntities of
        [] ->
            ( Entity (Array.length model.entities) data
            , Ecs
                { entities = Array.push data model.entities
                , destroyedEntities = model.destroyedEntities
                }
            )

        head :: tail ->
            ( Entity head data
            , Ecs
                { entities = Array.set head data model.entities
                , destroyedEntities = tail
                }
            )


commit :
    ( Entity components, Ecs components )
    -> ( Entity components, Ecs components )
commit ( Entity id ( data, status ), Ecs model ) =
    case status of
        Unmodified ->
            ( Entity id ( data, status ), Ecs model )

        Modified ->
            ( Entity id ( data, Unmodified )
            , Ecs
                { entities = Array.set id ( data, Unmodified ) model.entities
                , destroyedEntities = model.destroyedEntities
                }
            )

        Destroyed ->
            ( Entity id ( data, status )
            , Ecs
                { entities = Array.set id ( data, status ) model.entities
                , destroyedEntities = id :: model.destroyedEntities
                }
            )


checkout : Entity components -> Ecs components -> Entity components
checkout (Entity id data) (Ecs model) =
    case Array.get id model.entities of
        Nothing ->
            Entity id data

        Just newData ->
            Entity id newData


size : Ecs components -> Int
size (Ecs model) =
    Array.length model.entities


activeSize : Ecs components -> Int
activeSize (Ecs model) =
    Array.length model.entities - List.length model.destroyedEntities



-- ENTITIES --


type EntitySpec components
    = EntitySpec { empty : components }


type Entity components
    = Entity Int (EntityData components)


type alias EntityData components =
    ( components, Status )


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


copy : Entity components -> Entity components -> Entity components
copy (Entity _ ( data, _ )) (Entity id ( _, status )) =
    Entity id ( data, modifyStatus status )


clear : EntitySpec components -> Entity components -> Entity components
clear (EntitySpec spec) (Entity id ( _, status )) =
    Entity id ( spec.empty, modifyStatus status )


destroy : Entity components -> Entity components
destroy (Entity id ( data, status )) =
    Entity id ( data, Destroyed )


getId : Entity components -> Int
getId (Entity id _) =
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
get (ComponentSpec spec) (Entity _ ( data, _ )) =
    spec.getComponent data


set :
    ComponentSpec components component
    -> component
    -> Entity components
    -> Entity components
set (ComponentSpec spec) component (Entity id ( data, status )) =
    Entity id
        ( spec.setComponent (Just component) data
        , modifyStatus status
        )


update :
    ComponentSpec components component
    -> (Maybe component -> Maybe component)
    -> Entity components
    -> Entity components
update (ComponentSpec spec) updater (Entity id ( data, status )) =
    Entity id
        ( spec.setComponent (updater (spec.getComponent data)) data
        , modifyStatus status
        )


remove :
    ComponentSpec components component
    -> Entity components
    -> Entity components
remove (ComponentSpec spec) (Entity id ( data, status )) =
    Entity id
        ( spec.setComponent Nothing data
        , modifyStatus status
        )



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
            \( (Entity id ( data, status )) as entity, a ) ->
                case nodeSpec.getNode data of
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
                (\data state -> processEntity doProcess data state)
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
    -> EntityData components
    -> ( Int, Ecs components, a )
    -> ( Int, Ecs components, a )
processEntity doProcess ( data, status ) ( id, ecs, a ) =
    case status of
        Unmodified ->
            let
                ( newEntity, newX ) =
                    doProcess ( Entity id ( data, status ), a )

                ( _, newEcs ) =
                    commit ( newEntity, ecs )
            in
            ( id + 1, newEcs, newX )

        _ ->
            ( id + 1, ecs, a )
