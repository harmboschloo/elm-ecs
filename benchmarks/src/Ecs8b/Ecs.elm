module Ecs8b.Ecs exposing
    ( ComponentType
    , Ecs
    , Entity
    , EntityType
    , NodeType
    , System
    , andRemove
    , andSet
    , andUpdate
    , components3
    , create
    , createWith
    , destroy
    , empty
    , entity3
    , get
    , node1
    , node2
    , node3
    , process
    , processor
    , remove
    , set
    , size
    , system
    , update
    )

import Array exposing (Array)



-- TYPES --


type EntityType components
    = EntityType { empty : components }


type ComponentType components component
    = ComponentType
        { getComponent : components -> Maybe component
        , setComponent : Maybe component -> components -> components
        }


type NodeType components node
    = NodeType
        { getNode : components -> Maybe node

        -- TODO, setNode : node -> components -> components
        -- update, remove...
        }


type Ecs components
    = Ecs (Model components)


type alias Model components =
    { all : Array (Maybe components)
    , destroyed : List Int
    , empty : components
    , current : Current components
    }


type alias Current components =
    { id : Int
    , components : components
    , modified : Bool
    }


type Entity
    = Entity Int


type System components a
    = System (SystemModel components a)


type alias SystemModel components a =
    { preProcess : Maybe (( Model components, a ) -> ( Model components, a ))
    , process : Maybe (( Model components, a ) -> ( Model components, a ))
    , postProcess : Maybe (( Model components, a ) -> ( Model components, a ))
    }



-- INITIALIZE --


invalidId : Int
invalidId =
    -1


empty : EntityType components -> Ecs components
empty (EntityType type_) =
    Ecs
        { all = Array.empty
        , destroyed = []
        , empty = type_.empty
        , current =
            { id = invalidId
            , components = type_.empty
            , modified = False
            }
        }



-- TODO fromList, toList
-- ENTITIES --


create : Ecs components -> ( Entity, Ecs components )
create (Ecs model) =
    let
        components =
            model.empty

        ( id, all, destroyed ) =
            case model.destroyed of
                [] ->
                    ( Array.length model.all
                    , Array.push (Just components) model.all
                    , model.destroyed
                    )

                head :: tail ->
                    ( head
                    , model.all
                    , tail
                    )
    in
    ( Entity id
    , Ecs
        { all = insertCurrent model.current all
        , destroyed = destroyed
        , empty = model.empty
        , current =
            { id = id
            , components = components
            , modified = True
            }
        }
    )


createWith :
    (( Entity, Ecs components ) -> ( Entity, Ecs components ))
    -> Ecs components
    -> ( Entity, Ecs components )
createWith builder ecs =
    ecs |> create |> builder


destroy : Entity -> Ecs components -> Ecs components
destroy (Entity id) (Ecs model) =
    case Array.get id model.all of
        Just (Just _) ->
            Ecs
                { all = Array.set id Nothing model.all
                , destroyed = id :: model.destroyed
                , empty = model.empty
                , current =
                    if model.current.id == id then
                        { id = invalidId
                        , components = model.empty
                        , modified = False
                        }

                    else
                        model.current
                }

        _ ->
            Ecs model


size : Ecs components -> Int
size (Ecs model) =
    Array.length model.all - List.length model.destroyed



-- CURRENT --


insertCurrent :
    Current components
    -> Array (Maybe components)
    -> Array (Maybe components)
insertCurrent current all =
    if current.modified then
        Array.set current.id (Just current.components) all

    else
        all


makeCurrent :
    Int
    -> Model components
    -> ( Current components, Array (Maybe components) )
makeCurrent id model =
    if id == model.current.id then
        ( model.current, model.all )

    else
        case Array.get id model.all of
            Just (Just components) ->
                ( { id = id
                  , components = components
                  , modified = False
                  }
                , insertCurrent model.current model.all
                )

            _ ->
                ( { id = invalidId
                  , components = model.empty
                  , modified = False
                  }
                , model.all
                )



-- COMPONENTS --


get :
    ComponentType components component
    -> Entity
    -> Ecs components
    -> Maybe component
get (ComponentType type_) (Entity id) (Ecs model) =
    if model.current.id == id then
        type_.getComponent model.current.components

    else
        case Array.get id model.all of
            Just (Just components) ->
                type_.getComponent components

            _ ->
                Nothing


