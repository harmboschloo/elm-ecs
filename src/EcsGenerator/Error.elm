module EcsGenerator.Error exposing (Error(..))

{-|

@docs Error

-}

import EcsGenerator.Config exposing (Component, Ecs, Node)


{-| -}
type Error
    = InvalidEcsModuleName Ecs
    | InvalidEcsTypeName Ecs
    | ComponentsEmpty
    | InvalidComponentModuleName Component
    | InvalidComponentTypeName Component
    | DuplicateComponent Component
    | NodesEmpty
    | NodeNameInvalid Node
    | NodeComponentsEmpty Node
    | UnknownNodeComponent Node Component
    | DuplicateNodeComponent Node Component
