module Systems exposing (update, view)

-- import Systems.Collection as Collection

import Ecs exposing (Ecs)
import Entity exposing (Entity)
import Frame exposing (Frame)
import History exposing (History)
import Html exposing (Html)
import State exposing (State)
import Systems.Animation as Animation
import Systems.KeyControls as KeyControls
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import Systems.Render as Render
import Systems.Spawn as Spawn
import Systems.Transform as Transform


update : Ecs Entity -> State -> ( Ecs Entity, State )
update ecs state =
    Ecs.process
        [ Transform.system
        , Spawn.system
        , KeyControls.system
        , MotionControl.system
        , Movement.system
        , Animation.system

        -- , Collection.system
        , Render.system
        ]
        ecs
        state


view : Frame -> History -> Ecs Entity -> State -> Html msg
view =
    Render.view
