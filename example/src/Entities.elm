module Entities exposing (createCollectableWithId, init)

import Assets exposing (Assets, Spritesheet)
import Components
    exposing
        ( Collector
        , Controls
        , Motion
        , Position
        , Sprite
        , Velocity
        , defaultControls
        , defaultKeyControlsMap
        )
import Context exposing (Context)
import Ecs exposing (Ecs, EntityId)
import Random exposing (Generator)
import Utils exposing (times)
import WebGL.Texture exposing (Texture)


init : Context -> ( Ecs, Context )
init context =
    ( Ecs.init, context )
        |> times 30 createCollectable
        |> times 10 createAiCollector
        |> createPlayerCollector


createPlayerCollector : ( Ecs, Context ) -> ( Ecs, Context )
createPlayerCollector ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.createEntity ecs

        ( angle, context2 ) =
            Context.randomStep randomAngleGenerator context

        ecs3 =
            ecs2
                |> insertCollectorComponents
                    entityId
                    context2.assets.sprites.playerShip
                    { x = context.world.width / 2
                    , y = context.world.height / 2
                    , angle = angle
                    }
                |> Ecs.insertComponent
                    entityId
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

        ecs3 =
            ecs2
                |> insertCollectorComponents
                    entityId
                    context2.assets.sprites.aiShip
                    position
                |> Ecs.insertComponent entityId Ecs.ai ()
    in
    ( ecs3, context2 )


insertCollectorComponents : EntityId -> Sprite -> Position -> Ecs -> Ecs
insertCollectorComponents entityId sprite position =
    Ecs.insertComponent entityId Ecs.sprite sprite
        >> Ecs.insertComponent entityId Ecs.position position
        >> Ecs.insertComponent entityId Ecs.controls defaultControls
        >> Ecs.insertComponent entityId Ecs.motion shipMotion
        >> Ecs.insertComponent entityId Ecs.velocity (Velocity 0 0 0)
        >> Ecs.insertComponent entityId Ecs.collector (Collector 30)


shipMotion : Motion
shipMotion =
    { maxAcceleration = 400
    , maxDeceleration = 200
    , maxAngularAcceleration = 12
    , maxAngularVelocity = 6
    }


createCollectable : ( Ecs, Context ) -> ( Ecs, Context )
createCollectable ( ecs, context ) =
    let
        ( ecs2, entityId ) =
            Ecs.createEntity ecs
    in
    createCollectableWithId entityId ( ecs2, context )


createCollectableWithId : EntityId -> ( Ecs, Context ) -> ( Ecs, Context )
createCollectableWithId entityId ( ecs, context ) =
    let
        ( position, context2 ) =
            Context.randomStep (randomPositionGenerator context) context

        ecs2 =
            ecs
                |> Ecs.insertComponent entityId Ecs.sprite context.assets.sprites.collectable
                |> Ecs.insertComponent entityId Ecs.position position
                |> Ecs.insertComponent entityId Ecs.velocity (Velocity 0 0 (pi / 4))
                |> Ecs.insertComponent entityId Ecs.collectable ()
    in
    ( ecs2, context2 )
