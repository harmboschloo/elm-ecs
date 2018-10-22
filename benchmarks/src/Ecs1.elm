module Ecs1 exposing
    ( Ecs, empty
    , EntityId, create, destroy, reset, size, activeSize, idToInt, intToId
    , ComponentType, get, insert, update, remove
    , iterate, iterate2, iterate3
    , aComponent, bComponent, cComponent
    )

{-| Your Entitiy-Component-System.


# Model

@docs Ecs, empty


# Entities

@docs EntityId, create, destroy, reset, size, activeSize, idToInt, intToId


# Components

@docs ComponentType, get, insert, update, remove


# Iterate Entities

@docs iterate, iterate2, iterate3


# Your Component Types

@docs aComponent, bComponent, cComponent

-}

import Components
import Dict



-- MODEL --


type Ecs
    = Ecs Model


type alias Model =
    { aComponents : Dict.Dict Int Components.A
    , bComponents : Dict.Dict Int Components.B
    , cComponents : Dict.Dict Int Components.C
    , numberOfCreatedEntities : Int
    , destroyedEntities : List Int
    }


empty : Ecs
empty =
    Ecs
        { aComponents = Dict.empty
        , bComponents = Dict.empty
        , cComponents = Dict.empty
        , numberOfCreatedEntities = 0
        , destroyedEntities = []
        }



-- ENTITIES --


type EntityId
    = EntityId Int


create : Ecs -> ( Ecs, EntityId )
create (Ecs model) =
    case model.destroyedEntities of
        [] ->
            ( Ecs { model | numberOfCreatedEntities = model.numberOfCreatedEntities + 1 }
            , EntityId model.numberOfCreatedEntities
            )

        head :: tail ->
            ( Ecs { model | destroyedEntities = tail }
            , EntityId head
            )


destroy : EntityId -> Ecs -> Ecs
destroy (EntityId entityId) (Ecs model) =
    { model | destroyedEntities = entityId :: model.destroyedEntities }
        |> resetEntityComponents entityId
        |> Ecs


reset : EntityId -> Ecs -> Ecs
reset (EntityId entityId) (Ecs model) =
    Ecs (resetEntityComponents entityId model)


resetEntityComponents : Int -> Model -> Model
resetEntityComponents entityId model =
    { model
        | aComponents = Dict.remove entityId model.aComponents
        , bComponents = Dict.remove entityId model.bComponents
        , cComponents = Dict.remove entityId model.cComponents
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


get : EntityId -> ComponentType a -> Ecs -> Maybe a
get (EntityId entityId) (ComponentType { getComponents }) (Ecs model) =
    Dict.get entityId (getComponents model)


insert : EntityId -> ComponentType a -> a -> Ecs -> Ecs
insert (EntityId entityId) (ComponentType type_) component (Ecs model) =
    Ecs
        (type_.setComponents
            (Dict.insert entityId component (type_.getComponents model))
            model
        )


remove : EntityId -> ComponentType a -> Ecs -> Ecs
remove (EntityId entityId) (ComponentType type_) (Ecs model) =
    Ecs
        (type_.setComponents
            (Dict.remove entityId (type_.getComponents model))
            model
        )


update : EntityId -> ComponentType a -> (Maybe a -> Maybe a) -> Ecs -> Ecs
update (EntityId entityId) (ComponentType type_) updater (Ecs model) =
    Ecs
        (type_.setComponents
            (Dict.update entityId updater (type_.getComponents model))
            model
        )



-- ITERATE ENTITIES --


iterate :
    ComponentType a
    -> (EntityId -> a -> ( Ecs, x ) -> ( Ecs, x ))
    -> ( Ecs, x )
    -> ( Ecs, x )
iterate (ComponentType type_) callback ( Ecs model, x ) =
    Dict.foldl
        (EntityId >> callback)
        ( Ecs model, x )
        (type_.getComponents model)


iterate2 :
    ComponentType c1
    -> ComponentType c2
    -> (EntityId -> c1 -> c2 -> ( Ecs, x ) -> ( Ecs, x ))
    -> ( Ecs, x )
    -> ( Ecs, x )
iterate2 (ComponentType type1) (ComponentType type2) callback ( Ecs model, x ) =
    let
        components1 =
            type1.getComponents model

        components2 =
            type2.getComponents model
    in
    Dict.foldl
        (\entityId component1 result ->
            callback (EntityId entityId) component1
                |> next components2 entityId
                |> Maybe.map ((|>) result)
                |> Maybe.withDefault result
        )
        ( Ecs model, x )
        components1


iterate3 :
    ComponentType c1
    -> ComponentType c2
    -> ComponentType c3
    -> (EntityId -> c1 -> c2 -> c3 -> ( Ecs, x ) -> ( Ecs, x ))
    -> ( Ecs, x )
    -> ( Ecs, x )
iterate3 (ComponentType type1) (ComponentType type2) (ComponentType type3) callback ( Ecs model, x ) =
    let
        components1 =
            type1.getComponents model

        components2 =
            type2.getComponents model

        components3 =
            type3.getComponents model
    in
    Dict.foldl
        (\entityId component1 result ->
            callback (EntityId entityId) component1
                |> next components2 entityId
                |> Maybe.andThen (next components3 entityId)
                |> Maybe.map ((|>) result)
                |> Maybe.withDefault result
        )
        ( Ecs model, x )
        components1


next : Dict.Dict Int a -> Int -> (a -> b) -> Maybe b
next components entityId callback =
    Dict.get entityId components |> Maybe.map callback



-- COMPONENT TYPES --


type ComponentType a
    = ComponentType
        { getComponents : Model -> Dict.Dict Int a
        , setComponents : Dict.Dict Int a -> Model -> Model
        }


aComponent : ComponentType Components.A
aComponent =
    ComponentType
        { getComponents = .aComponents
        , setComponents = \components model -> { model | aComponents = components }
        }


bComponent : ComponentType Components.B
bComponent =
    ComponentType
        { getComponents = .bComponents
        , setComponents = \components model -> { model | bComponents = components }
        }


cComponent : ComponentType Components.C
cComponent =
    ComponentType
        { getComponents = .cComponents
        , setComponents = \components model -> { model | cComponents = components }
        }
