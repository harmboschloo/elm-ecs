module Ecs.Internal.System exposing
    ( System(..)
    , SystemModel
    )

import Ecs.Internal.Ecs exposing (Ecs)
import Ecs.Internal.Entity exposing (EntityId)
import Ecs.Internal.Process exposing (Process)


type System a b
    = System (SystemModel a b)


type alias SystemModel a b =
    { preProcess : Maybe (( Ecs a, b ) -> ( Ecs a, b ))
    , process : Maybe (Process a -> b -> ( Process a, b ))
    , postProcess : Maybe (( Ecs a, b ) -> ( Ecs a, b ))
    }
