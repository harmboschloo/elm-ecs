module Systems exposing (update, view)

import Context exposing (Context)
import Ecs exposing (Ecs, EntityId)
import Frame exposing (Frame)
import History exposing (History)
import Html exposing (Html)
import Systems.Animation as Animation
import Systems.Collection as Collection
import Systems.KeyControls as KeyControls
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import Systems.Render as Render
import Systems.Spawn as Spawn
import Systems.Transform as Transform


update : Context -> Ecs -> ( Ecs, Context )
update context ecs =
    ( ecs, context )
        |> Transform.update
        |> Spawn.update
        |> KeyControls.update
        |> MotionControl.update
        |> Movement.update
        |> Animation.update
        |> Collection.update


view : Frame -> History -> Context -> Ecs -> Html msg
view =
    Render.view
