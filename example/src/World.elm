module World exposing (World)

import WebGL.Texture exposing (Texture)


type alias World =
    { width : Float
    , height : Float
    , background : Texture
    }
