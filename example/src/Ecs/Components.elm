module Ecs.Components exposing
    ( Ai
    , Controls
    , Display
    , KeyControlsMap
    , Motion
    , Position
    , Predator
    , Prey
    , Sprite
    , Velocity
    , controls
    , defaultControls
    , defaultKeyControlsMap
    , defaultPosition
    , defaultVelocity
    )

import Clamped exposing (Clamped)
import KeyCode exposing (KeyCode)
import WebGL.Texture exposing (Texture)


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


type alias Motion =
    { maxAcceleration : Float
    , maxDeceleration : Float
    , maxAngularAcceleration : Float
    , maxAngularVelocity : Float
    }


type alias Display =
    { color : String
    }


type alias Sprite =
    { texture : Texture
    , x : Float
    , y : Float
    , width : Float
    , height : Float
    , pivotX : Float
    , pivotY : Float
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
