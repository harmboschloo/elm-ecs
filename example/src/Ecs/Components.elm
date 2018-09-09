module Ecs.Components exposing
    ( Acceleration
    , Ai
    , Controls
    , Display
    , Human
    , Position
    , Predator
    , Prey
    , Velocity
    )


type alias Position =
    { x : Float
    , y : Float
    , angle : Float
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    , angularVelocity : Float
    }


type alias Acceleration =
    { accelerationX : Float
    , accelerationY : Float
    , angularAcceleration : Float
    }


type alias Display =
    { color : String
    }


type alias Controls =
    { forward : Bool
    , back : Bool
    , left : Bool
    , right : Bool
    }


type alias Human =
    ()


type alias Ai =
    ()


type alias Predator =
    ()


type alias Prey =
    ()
