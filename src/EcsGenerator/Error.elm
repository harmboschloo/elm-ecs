module EcsGenerator.Error exposing (Error(..))

import EcsGenerator.Config exposing (Component, Ecs, Iterator)


type Error
    = InvalidEcsModuleName Ecs
    | InvalidEcsTypeName Ecs
    | ComponentsEmpty
    | InvalidComponentModuleName Component
    | InvalidComponentTypeName Component
    | DuplicateComponent Component
    | IteratorsEmpty
    | IteratorNameInvalid Iterator
    | IteratorComponentsEmpty Iterator
    | UnknownIteratorComponent Iterator Component
    | DuplicateIteratorComponent Iterator Component
