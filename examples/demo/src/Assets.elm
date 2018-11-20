module Assets exposing (Assets, Spritesheet, load)

import Components exposing (Sprite)
import Task exposing (Task)
import WebGL.Texture as Texture exposing (Error, Texture, defaultOptions)


type alias Assets =
    { background : Texture
    , sprites : Spritesheet
    }


type alias Spritesheet =
    { playerShip : Sprite
    , aiShip : Sprite
    , star : Sprite
    }


backgroundSrc : String
backgroundSrc =
    "../assets/spaceshooter/darkPurple.png"


spritesheetSrc : String
spritesheetSrc =
    "../assets/spaceshooter/sheet.png"


load : Task Error Assets
load =
    Task.map2 Assets
        loadBackground
        loadSpritesheet


loadBackground : Task Error Texture
loadBackground =
    Texture.loadWith
        { defaultOptions
            | magnify = Texture.nearest
            , minify = Texture.nearest
            , flipY = False
        }
        backgroundSrc


loadSpritesheet : Task Error Spritesheet
loadSpritesheet =
    Texture.loadWith
        { defaultOptions
            | magnify = Texture.nearest
            , minify = Texture.nearest
            , flipY = False
        }
        spritesheetSrc
        |> Task.map initSpritesheet


initSpritesheet : Texture -> Spritesheet
initSpritesheet texture =
    { --playerShip1Green
      playerShip =
        { texture = texture
        , x = 237
        , y = 377
        , width = 99
        , height = 75
        , pivotX = 0.5
        , pivotY = 0.6
        }
    , -- playerShip2Orange
      aiShip =
        { texture = texture
        , x = 112
        , y = 716
        , width = 112
        , height = 75
        , pivotX = 0.5
        , pivotY = 0.6
        }
    , -- star_gold
      star =
        { texture = texture
        , x = 778
        , y = 557
        , width = 31
        , height = 30
        , pivotX = 0.5
        , pivotY = 0.5
        }
    }
