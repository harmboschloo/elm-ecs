module Systems exposing (update, view)

import Entities exposing (Entities)
import Frame exposing (Frame)
import Global exposing (Global)
import Html exposing (Html)
import Systems.Ai as Ai
import Systems.Animation as Animation
import Systems.Collision as Collision
import Systems.DelayedOperations as DelayedOperations
import Systems.KeyControls as KeyControls
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import Systems.Render as Render
import Systems.Spawn as Spawn


update : ( Global, Entities ) -> ( Global, Entities )
update state =
    state
        |> DelayedOperations.update
        |> Spawn.update
        |> Ai.update
        |> KeyControls.update
        |> MotionControl.update
        |> Movement.update
        |> Animation.update
        |> Collision.update


view : Frame -> Global -> Entities -> Html msg
view =
    Render.view
