module Ecs exposing
    ( Ecs, EntityId, ComponentSpecs, ComponentSpec
    , empty, isEmpty, entityCount, componentCount, ids
    , member, clear
    , has, get, insert, update, remove
    , select, selectList, process
    , Selector, component, select1, select2, select3, select4, select5
    , andGet, andThen, andHas, andNot, andFilter
    )

{-|

@docs Ecs, EntityId, ComponentSpecs, ComponentSpec
@docs empty, isEmpty, entityCount, componentCount, ids
@docs member, clear
@docs has, get, insert, update, remove
@docs select, selectList, process
@docs Selector, component, select1, select2, select3, select4, select5
@docs andGet, andThen, andHas, andNot, andFilter

-}

import Components
    exposing
        ( Ai
        , KeyControlsMap
        , Motion
        , Position
        , Scale
        , ScaleAnimation
        , Sprite
        , Velocity
        )
import Components.CollisionShape exposing (CollisionShape)
import Components.Controls exposing (Controls)
import Components.DelayedOperations exposing (DelayedOperations)
import Ecs.Api
import Ecs.Spec
import Set exposing (Set)



-- SPEC --


{-| -}
type alias EntityId =
    Int


{-| -}
type alias ComponentSpecs =
    { ai : ComponentSpec Ai
    , collisionShape : ComponentSpec CollisionShape
    , controls : ComponentSpec Controls
    , delayedOperations : ComponentSpec DelayedOperations
    , keyControlsMap : ComponentSpec KeyControlsMap
    , motion : ComponentSpec Motion
    , position : ComponentSpec Position
    , scale : ComponentSpec Scale
    , scaleAnimation : ComponentSpec ScaleAnimation
    , sprite : ComponentSpec Sprite
    , velocity : ComponentSpec Velocity
    }


{-| -}
type alias ComponentSpec a =
    Ecs.Spec.ComponentSpec EntityId Ecs a


{-| -}
type alias Ecs =
    Ecs.Spec.Ecs11 EntityId Ai CollisionShape Controls DelayedOperations KeyControlsMap Motion Position Scale ScaleAnimation Sprite Velocity


spec : Ecs.Spec.Spec ComponentSpecs EntityId Ecs
spec =
    Ecs.Spec.spec11 ComponentSpecs



-- MODEL --


{-| -}
empty : Ecs
empty =
    Ecs.Api.empty spec


{-| -}
isEmpty : Ecs -> Bool
isEmpty =
    Ecs.Api.isEmpty spec


{-| -}
entityCount : Ecs -> Int
entityCount =
    Ecs.Api.entityCount spec


{-| -}
componentCount : Ecs -> Int
componentCount =
    Ecs.Api.componentCount spec


{-| -}
ids : Ecs -> Set EntityId
ids =
    Ecs.Api.ids spec



-- ENTITY --


{-| -}
member : EntityId -> Ecs -> Bool
member =
    Ecs.Api.member spec


{-| -}
clear : EntityId -> Ecs -> Ecs
clear =
    Ecs.Api.clear spec



-- COMPONENTS --


{-| -}
has : (ComponentSpecs -> ComponentSpec a) -> EntityId -> Ecs -> Bool
has =
    Ecs.Api.has spec


{-| -}
get : (ComponentSpecs -> ComponentSpec a) -> EntityId -> Ecs -> Maybe a
get =
    Ecs.Api.get spec


{-| -}
insert : (ComponentSpecs -> ComponentSpec a) -> EntityId -> a -> Ecs -> Ecs
insert =
    Ecs.Api.insert spec


{-| -}
update :
    (ComponentSpecs -> ComponentSpec a)
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> Ecs
    -> Ecs
update =
    Ecs.Api.update spec


{-| -}
remove : (ComponentSpecs -> ComponentSpec a) -> EntityId -> Ecs -> Ecs
remove =
    Ecs.Api.remove spec



-- APPLY SELECTORS --


{-| -}
select : Selector a -> EntityId -> Ecs -> Maybe a
select =
    Ecs.Api.select


{-| -}
selectList : Selector a -> Ecs -> List ( EntityId, a )
selectList =
    Ecs.Api.selectList


{-| -}
process : Selector a -> (( EntityId, a ) -> ( b, Ecs ) -> ( b, Ecs )) -> ( b, Ecs ) -> ( b, Ecs )
process selector fn ( b, ecs ) =
    List.foldl fn ( b, ecs ) (selectList selector ecs)



-- CREATE SELECTORS --


{-| -}
type alias Selector a =
    Ecs.Api.Selector EntityId Ecs a


{-| -}
component : (ComponentSpecs -> ComponentSpec a) -> Selector a
component =
    Ecs.Api.component spec


{-| -}
select1 : (a -> b) -> (ComponentSpecs -> ComponentSpec a) -> Selector b
select1 =
    Ecs.Api.select1 spec


{-| -}
select2 :
    (a -> b -> c)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> Selector c
select2 =
    Ecs.Api.select2 spec


{-| -}
select3 :
    (a -> b -> c -> d)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> (ComponentSpecs -> ComponentSpec c)
    -> Selector d
select3 =
    Ecs.Api.select3 spec


{-| -}
select4 :
    (a -> b -> c -> d -> e)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> (ComponentSpecs -> ComponentSpec c)
    -> (ComponentSpecs -> ComponentSpec d)
    -> Selector e
select4 =
    Ecs.Api.select4 spec


{-| -}
select5 :
    (a -> b -> c -> d -> e -> f)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> (ComponentSpecs -> ComponentSpec c)
    -> (ComponentSpecs -> ComponentSpec d)
    -> (ComponentSpecs -> ComponentSpec e)
    -> Selector f
select5 =
    Ecs.Api.select5 spec



-- SELECTOR MODIFIERS --


{-| -}
andGet :
    (ComponentSpecs -> ComponentSpec a)
    -> Selector (Maybe a -> b)
    -> Selector b
andGet =
    Ecs.Api.andGet spec


{-| -}
andThen : (a -> Maybe b) -> Selector a -> Selector b
andThen =
    Ecs.Api.andThen


{-| -}
andHas : (ComponentSpecs -> ComponentSpec b) -> Selector a -> Selector a
andHas =
    Ecs.Api.andHas spec


{-| -}
andNot : (ComponentSpecs -> ComponentSpec b) -> Selector a -> Selector a
andNot =
    Ecs.Api.andNot spec


{-| -}
andFilter : (a -> Bool) -> Selector a -> Selector a
andFilter =
    Ecs.Api.andFilter
