module Core.UserInput.ActiveKeys exposing (ActiveKeys, empty, isActive, setActive)

import Core.UserInput.KeyCode exposing (KeyCode)
import Set exposing (Set)


type ActiveKeys
    = ActiveKeys (Set KeyCode)


empty : ActiveKeys
empty =
    ActiveKeys Set.empty


isActive : KeyCode -> ActiveKeys -> Bool
isActive keyCode (ActiveKeys activeKeys) =
    Set.member keyCode activeKeys


setActive : KeyCode -> Bool -> ActiveKeys -> ActiveKeys
setActive keyCode active (ActiveKeys activeKeys) =
    ActiveKeys
        (if active then
            Set.insert keyCode activeKeys

         else
            Set.remove keyCode activeKeys
        )
