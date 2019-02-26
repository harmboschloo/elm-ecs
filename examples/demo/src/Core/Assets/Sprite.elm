module Core.Assets.Sprite exposing (Sprite)

import WebGL.Texture exposing (Texture)


type alias Sprite =
    { texture : Texture
    , x : Float
    , y : Float
    , width : Float
    , height : Float
    , pivotX : Float
    , pivotY : Float
    }
