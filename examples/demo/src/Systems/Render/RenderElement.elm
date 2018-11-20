module Systems.Render.RenderElement exposing (RenderElement)

import Components exposing (Position, Scale, Sprite)


type alias RenderElement =
    { position : Position
    , sprite : Sprite
    , scale : Maybe Scale
    }
