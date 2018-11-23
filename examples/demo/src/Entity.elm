module Entity exposing
    ( Entity
    , components
    , createAiShip
    , createPlayerShip
    , createStar
    , initEcs
    )

import Assets exposing (Assets, Spritesheet)
import Components
    exposing
        ( Ai
        , Collectable
        , Collector
        , KeyControlsMap
        , Motion
        , Position
        , Scale
        , ScaleAnimation
        , Sprite
        , Velocity
        )
import Components.Controls exposing (Controls, controls)
import Components.Transforms as Transforms exposing (Transforms)
import Data.Animation as Animation
import Data.KeyCode as KeyCode
import Ecs
import Ecs.Entity
import Ecs.Update
import Random exposing (Generator)
import State exposing (State)
import Utils exposing (times)
import WebGL.Texture exposing (Texture)



-- ENTITY --


type alias Entity =
    { ai : Maybe Ai
    , collectable : Maybe Collectable
    , collector : Maybe Collector
    , controls : Maybe Controls
    , keyControlsMap : Maybe KeyControlsMap
    , motion : Maybe Motion
    , position : Maybe Position
    , scale : Maybe Scale
    , scaleAnimation : Maybe ScaleAnimation
    , sprite : Maybe Sprite
    , transforms : Maybe Transforms
    , velocity : Maybe Velocity
    }



-- ECS SETUP --


type alias ComponentUpdates =
    { ai : Ecs.Update.Update Entity Ai
    , collectable : Ecs.Update.Update Entity Collectable
    , collector : Ecs.Update.Update Entity Collector
    , controls : Ecs.Update.Update Entity Controls
    , keyControlsMap : Ecs.Update.Update Entity KeyControlsMap
    , motion : Ecs.Update.Update Entity Motion
    , position : Ecs.Update.Update Entity Position
    , scale : Ecs.Update.Update Entity Scale
    , scaleAnimation : Ecs.Update.Update Entity ScaleAnimation
    , sprite : Ecs.Update.Update Entity Sprite
    , transforms : Ecs.Update.Update Entity Transforms
    , velocity : Ecs.Update.Update Entity Velocity
    }


empty : Entity
empty =
    Ecs.Entity.empty12 Entity


components : ComponentUpdates
components =
    Ecs.Update.updates12
        ComponentUpdates
        Entity
        .ai
        .collectable
        .collector
        .controls
        .keyControlsMap
        .motion
        .position
        .scale
        .scaleAnimation
        .sprite
        .transforms
        .velocity


initEcs : State -> ( Ecs.Ecs Entity, State )
initEcs state =
    ( Ecs.empty, state )
        |> times 10 createAiShip
        |> createPlayerShip
        |> times 30 createStar



-- CREATE ENTITIES --


shipMotion : Motion
shipMotion =
    { maxAcceleration = 600
    , maxDeceleration = 400
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 5
    }


createPlayerShip : ( Ecs.Ecs Entity, State ) -> ( Ecs.Ecs Entity, State )
createPlayerShip ( ecs, state ) =
    let
        ( angle, state2 ) =
            State.randomStep angleGenerator state

        entity =
            empty
                |> setShipComponents
                    state2.assets.sprites.playerShip
                    { x = state2.world.width / 2
                    , y = state2.world.height / 2
                    , angle = angle
                    }
                |> Ecs.Entity.set components.keyControlsMap
                    { accelerate = KeyCode.arrowUp
                    , decelerate = KeyCode.arrowDown
                    , rotateLeft = KeyCode.arrowLeft
                    , rotateRight = KeyCode.arrowRight
                    }
    in
    ( Ecs.create entity ecs |> Tuple.second, state2 )


createAiShip : ( Ecs.Ecs Entity, State ) -> ( Ecs.Ecs Entity, State )
createAiShip ( ecs, state ) =
    let
        ( position, state2 ) =
            State.randomStep (positionGenerator state.world) state

        entity =
            empty
                |> setShipComponents
                    state2.assets.sprites.aiShip
                    position
                |> Ecs.Entity.set components.ai ()
    in
    ( Ecs.create entity ecs |> Tuple.second, state2 )


setShipComponents :
    Sprite
    -> Position
    -> Entity
    -> Entity
setShipComponents sprite position =
    Ecs.Entity.set components.sprite sprite
        >> Ecs.Entity.set components.position position
        >> Ecs.Entity.set components.controls (controls 0 0)
        >> Ecs.Entity.set components.motion shipMotion
        >> Ecs.Entity.set components.velocity (Velocity 0 0 0)
        >> Ecs.Entity.set components.collector (Collector 30)


createStar : ( Ecs.Ecs Entity, State ) -> ( Ecs.Ecs Entity, State )
createStar ( ecs, state ) =
    let
        ( position, state2 ) =
            State.randomStep (positionGenerator state.world) state

        ( delay, state3 ) =
            State.randomStep (Random.float 0 1) state2

        entity =
            empty
                |> Ecs.Entity.set components.sprite state.assets.sprites.star
                |> Ecs.Entity.set components.position position
                |> Ecs.Entity.set components.velocity (Velocity 0 0 (pi / 4))
                |> Ecs.Entity.set components.scale 0
                |> Ecs.Entity.set components.scaleAnimation
                    (Animation.animation
                        { startTime = state.time
                        , duration = 0.5
                        , from = 0
                        , to = 1
                        }
                        |> Animation.delay delay
                    )
                |> Ecs.Entity.update
                    .transforms
                    components.transforms
                    (Transforms.add
                        (state.time + delay + 0.5)
                        (Transforms.InsertCollectable ())
                    )
    in
    ( Ecs.create entity ecs |> Tuple.second, state3 )



-- GENERATORS --


positionGenerator : State.World -> Generator Position
positionGenerator world =
    Random.map3 Position
        (Random.float 0 world.width)
        (Random.float 0 world.height)
        angleGenerator


angleGenerator : Generator Float
angleGenerator =
    Random.float 0 (2 * pi)
