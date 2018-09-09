module Ecs.Systems.Move exposing (Model, update)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Velocity)


type alias Model =
    { deltaTime : Float }


update : ( Ecs, Model ) -> ( Ecs, Model )
update ( ecs, model ) =
    Ecs.processEntities2 Ecs.position Ecs.velocity moveEntity ( ecs, model )


moveEntity :
    EntityId
    -> Position
    -> Velocity
    -> ( Ecs, Model )
    -> ( Ecs, Model )
moveEntity entityId position velocity ( ecs, model ) =
    let
        newPosition =
            { x = position.x + velocity.velocityX * model.deltaTime
            , y = position.y + velocity.velocityY * model.deltaTime
            , angle = position.angle + velocity.angularVelocity * model.deltaTime
            }
    in
    ( Ecs.insertComponent Ecs.position newPosition entityId ecs, model )
