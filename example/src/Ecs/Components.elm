module Ecs.Components exposing (Display, Position, Velocity)


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
