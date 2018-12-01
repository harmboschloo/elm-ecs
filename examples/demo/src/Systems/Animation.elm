module Systems.Animation exposing (update)

import Components exposing (ScaleAnimation)
import Data.Animation as Animation exposing (Animation)
import Ecs.Select
import Game exposing (EntityId, Game)


scaleAnimationSelector : Game.Selector ScaleAnimation
scaleAnimationSelector =
    Ecs.Select.component Game.components.scaleAnimation
        |> Ecs.Select.andHas Game.components.scale


update : Game -> Game
update =
    Game.process scaleAnimationSelector updateEntity


updateEntity : ( EntityId, ScaleAnimation ) -> Game -> Game
updateEntity ( entityId, scaleAnimation ) game1 =
    let
        time =
            Game.getTime game1

        game2 =
            Game.insert Game.components.scale
                entityId
                (Animation.animate time scaleAnimation)
                game1
    in
    if Animation.hasEnded time scaleAnimation then
        Game.remove Game.components.scaleAnimation entityId game2

    else
        game2
