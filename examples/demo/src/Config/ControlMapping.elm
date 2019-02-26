module Config.ControlMapping exposing (ControlMapping, default)

import Core.UserInput.KeyCode as KeyCode exposing (KeyCode)


type alias ControlMapping =
    { playerShip :
        { accelerate : KeyCode
        , decelerate : KeyCode
        , rotateLeft : KeyCode
        , rotateRight : KeyCode
        }
    }


default : ControlMapping
default =
    { playerShip =
        { accelerate = KeyCode.arrowUp
        , decelerate = KeyCode.arrowDown
        , rotateLeft = KeyCode.arrowLeft
        , rotateRight = KeyCode.arrowRight
        }
    }
