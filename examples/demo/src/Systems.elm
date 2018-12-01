module Systems exposing (update, view)

-- import Systems.Collection as Collection

import Frame exposing (Frame)
import Game exposing (Game)
import History exposing (History)
import Html exposing (Html)
import Systems.Animation as Animation
import Systems.KeyControls as KeyControls
import Systems.MotionControl as MotionControl
import Systems.Movement as Movement
import Systems.Render as Render
import Systems.Spawn as Spawn
import Systems.Transform as Transform


update : Game -> Game
update game =
    game
        |> Transform.update
        |> Spawn.update
        |> KeyControls.update
        |> MotionControl.update
        |> Movement.update
        |> Animation.update



-- |> Collection.update


view : Frame -> History -> Game -> Html msg
view =
    Render.view
