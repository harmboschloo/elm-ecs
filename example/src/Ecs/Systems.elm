module Ecs.Systems exposing (update, view)

import Ecs exposing (Ecs, EntityId)
import Ecs.Context exposing (Context)
import Ecs.Systems.KeyControls as KeyControls
import Ecs.Systems.MotionControl as MotionControl
import Ecs.Systems.Movement as Movement
import Ecs.Systems.Render as Render
import Ecs.Systems.Collection as Collection
import Html exposing (Html)


update : Context -> Ecs -> ( Ecs, Context )
update context ecs =
    ( ecs, context )
        |> KeyControls.update
        |> MotionControl.update
        |> Movement.update
        |> Collection.update


view : Context -> Ecs -> Html msg
view =
    Render.view
