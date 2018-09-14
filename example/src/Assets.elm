module Assets exposing (Spritesheet, loadSpritesheet)

import Ecs.Components exposing (Sprite)
import Task
import WebGL.Texture as Texture exposing (Error, Texture, defaultOptions)


type alias Spritesheet =
    { playerShip1Green : Sprite
    , playerShip2Orange : Sprite
    }


spritesheetSrc : String
spritesheetSrc =
    "/assets/spaceshooter/sheet.png"


loadSpritesheet : (Result Error Spritesheet -> msg) -> Cmd msg
loadSpritesheet msg =
    Texture.loadWith
        { defaultOptions
            | magnify = Texture.nearest
            , minify = Texture.nearest
            , flipY = False
        }
        spritesheetSrc
        |> Task.attempt (Result.map initSpritesheet >> msg)


initSpritesheet : Texture -> Spritesheet
initSpritesheet texture =
    { playerShip1Green =
        { texture = texture
        , x = 237
        , y = 377
        , width = 99
        , height = 75
        , offsetX = 99 / 2
        , offsetY = 75 * 2 / 3
        }
    , playerShip2Orange =
        { texture = texture
        , x = 112
        , y = 716
        , width = 112
        , height = 75
        , offsetX = 112 / 2
        , offsetY = 75 * 2 / 3
        }
    }
