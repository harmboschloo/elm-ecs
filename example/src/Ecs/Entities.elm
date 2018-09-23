module Ecs.Entities exposing (init)

import Assets exposing (Assets, Spritesheet)
import Ecs exposing (Ecs, EntityId)
import Ecs.Components
    exposing
        ( Controls
        , Motion
        , Position
        , Sprite
        , Velocity
        , defaultControls
        , defaultKeyControlsMap
        )
import Ecs.Context as Context exposing (Context)
import Random exposing (Generator)
import Utils exposing (times)
import WebGL.Texture exposing (Texture)


init : Context -> ( Ecs, Context )
init context =
    ( Ecs.init, context )
        |> createPlayerCollector
        |> times 10 createAiCollector


createPlayerCollector : ( Ecs, Context ) -> ( Ecs, Context )
createPlayerCollector ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.createEntity ecs

        ( angle, context2 ) =
            Context.randomStep randomAngleGenerator context

        ( ecs3, _ ) =
            ( ecs2, entityId )
                |> insertCollectorComponents
                    context2.assets.sprites.playerShip1Green
                    { x = context.world.width / 2
                    , y = context.world.height / 2
                    , angle = angle
                    }
                |> Ecs.andInsertComponent
                    Ecs.keyControlsMap
                    defaultKeyControlsMap
    in
    ( ecs3, context2 )


randomPositionGenerator : Context -> Generator Position
randomPositionGenerator context =
    Random.map3 Position
        (Random.float 0 context.world.width)
        (Random.float 0 context.world.height)
        randomAngleGenerator


randomAngleGenerator : Generator Float
randomAngleGenerator =
    Random.float 0 (2 * pi)


createAiCollector : ( Ecs, Context ) -> ( Ecs, Context )
createAiCollector ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.createEntity ecs

        ( position, context2 ) =
            Context.randomStep (randomPositionGenerator context) context

        ( ecs3, _ ) =
            ( ecs2, entityId )
                |> insertCollectorComponents
                    context2.assets.sprites.playerShip2Orange
                    position
                |> Ecs.andInsertComponent Ecs.ai ()
    in
    ( ecs3, context2 )


insertCollectorComponents :
    Sprite
    -> Position
    -> ( Ecs, EntityId )
    -> ( Ecs, EntityId )
insertCollectorComponents sprite position =
    Ecs.andInsertComponent Ecs.sprite sprite
        >> Ecs.andInsertComponent Ecs.position position
        >> Ecs.andInsertComponent Ecs.controls defaultControls
        >> Ecs.andInsertComponent Ecs.motion shipMotion
        >> Ecs.andInsertComponent Ecs.velocity (Velocity 0 0 0)
        >> Ecs.andInsertComponent Ecs.collector ()


shipMotion : Motion
shipMotion =
    { maxAcceleration = 400
    , maxDeceleration = 200
    , maxAngularAcceleration = 12
    , maxAngularVelocity = 6
    }
