module Ecs.Components exposing
    ( Acceleration
    , Ai
    , Controls
    , Display
    , KeyControlsMap
    , Position
    , Predator
    , Prey
    , Velocity
    , controls
    , defaultAcceleration
    , defaultControls
    , defaultKeyControlsMap
    , defaultPosition
    , defaultVelocity
    )

import Clamped exposing (Clamped)
import KeyCode exposing (KeyCode)


type alias Position =
    { x : Float
    , y : Float
    , angle : Float
    }


defaultPosition : Position
defaultPosition =
    { x = 0
    , y = 0
    , angle = 0
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    , angularVelocity : Float
    }


defaultVelocity : Velocity
defaultVelocity =
    { velocityX = 0
    , velocityY = 0
    , angularVelocity = 0
    }


type alias Acceleration =
    { accelerationX : Float
    , accelerationY : Float
    , angularAcceleration : Float
    }


defaultAcceleration : Acceleration
defaultAcceleration =
    { accelerationX = 0
    , accelerationY = 0
    , angularAcceleration = 0
    }


type alias Display =
    { color : String
    }


type alias Controls =
    { accelerate : Clamped Float
    , rotate : Clamped Float
    }


defaultControls : Controls
defaultControls =
    controls 0 0


controls : Float -> Float -> Controls
controls accelerate rotate =
    { accelerate = Clamped.init -1 1 accelerate
    , rotate = Clamped.init -1 1 rotate
    }


type alias KeyControlsMap =
    { accelerate : KeyCode
    , decelerate : KeyCode
    , rotateLeft : KeyCode
    , rotateRight : KeyCode
    }


defaultKeyControlsMap =
    { accelerate = KeyCode.arrowUp
    , decelerate = KeyCode.arrowDown
    , rotateLeft = KeyCode.arrowLeft
    , rotateRight = KeyCode.arrowRight
    }


type alias Ai =
    ()


type alias Predator =
    ()


type alias Prey =
    ()
