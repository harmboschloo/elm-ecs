module Config.SpawnConfig exposing (SpawnConfig, default)


type alias SpawnConfig =
    { spawnRate : Float }


default : SpawnConfig
default =
    { spawnRate = 5
    }
