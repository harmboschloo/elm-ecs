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
import Ecs exposing (Ecs)
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


type alias Components =
    { ai : Ecs.Component Entity Ai
    , collectable : Ecs.Component Entity Collectable
    , collector : Ecs.Component Entity Collector
    , controls : Ecs.Component Entity Controls
    , keyControlsMap : Ecs.Component Entity KeyControlsMap
    , motion : Ecs.Component Entity Motion
    , position : Ecs.Component Entity Position
    , scale : Ecs.Component Entity Scale
    , scaleAnimation : Ecs.Component Entity ScaleAnimation
    , sprite : Ecs.Component Entity Sprite
    , transforms : Ecs.Component Entity Transforms
    , velocity : Ecs.Component Entity Velocity
    }


empty : Ecs.Empty Entity
empty =
    Ecs.empty12 Entity


components : Components
components =
    Ecs.components12
        Components
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


initEcs : State -> ( Ecs Entity, State )
initEcs state =
    ( Ecs.empty empty, state )
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


createPlayerShip : ( Ecs Entity, State ) -> ( Ecs Entity, State )
createPlayerShip ( ecs, state ) =
    let
        ( angle, state2 ) =
            State.randomStep angleGenerator state

        ( _, ecs2 ) =
            Ecs.create ecs
                |> setShipComponents
                    state2.assets.sprites.playerShip
                    { x = state2.world.width / 2
                    , y = state2.world.height / 2
                    , angle = angle
                    }
                |> Ecs.andSet
                    components.keyControlsMap
                    { accelerate = KeyCode.arrowUp
                    , decelerate = KeyCode.arrowDown
                    , rotateLeft = KeyCode.arrowLeft
                    , rotateRight = KeyCode.arrowRight
                    }
    in
    ( ecs2, state2 )


createAiShip : ( Ecs Entity, State ) -> ( Ecs Entity, State )
createAiShip ( ecs, state ) =
    let
        ( position, state2 ) =
            State.randomStep (positionGenerator state.world) state

        ( _, ecs2 ) =
            Ecs.create ecs
                |> setShipComponents
                    state2.assets.sprites.aiShip
                    position
                |> Ecs.andSet components.ai ()
    in
    ( ecs2, state2 )


setShipComponents :
    Sprite
    -> Position
    -> ( Ecs.EntityId, Ecs Entity )
    -> ( Ecs.EntityId, Ecs Entity )
setShipComponents sprite position =
    Ecs.andSet components.sprite sprite
        >> Ecs.andSet components.position position
        >> Ecs.andSet components.controls (controls 0 0)
        >> Ecs.andSet components.motion shipMotion
        >> Ecs.andSet components.velocity (Velocity 0 0 0)
        >> Ecs.andSet components.collector (Collector 30)


createStar : ( Ecs Entity, State ) -> ( Ecs Entity, State )
createStar ( ecs, state ) =
    let
        ( position, state2 ) =
            State.randomStep (positionGenerator state.world) state

        ( delay, state3 ) =
            State.randomStep (Random.float 0 1) state2

        ( _, ecs2 ) =
            Ecs.create ecs
                |> Ecs.andSet components.sprite state.assets.sprites.star
                |> Ecs.andSet components.position position
                |> Ecs.andSet components.velocity (Velocity 0 0 (pi / 4))
                |> Ecs.andSet components.scale 0
                |> Ecs.andSet
                    components.scaleAnimation
                    (Animation.animation
                        { startTime = state.time
                        , duration = 0.5
                        , from = 0
                        , to = 1
                        }
                        |> Animation.delay delay
                    )
                |> Ecs.andUpdate
                    components.transforms
                    (Transforms.add
                        (state.time + delay + 0.5)
                        (Transforms.InsertCollectable ())
                    )
    in
    ( ecs2, state3 )



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