set :
    ComponentType components component
    -> component
    -> Entity
    -> Ecs components
    -> Ecs components
set (ComponentType type_) component (Entity id) (Ecs model) =
    let
        ( current, all ) =
            makeCurrent id model
    in
    Ecs
        { all = all
        , destroyed = model.destroyed
        , empty = model.empty
        , current =
            { id = current.id
            , components =
                type_.setComponent (Just component) current.components
            , modified = True
            }
        }


update :
    ComponentType components component
    -> (Maybe component -> Maybe component)
    -> Entity
    -> Ecs components
    -> Ecs components
update (ComponentType type_) updater (Entity id) (Ecs model) =
    let
        ( current, all ) =
            makeCurrent id model
    in
    Ecs
        { all = all
        , destroyed = model.destroyed
        , empty = model.empty
        , current =
            { id = current.id
            , components =
                type_.setComponent
                    (updater (type_.getComponent current.components))
                    current.components
            , modified = True
            }
        }


remove :
    ComponentType components component
    -> Entity
    -> Ecs components
    -> Ecs components
remove (ComponentType type_) (Entity id) (Ecs model) =
    let
        ( current, all ) =
            makeCurrent id model
    in
    Ecs
        { all = all
        , destroyed = model.destroyed
        , empty = model.empty
        , current =
            { id = current.id
            , components = type_.setComponent Nothing current.components
            , modified = True
            }
        }


andSet :
    ComponentType components component
    -> component
    -> ( Entity, Ecs components )
    -> ( Entity, Ecs components )
andSet type_ component ( entity, ecs ) =
    ( entity, set type_ component entity ecs )


andUpdate :
    ComponentType components component
    -> (Maybe component -> Maybe component)
    -> ( Entity, Ecs components )
    -> ( Entity, Ecs components )
andUpdate type_ updater ( entity, ecs ) =
    ( entity, update type_ updater entity ecs )


andRemove :
    ComponentType components component
    -> ( Entity, Ecs components )
    -> ( Entity, Ecs components )
andRemove type_ ( entity, ecs ) =
    ( entity, remove type_ entity ecs )



-- NODES --
-- getNode, setNode, removeNode, andSetNode, andRemoveNode
-- SYSTEMS --


system :
    { preProcess : Maybe (Ecs components -> a -> ( Ecs components, a ))
    , process :
        Maybe ( NodeType components node, node -> Entity -> Ecs components -> a -> ( Ecs components, a ) )
    , postProcess : Maybe (Ecs components -> a -> ( Ecs components, a ))
    }
    -> System components a
system config =
    System
        { preProcess = Maybe.map mapPreOrPostProcess config.preProcess
        , process = Maybe.map mapProcess config.process
        , postProcess = Maybe.map mapPreOrPostProcess config.postProcess
        }


processor :
    NodeType components node
    -> (node -> Entity -> Ecs components -> a -> ( Ecs components, a ))
    -> System components a
processor node fn =
    system
        { preProcess = Nothing
        , process = Just ( node, fn )
        , postProcess = Nothing
        }


mapPreOrPostProcess :
    (Ecs components -> a -> ( Ecs components, a ))
    -> (( Model components, a ) -> ( Model components, a ))
mapPreOrPostProcess fn =
    \( model1, a1 ) ->
        let
            ( Ecs model2, a2 ) =
                fn (Ecs model1) a1
        in
        ( model2, a2 )


mapProcess :
    ( NodeType components node, node -> Entity -> Ecs components -> a -> ( Ecs components, a ) )
    -> (( Model components, a ) -> ( Model components, a ))
mapProcess ( NodeType type_, fn ) =
    \( model1, a1 ) ->
        case type_.getNode model1.current.components of
            Nothing ->
                ( model1, a1 )

            Just node ->
                let
                    ( Ecs model2, a2 ) =
                        fn node (Entity model1.current.id) (Ecs model1) a1

                    ( current, all ) =
                        makeCurrent model1.current.id model2
                in
                ( { all = all
                  , destroyed = model2.destroyed
                  , empty = model2.empty
                  , current = current
                  }
                , a2
                )


process :
    List (System components a)
    -> ( Ecs components, a )
    -> ( Ecs components, a )
