module World exposing
    ( ComponentSpec
    , Components
    , EntityId
    , Selector
    , Specs
    , World
    , specs
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
        , Star
        , Velocity
        )
import Components.CollisionShape as CollisionShape exposing (CollisionShape)
import Components.Controls exposing (Controls)
import Components.DelayedOperations exposing (DelayedOperations)
import Ecs
import Ecs.Select
import Ecs.Spec


type alias Components =
    Ecs.Spec.Components12 Ai CollisionShape Controls DelayedOperations KeyControlsMap Motion Position Scale ScaleAnimation Sprite Star Velocity


type alias ComponentSpec a =
    Ecs.Spec.ComponentSpec Components a


type alias Specs =
    { all : Ecs.Spec.Spec Components
    , ai : ComponentSpec Ai
    , collisionShape : ComponentSpec CollisionShape
    , controls : ComponentSpec Controls
    , delayedOperations : ComponentSpec DelayedOperations
    , keyControlsMap : ComponentSpec KeyControlsMap
    , motion : ComponentSpec Motion
    , position : ComponentSpec Position
    , scale : ComponentSpec Scale
    , scaleAnimation : ComponentSpec ScaleAnimation
    , sprite : ComponentSpec Sprite
    , star : ComponentSpec Star
    , velocity : ComponentSpec Velocity
    }


type alias Selector a =
    Ecs.Select.Selector Components a


type alias EntityId =
    Ecs.EntityId


type alias World =
    Ecs.World Components


specs : Specs
specs =
    Ecs.Spec.specs12 Specs
