port module Worker exposing (main)

import Config exposing (config)
import EcsGenerator exposing (Worker, worker)


port onResult : String -> Cmd msg


main : Worker msg
main =
    worker onResult config
