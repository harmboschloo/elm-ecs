module Ecs.Systems exposing (update, view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Velocity)
import Ecs.Systems.Move as Move
import Ecs.Systems.Render as Render
import Html exposing (Html)


update : Float -> Ecs -> Ecs
update deltaTime ecs =
    Move.update ( ecs, { deltaTime = deltaTime } )
        |> Tuple.first


view : Ecs -> Html msg
view =
    Render.view
