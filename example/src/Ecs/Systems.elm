module Ecs.Systems exposing (update, view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Components exposing (Position, Velocity)
import Ecs.Systems.KeyControls as KeyControls exposing (Keys)
import Ecs.Systems.MotionControl as MotionControl
import Ecs.Systems.Movement as Movement
import Ecs.Systems.Render as Render
import Html exposing (Html)


update : Keys -> Float -> Ecs -> Ecs
update keys deltaTime ecs =
    ecs
        |> KeyControls.updateEntities keys
        |> MotionControl.update deltaTime
        |> Movement.update deltaTime


view : Ecs -> Html msg
view =
    Render.view
