module Systems.ResizeHandler exposing
    ( Msg
    , screenToWorld
    , subscriptions
    , update
    )

import Browser.Events
import Components.ViewConfig as ViewConfig
import Ecs
import World exposing (World, singletonSpecs)



-- Update


type Msg
    = WindowSizeChanged Int Int


update : Msg -> World -> World
update msg world =
    case msg of
        WindowSizeChanged width height ->
            Ecs.updateSingleton
                singletonSpecs.viewConfig
                (\settings ->
                    { settings
                        | screen = { width = width, height = height }
                        , world = screenToWorld width height
                    }
                )
                world


screenToWorld : Int -> Int -> ViewConfig.World
screenToWorld width height =
    { width = 2 * toFloat width
    , height = 2 * toFloat height
    }



-- Subscriptions


subscriptions : Sub Msg
subscriptions =
    Browser.Events.onResize WindowSizeChanged
