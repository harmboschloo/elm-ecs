module Components exposing
    ( Ai
    , Collectable
    , Collector
    , Destroy
    , KeyControlsMap
    , Motion
    , Position
    , Scale
    , ScaleAnimation
    , Sprite
    , Velocity
    , defaultKeyControlsMap
    , defaultPosition
    , defaultVelocity
    )

import Data.Animation exposing (Animation)
import Data.KeyCode as KeyCode exposing (KeyCode)
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


type alias Sprite =
    { texture : Texture
    , x : Float
    , y : Float
    , width : Float
    , height : Float
    , pivotX : Float
    , pivotY : Float
    }


type alias Scale =
    Float


type alias ScaleAnimation =
    Animation


type alias Destroy =
    { time : Float
    }


type alias Collector =
    { radius : Float }


type alias Collectable =
    ()
