module Ecs.Entity1 exposing (entity, components)

{-| ECS entities with 1 component.
-}

import Ecs.Internal exposing (ComponentSpec(..), EntitySpec(..))


{-| -}
entity :
    (Maybe component1 -> components)
    -> EntitySpec components
entity createComponents =
    EntitySpec { empty = createComponents Nothing }


{-| -}
components :
    (ComponentSpec components component1 -> componentSpecs)
    -> (Maybe component1 -> components)
    -> (components -> Maybe component1)
    -> componentSpecs
components createComponentSpecs createComponents get1 =
    createComponentSpecs
        (ComponentSpec
            { getComponent = get1
            , setComponent =
                \component data ->
                    createComponents
                        component
            }
        )
