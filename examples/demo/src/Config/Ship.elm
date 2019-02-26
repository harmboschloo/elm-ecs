module Config.Ship exposing (limits)

import Core.Dynamics.Ship.Limits exposing (Limits)


limits : Limits
limits =
    { maxAcceleration = 600
    , maxDeceleration = 400
    , maxAngularAcceleration = 20
    , maxAngularVelocity = 5
    }