process systems ( Ecs model1, a1 ) =
    let
        doPreProcess =
            compose .preProcess systems

        doProcess =
            compose .process systems

        doPostProcess =
            compose .postProcess systems

        ( model2, a2 ) =
            doPreProcess ( model1, a1 )

        ( _, model3, a3 ) =
            Array.foldl
                (\components state -> processEntity doProcess components state)
                ( 0, model2, a2 )
                model2.all

        ( model4, a4 ) =
            doPostProcess ( model3, a3 )
    in
    ( Ecs model4, a4 )


compose :
    (SystemModel components a -> Maybe (b -> b))
    -> List (System components a)
    -> (b -> b)
compose getter list =
    list
        |> List.filterMap (\(System model) -> getter model)
        |> List.foldl (<<) identity


processEntity :
    (( Model components, a ) -> ( Model components, a ))
    -> Maybe components
    -> ( Int, Model components, a )
    -> ( Int, Model components, a )
processEntity doProcess maybeComponents ( id, model1, a1 ) =
    case maybeComponents of
        Nothing ->
            ( id + 1, model1, a1 )

        Just components ->
            let
                ( model2, a2 ) =
                    doProcess
                        ( { all = insertCurrent model1.current model1.all
                          , destroyed = model1.destroyed
                          , empty = model1.empty
                          , current =
                                { id = id
                                , components = components
                                , modified = False
                                }
                          }
                        , a1
                        )
            in
            ( id + 1, model2, a2 )



-- TYPES 1 --


{-| Create a NodeType with 1 component.
-}
node1 :
    (component1 -> node)
    -> ComponentType components component1
    -> NodeType components node
node1 createNode (ComponentType type1) =
    NodeType
        { getNode =
            \components ->
                case type1.getComponent components of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        Just
                            (createNode
                                component1
                            )
        }



-- TYPES 2 --


{-| Create a NodeType with 2 components.
-}
node2 :
    (component1 -> component2 -> node)
    -> ComponentType components component1
    -> ComponentType components component2
    -> NodeType components node
node2 createNode (ComponentType type1) (ComponentType type2) =
    NodeType
        { getNode =
            \components ->
                case type1.getComponent components of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        case type2.getComponent components of
                            Nothing ->
                                Nothing

                            Just component2 ->
                                Just
                                    (createNode
                                        component1
                                        component2
                                    )
        }



-- TYPES 3 --


{-| -}
entity3 :
    (Maybe component1 -> Maybe component2 -> Maybe component3 -> components)
    -> EntityType components
entity3 createComponents =
    EntityType { empty = createComponents Nothing Nothing Nothing }


{-| -}
components3 :
    (ComponentType components component1 -> ComponentType components component2 -> ComponentType components component3 -> componentTypes)
    -> (Maybe component1 -> Maybe component2 -> Maybe component3 -> components)
    -> (components -> Maybe component1)
    -> (components -> Maybe component2)
    -> (components -> Maybe component3)
    -> componentTypes
components3 createComponentTypes createComponents get1 get2 get3 =
    createComponentTypes
        (ComponentType
            { getComponent = get1
            , setComponent =
                \component components ->
                    createComponents
                        component
                        (get2 components)
                        (get3 components)
            }
        )
        (ComponentType
            { getComponent = get2
            , setComponent =
                \component components ->
                    createComponents
                        (get1 components)
                        component
                        (get3 components)
            }
        )
        (ComponentType
            { getComponent = get3
            , setComponent =
                \component components ->
                    createComponents
                        (get1 components)
                        (get2 components)
                        component
            }
        )


{-| Create a node with 3 components.
-}
node3 :
    (component1 -> component2 -> component3 -> node)
    -> ComponentType components component1
    -> ComponentType components component2
    -> ComponentType components component3
    -> NodeType components node
node3 createNode (ComponentType type1) (ComponentType type2) (ComponentType type3) =
    NodeType
        { getNode =
            \components ->
                case type1.getComponent components of
                    Nothing ->
                        Nothing

                    Just component1 ->
                        case type2.getComponent components of
                            Nothing ->
                                Nothing

                            Just component2 ->
                                case type3.getComponent components of
                                    Nothing ->
                                        Nothing

                                    Just component3 ->
                                        Just
                                            (createNode
                                                component1
                                                component2
                                                component3
                                            )
        }
