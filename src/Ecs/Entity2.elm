module Ecs.Entity2 exposing (entity, components)

{-| ECS entities with 2 components.
-}

import Ecs.Internal exposing (ComponentSpec(..), EntitySpec(..))


{-| -}
entity :
    (Maybe component1 -> Maybe component2 -> components)
    -> EntitySpec components
entity createComponents =
    EntitySpec { empty = createComponents Nothing Nothing }


{-| -}
components :
    (ComponentSpec components component1 -> ComponentSpec components component2 -> componentSpecs)
    -> (Maybe component1 -> Maybe component2 -> components)
    -> (components -> Maybe component1)
    -> (components -> Maybe component2)
    -> componentSpecs
components createComponentSpecs createComponents get1 get2 =
    createComponentSpecs
        (ComponentSpec
            { getComponent = get1
            , setComponent =
                \component data ->
                    createComponents
                        component
                        (get2 data)
            }
        )
        (ComponentSpec
            { getComponent = get2
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        component
            }
        )
