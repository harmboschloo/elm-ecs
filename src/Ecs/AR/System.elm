module Ecs.AR.System exposing
    ( System
    , postProcessor
    , preProcessor
    , processor
    , system
    )

{-| -}

import Array
import Ecs.AR.Internal.Ecs exposing (Ecs)
import Ecs.AR.Internal.Entity exposing (EntityId)
import Ecs.AR.Internal.Process exposing (Process)
import Ecs.AR.Internal.System as System
import Ecs.AR.Process as Process
import Ecs.AR.Select exposing (Select)


{-| -}
type alias System a b =
    System.System a b


{-| -}
system :
    { preProcess : Maybe (Ecs a -> b -> ( Ecs a, b ))
    , process : Maybe ( Select a c, c -> Process a -> b -> ( Process a, b ) )
    , postProcess : Maybe (Ecs a -> b -> ( Ecs a, b ))
    }
    -> System a b
system config =
    System.System
        { preProcess = Maybe.map mapPreOrPostProcess config.preProcess
        , process = Maybe.map mapProcess config.process
        , postProcess = Maybe.map mapPreOrPostProcess config.postProcess
        }


{-| -}
preProcessor : (Ecs a -> b -> ( Ecs a, b )) -> System a b
preProcessor fn =
    system
        { preProcess = Just fn
        , process = Nothing
        , postProcess = Nothing
        }


{-| -}
processor :
    Select a c
    -> (c -> Process a -> b -> ( Process a, b ))
    -> System a b
processor select fn =
    system
        { preProcess = Nothing
        , process = Just ( select, fn )
        , postProcess = Nothing
        }


{-| -}
postProcessor : (Ecs a -> b -> ( Ecs a, b )) -> System a b
postProcessor fn =
    system
        { preProcess = Nothing
        , process = Nothing
        , postProcess = Just fn
        }


mapPreOrPostProcess :
    (Ecs a -> b -> ( Ecs a, b ))
    -> (( Ecs a, b ) -> ( Ecs a, b ))
mapPreOrPostProcess fn =
    \( ecs, a ) -> fn ecs a


mapProcess :
    ( Select a c, c -> Process a -> b -> ( Process a, b ) )
    -> (Process a -> b -> ( Process a, b ))
mapProcess ( selectC, fn ) =
    \process b ->
        case Process.get selectC process of
            Nothing ->
                ( process, b )

            Just c ->
                fn c process b
