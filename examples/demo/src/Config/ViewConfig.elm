module Config.ViewConfig exposing (Screen, ViewConfig, World, fromScreenSize)


type alias ViewConfig =
    { screen : Screen
    , world : World
    }


type alias Screen =
    { width : Int
    , height : Int
    }


type alias World =
    { width : Float
    , height : Float
    }


fromScreenSize : Int -> Int -> ViewConfig
fromScreenSize width height =
    { screen =
        { width = width
        , height = height
        }
    , world =
        { width = 2 * toFloat width
        , height = 2 * toFloat height
        }
    }
