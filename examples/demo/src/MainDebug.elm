module MainDebug exposing (main)

import Html exposing (Html)

main: Html msg
main = Hmlt.text "debug"



nextSpawnRate : SpawnConfig -> SpawnConfig
nextSpawnRate settings =
    { settings
        | spawnRate =
            case round settings.spawnRate of
                5 ->
                    50.0

                50 ->
                    0.0

                _ ->
                    5.0
    }
