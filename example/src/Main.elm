module Main exposing (main)

import Ecs
import Html exposing (Html, text)



-- COMPONENTS --


type alias Position =
    { x : Float
    , y : Float
    , rotation : Float
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    , angularVelocity : Float
    }


type alias Display =
    { color : String
    }



-- SYSTEMS --
-- updateMove : Float -> EntityId -> PositionComponent -> VelocityComponent -> Delta X
-- MAIN --


main : Html msg
main =
    text "Hello ECS"
