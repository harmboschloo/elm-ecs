module Components.Controls exposing
    ( Controls
    , controls
    , getAcceleration
    , getRotation
    , setAcceleration
    , setRotation
    )


type Controls
    = Controls
        { acceleration : Float
        , rotation : Float
        }


controls : Float -> Float -> Controls
controls acceleration rotation =
    Controls
        { acceleration = clamp -1 1 acceleration
        , rotation = clamp -1 1 rotation
        }


setAcceleration : Float -> Controls -> Controls
setAcceleration acceleration (Controls data) =
    Controls { data | acceleration = clamp -1 1 acceleration }


getAcceleration : Controls -> Float
getAcceleration (Controls data) =
    data.acceleration


setRotation : Float -> Controls -> Controls
setRotation rotation (Controls data) =
    Controls { data | rotation = clamp -1 1 rotation }


getRotation : Controls -> Float
getRotation (Controls data) =
    data.rotation
