module Ecs.AR.Internal.System exposing
    ( System(..)
    , SystemModel
    )

import Ecs.AR.Internal.Ecs exposing (Ecs)
import Ecs.AR.Internal.Entity exposing (EntityId)
import Ecs.AR.Internal.Process exposing (Process)


type System a b
    = System (SystemModel a b)


type alias SystemModel a b =
    { preProcess : Maybe (( Ecs a, b ) -> ( Ecs a, b ))
    , process : Maybe (Process a -> b -> ( Process a, b ))
    , postProcess : Maybe (( Ecs a, b ) -> ( Ecs a, b ))
    }
