module Systems.Movement exposing (update, updatePosition)

import Components.Position exposing (Position)
import Components.Velocity exposing (Velocity)
import Ecs
import Ecs.Select
import Timing.Timer as Timer
import World exposing (World)


type alias Movement =
    { position : Position
    , velocity : Velocity
    }


movementSelector : World.Selector Movement
movementSelector =
    Ecs.Select.select2 Movement
        World.componentSpecs.position
        World.componentSpecs.velocity


update : World -> World
update world =
    let
        timer =
            Ecs.getSingleton World.singletonSpecs.timer world
    in
    case Timer.lastDelta timer of
        Just deltaTime ->
            Ecs.processAll movementSelector (updateEntity deltaTime) world

        Nothing ->
            world


updateEntity :
    Float
    -> ( Ecs.EntityId, Movement )
    -> World
    -> World
updateEntity deltaTime ( entityId, { position, velocity } ) world =
    Ecs.insertComponent World.componentSpecs.position
        entityId
        (updatePosition deltaTime velocity position)
        world


updatePosition : Float -> Velocity -> Position -> Position
updatePosition deltaTime velocity position =
    { x = position.x + velocity.velocityX * deltaTime
    , y = position.y + velocity.velocityY * deltaTime
    , angle = position.angle + velocity.angularVelocity * deltaTime
    }
