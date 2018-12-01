module Entities exposing
    ( createAiShip
    , createPlayerShip
    , createStar
    , init
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
import Game exposing (EntityId, Game)
import Random exposing (Generator)
import Utils exposing (times)



-- INIT --


init : Game -> Game
init game =
    game
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


createPlayerShip : Game -> Game
createPlayerShip game1 =
    let
        assets =
            Game.getAssets game1

        world =
            Game.getWorld game1

        ( angle, game2 ) =
            Game.randomStep angleGenerator game1

        ( entityId, game3 ) =
            Game.addEntity game2
    in
    game3
        |> setShipComponents
            entityId
            assets.sprites.playerShip
            { x = world.width / 2
            , y = world.height / 2
            , angle = angle
            }
        |> Game.insert Game.components.keyControlsMap
            entityId
            { accelerate = KeyCode.arrowUp
            , decelerate = KeyCode.arrowDown
            , rotateLeft = KeyCode.arrowLeft
            , rotateRight = KeyCode.arrowRight
            }


createAiShip : Game -> Game
createAiShip game1 =
    let
        assets =
            Game.getAssets game1

        world =
            Game.getWorld game1

        ( position, game2 ) =
            Game.randomStep (positionGenerator world) game1

        ( entityId, game3 ) =
            Game.addEntity game2
    in
    game3
        |> setShipComponents
            entityId
            assets.sprites.aiShip
            position
        |> Game.insert Game.components.ai entityId ()


setShipComponents :
    EntityId
    -> Sprite
    -> Position
    -> Game
    -> Game
setShipComponents entityId sprite position =
    Game.insert Game.components.sprite entityId sprite
        >> Game.insert Game.components.position entityId position
        >> Game.insert Game.components.controls entityId (controls 0 0)
        >> Game.insert Game.components.motion entityId shipMotion
        >> Game.insert Game.components.velocity entityId (Velocity 0 0 0)
        >> Game.insert Game.components.collector entityId (Collector 30)


createStar : Game -> Game
createStar game1 =
    let
        assets =
            Game.getAssets game1

        world =
            Game.getWorld game1

        time =
            Game.getTime game1

        ( position, game2 ) =
            Game.randomStep (positionGenerator world) game1

        ( delay, game3 ) =
            Game.randomStep (Random.float 0 1) game2

        ( entityId, game4 ) =
            Game.addEntity game3
    in
    game4
        |> Game.insert Game.components.sprite entityId assets.sprites.star
        |> Game.insert Game.components.position entityId position
        |> Game.insert Game.components.velocity entityId (Velocity 0 0 (pi / 4))
        |> Game.insert Game.components.scale entityId 0
        |> Game.insert Game.components.scaleAnimation
            entityId
            (Animation.animation
                { startTime = time
                , duration = 0.5
                , from = 0
                , to = 1
                }
                |> Animation.delay delay
            )
        |> Game.update
            Game.components.transforms
            entityId
            (Transforms.add
                (time + delay + 0.5)
                (Transforms.InsertCollectable ())
            )



-- GENERATORS --


positionGenerator : Game.World -> Generator Position
positionGenerator world =
    Random.map3 Position
        (Random.float 0 world.width)
        (Random.float 0 world.height)
        angleGenerator


angleGenerator : Generator Float
angleGenerator =
    Random.float 0 (2 * pi)
