module Ecs.Spec exposing
    ( AllComponentsSpec
    , ComponentSpec
    , Components4
    , SingletonSpec
    , Singletons4
    , componentSpecs4
    , initSingletons4
    , singletonSpecs4
    )

{-| -}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Ecs.Internal.Record4 as Record4


{-| The specification type for all components.
-}
type alias AllComponentsSpec components =
    Internal.AllComponentsSpec components


{-| A specification type for a component.
-}
type alias ComponentSpec components a =
    Internal.ComponentSpec components a


{-| A specification type for a singleton.
-}
type alias SingletonSpec singletons a =
    Internal.SingletonSpec singletons a


{-| A singletons type for 4 singletons.
-}
type Components4 a1 a2 a3 a4
    = Components4 (Record4.Record (Dict Int a1) (Dict Int a2) (Dict Int a3) (Dict Int a4))


componentSpecs4 :
    (AllComponentsSpec (Components4 a1 a2 a3 a4)
     -> ComponentSpec (Components4 a1 a2 a3 a4) a1
     -> ComponentSpec (Components4 a1 a2 a3 a4) a2
     -> ComponentSpec (Components4 a1 a2 a3 a4) a3
     -> ComponentSpec (Components4 a1 a2 a3 a4) a4
     -> specs
    )
    -> specs
componentSpecs4 fn =
    fn
        (Internal.AllComponentsSpec
            { empty =
                Components4
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    , a4 = Dict.empty
                    }
            , clear =
                \entityId (Components4 components) ->
                    Components4
                        { a1 = Dict.remove entityId components.a1
                        , a2 = Dict.remove entityId components.a2
                        , a3 = Dict.remove entityId components.a3
                        , a4 = Dict.remove entityId components.a4
                        }
            , size =
                \(Components4 components) ->
                    Dict.size components.a1
                        + Dict.size components.a2
                        + Dict.size components.a3
                        + Dict.size components.a4
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a1
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update1 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a2
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update2 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a3
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update3 updateFn components)
            }
        )
        (Internal.ComponentSpec
            { get = \(Components4 components) -> components.a4
            , update =
                \updateFn (Components4 components) ->
                    Components4 (Record4.update4 updateFn components)
            }
        )


{-| A singletons type for 4 singletons.
-}
type Singletons4 a1 a2 a3 a4
    = Singletons4 (Record4.Record a1 a2 a3 a4)


initSingletons4 : a1 -> a2 -> a3 -> a4 -> Singletons4 a1 a2 a3 a4
initSingletons4 a1 a2 a3 a4 =
    Singletons4
        { a1 = a1
        , a2 = a2
        , a3 = a3
        , a4 = a4
        }


singletonSpecs4 :
    (SingletonSpec (Singletons4 a1 a2 a3 a4) a1
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a2
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a3
     -> SingletonSpec (Singletons4 a1 a2 a3 a4) a4
     -> specs
    )
    -> specs
singletonSpecs4 fn =
    fn
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a1
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update1 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a2
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update2 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a3
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update3 updateFn singletons)
            }
        )
        (Internal.SingletonSpec
            { get = \(Singletons4 singletons) -> singletons.a4
            , update =
                \updateFn (Singletons4 singletons) ->
                    Singletons4 (Record4.update4 updateFn singletons)
            }
        )
