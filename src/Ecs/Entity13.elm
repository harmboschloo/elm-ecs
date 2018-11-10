module Ecs.Entity13 exposing (entity, components)

{-| ECS entities with 13 components.
-}

import Ecs.Internal exposing (ComponentSpec(..), EntitySpec(..))


{-| -}
entity :
    (Maybe component1 -> Maybe component2 -> Maybe component3 -> Maybe component4 -> Maybe component5 -> Maybe component6 -> Maybe component7 -> Maybe component8 -> Maybe component9 -> Maybe component10 -> Maybe component11 -> Maybe component12 -> Maybe component13 -> components)
    -> EntitySpec components
entity createComponents =
    EntitySpec { empty = createComponents Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing }


{-| -}
components :
    (ComponentSpec components component1 -> ComponentSpec components component2 -> ComponentSpec components component3 -> ComponentSpec components component4 -> ComponentSpec components component5 -> ComponentSpec components component6 -> ComponentSpec components component7 -> ComponentSpec components component8 -> ComponentSpec components component9 -> ComponentSpec components component10 -> ComponentSpec components component11 -> ComponentSpec components component12 -> ComponentSpec components component13 -> componentSpecs)
    -> (Maybe component1 -> Maybe component2 -> Maybe component3 -> Maybe component4 -> Maybe component5 -> Maybe component6 -> Maybe component7 -> Maybe component8 -> Maybe component9 -> Maybe component10 -> Maybe component11 -> Maybe component12 -> Maybe component13 -> components)
    -> (components -> Maybe component1)
    -> (components -> Maybe component2)
    -> (components -> Maybe component3)
    -> (components -> Maybe component4)
    -> (components -> Maybe component5)
    -> (components -> Maybe component6)
    -> (components -> Maybe component7)
    -> (components -> Maybe component8)
    -> (components -> Maybe component9)
    -> (components -> Maybe component10)
    -> (components -> Maybe component11)
    -> (components -> Maybe component12)
    -> (components -> Maybe component13)
    -> componentSpecs
components createComponentSpecs createComponents get1 get2 get3 get4 get5 get6 get7 get8 get9 get10 get11 get12 get13 =
    createComponentSpecs
        (ComponentSpec
            { getComponent = get1
            , setComponent =
                \component data ->
                    createComponents
                        component
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get2
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        component
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get3
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        component
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get4
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        component
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get5
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        component
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get6
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        component
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get7
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        component
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get8
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        component
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get9
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        component
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get10
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        component
                        (get11 data)
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get11
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        component
                        (get12 data)
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get12
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        component
                        (get13 data)
            }
        )
        (ComponentSpec
            { getComponent = get13
            , setComponent =
                \component data ->
                    createComponents
                        (get1 data)
                        (get2 data)
                        (get3 data)
                        (get4 data)
                        (get5 data)
                        (get6 data)
                        (get7 data)
                        (get8 data)
                        (get9 data)
                        (get10 data)
                        (get11 data)
                        (get12 data)
                        component
            }
        )
