module Systems exposing (update, view)

import Ecs exposing (Ecs)
import Frame exposing (Frame)
import Global exposing (Global)
import History exposing (History)
import Html exposing (Html)
import Systems.Animation as Animation
import Systems.Collision as Collision
import Systems.KeyControls as KeyControls
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import Systems.Render as Render
import Systems.Spawn as Spawn
import Systems.Transform as Transform


update : ( Global, Ecs ) -> ( Global, Ecs )
update state =
    state
        |> Transform.update
        |> Spawn.update
        |> KeyControls.update
        |> MotionControl.update
        |> Movement.update
        |> Animation.update
        |> Collision.update


view : Frame -> History -> Global -> Ecs -> Html msg
view =
    Render.view
