module EcsGenerator.Error exposing (Error(..))

{-|

@docs Error

-}

import EcsGenerator.Config exposing (Component, Ecs)


{-| -}
type Error
    = InvalidEcsModuleName Ecs
    | InvalidEcsTypeName Ecs
    | ComponentsEmpty
    | InvalidComponentModuleName Component
    | InvalidComponentTypeName Component
    | DuplicateComponent Component
