module Entities exposing
    ( Ecs
    , Entities
    , EntityId
    , Selector
    , addEntity
    , andGet
    , andHas
    , empty
    , getComponentCount
    , getEntityCount
    , insert
    , process
    , remove
    , removeEntity
    , select2
    , select4
    , selectComponent
    , selectList
    , update
    , updateEcs
    )

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
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.Controls exposing (Controls)
import Components.DelayedOperations exposing (DelayedOperations)
import Ecs
import Ecs.Select
import Ecs.Spec



-- ECS SPEC --


type alias EntityId =
    Int


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


type alias ComponentSpec a =
    Ecs.Spec.ComponentSpec EntityId Ecs a


type alias Ecs =
    Ecs.Spec.Ecs11 EntityId Ai CollisionShape Controls DelayedOperations KeyControlsMap Motion Position Scale ScaleAnimation Sprite Velocity


type alias Selector a =
    Ecs.Select.Selector EntityId Ecs a


spec : Ecs.Spec.Spec EntityId Ecs
spec =
    Ecs.Spec.spec11


componentSpecs : ComponentSpecs
componentSpecs =
    Ecs.Spec.components11 ComponentSpecs



-- MODEL --


type Entities
    = Entities Model


type alias Model =
    { ecs : Ecs
    , nextId : EntityId
    , entityCount : Int
    }


empty : Entities
empty =
    Entities
        { ecs = Ecs.empty spec
        , nextId = 0
        , entityCount = 0
        }


getEntityCount : Entities -> Int
getEntityCount (Entities model) =
    model.entityCount


getComponentCount : Entities -> Int
getComponentCount (Entities model) =
    Ecs.componentCount spec model.ecs



-- UPDATE --


addEntity : Entities -> ( EntityId, Entities )
addEntity (Entities model) =
    ( model.nextId + 1
    , Entities
        { ecs = model.ecs
        , nextId = model.nextId + 1
        , entityCount = model.entityCount + 1
        }
    )


removeEntity : EntityId -> Entities -> Entities
removeEntity entityId (Entities model) =
    Entities
        { ecs = Ecs.clear spec entityId model.ecs
        , nextId = model.nextId
        , entityCount = model.entityCount - 1
        }


updateEcs : (Ecs -> Ecs) -> Entities -> Entities
updateEcs fn (Entities model) =
    Entities
        { ecs = fn model.ecs
        , nextId = model.nextId
        , entityCount = model.entityCount
        }



-- UPDATE COMPONENTS --


insert : (ComponentSpecs -> ComponentSpec a) -> EntityId -> a -> Ecs -> Ecs
insert getSpec =
    Ecs.insert (getSpec componentSpecs)


update :
    (ComponentSpecs -> ComponentSpec a)
    -> EntityId
    -> (Maybe a -> Maybe a)
    -> Ecs
    -> Ecs
update getSpec =
    Ecs.update (getSpec componentSpecs)


remove : (ComponentSpecs -> ComponentSpec a) -> EntityId -> Ecs -> Ecs
remove getSpec =
    Ecs.remove (getSpec componentSpecs)



-- SELECT --


selectComponent : (ComponentSpecs -> ComponentSpec a) -> Selector a
selectComponent getSpec =
    Ecs.Select.component (getSpec componentSpecs)


select2 :
    (a -> b -> c)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> Selector c
select2 fn getSpecA getSpecB =
    Ecs.Select.select2 fn (getSpecA componentSpecs) (getSpecB componentSpecs)


select4 :
    (a -> b -> c -> d -> e)
    -> (ComponentSpecs -> ComponentSpec a)
    -> (ComponentSpecs -> ComponentSpec b)
    -> (ComponentSpecs -> ComponentSpec c)
    -> (ComponentSpecs -> ComponentSpec d)
    -> Selector e
select4 fn getSpecA getSpecB getSpecC getSpecD =
    Ecs.Select.select4 fn
        (getSpecA componentSpecs)
        (getSpecB componentSpecs)
        (getSpecC componentSpecs)
        (getSpecD componentSpecs)


andGet :
    (ComponentSpecs -> ComponentSpec a)
    -> Selector (Maybe a -> b)
    -> Selector b
andGet getSpec =
    Ecs.Select.andGet (getSpec componentSpecs)


andHas : (ComponentSpecs -> ComponentSpec b) -> Selector a -> Selector a
andHas getSpec =
    Ecs.Select.andHas (getSpec componentSpecs)


selectList : Selector a -> Entities -> List ( EntityId, a )
selectList selector (Entities model) =
    Ecs.selectList selector model.ecs


process :
    Selector a
    -> (( EntityId, a ) -> ( b, Entities ) -> ( b, Entities ))
    -> ( b, Entities )
    -> ( b, Entities )
process selector fn ( b, Entities model ) =
    List.foldl fn ( b, Entities model ) (Ecs.selectList selector model.ecs)
