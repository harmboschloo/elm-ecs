port module EcsGenerator.Worker exposing (main)

import EcsGenerator exposing (Worker, worker)
import EcsGenerator.Config exposing (config)


port onResult : String -> Cmd msg


main : Worker msg
main =
    worker onResult config
