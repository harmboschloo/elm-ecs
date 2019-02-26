module Core.Assets exposing (Assets, Spritesheet)

import Core.Assets.Sprite exposing (Sprite)
import WebGL.Texture as Texture exposing (Texture)


type alias Assets =
    { background : Texture
    , sprites : Spritesheet
    }


type alias Spritesheet =
    { playerShip : Sprite
    , aiShip : Sprite
    , star : Sprite
    }
