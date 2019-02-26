module Core.Dynamics.Ship.Limits exposing (Limits)


type alias Limits =
    { maxAcceleration : Float
    , maxDeceleration : Float
    , maxAngularAcceleration : Float
    , maxAngularVelocity : Float
    }
