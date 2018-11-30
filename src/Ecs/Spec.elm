module Ecs.Spec exposing
    ( EcsSpec, ComponentSpec
    , Model4, ecs4, components4
    )

{-|

@docs EcsSpec, ComponentSpec
@docs Model4, ecs4, components4

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Set


{-| -}
type alias EcsSpec comparable model =
    Internal.EcsSpec comparable model


{-| -}
type alias ComponentSpec comparable model data =
    Internal.ComponentSpec comparable model data


{-| -}
type Model4 comparable a1 a2 a3 a4
    = Model4
        { data1 : Dict comparable a1
        , data2 : Dict comparable a2
        , data3 : Dict comparable a3
        , data4 : Dict comparable a4
        }


{-| -}
ecs4 : EcsSpec comparable (Model4 comparable a1 a2 a3 a4)
ecs4 =
    Internal.EcsSpec
        { empty =
            Model4
                { data1 = Dict.empty
                , data2 = Dict.empty
                , data3 = Dict.empty
                , data4 = Dict.empty
                }
        , clear =
            \id (Model4 model) ->
                Model4
                    { data1 = Dict.remove id model.data1
                    , data2 = Dict.remove id model.data2
                    , data3 = Dict.remove id model.data3
                    , data4 = Dict.remove id model.data4
                    }
        , isEmpty =
            \(Model4 model) ->
                Dict.isEmpty model.data1
                    && Dict.isEmpty model.data2
                    && Dict.isEmpty model.data3
                    && Dict.isEmpty model.data4
        , componentCount =
            \(Model4 model) ->
                Dict.size model.data1
                    + Dict.size model.data2
                    + Dict.size model.data3
                    + Dict.size model.data4
        , ids =
            \(Model4 model) ->
                Set.fromList (Dict.keys model.data1)
                    |> Set.union (Set.fromList (Dict.keys model.data2))
                    |> Set.union (Set.fromList (Dict.keys model.data3))
                    |> Set.union (Set.fromList (Dict.keys model.data4))
        , member =
            \id (Model4 model) ->
                Dict.member id model.data1
                    || Dict.member id model.data2
                    || Dict.member id model.data3
                    || Dict.member id model.data4
        }


{-| -}
components4 :
    (Internal.ComponentSpec comparable (Model4 comparable a1 a2 a3 a4) a1
     -> ComponentSpec comparable (Model4 comparable a1 a2 a3 a4) a2
     -> ComponentSpec comparable (Model4 comparable a1 a2 a3 a4) a3
     -> ComponentSpec comparable (Model4 comparable a1 a2 a3 a4) a4
     -> b
    )
    -> b
components4 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Model4 model) -> model.data1
            , update =
                \updateFn (Model4 model) ->
                    Model4
                        { data1 = updateFn model.data1
                        , data2 = model.data2
                        , data3 = model.data3
                        , data4 = model.data4
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Model4 model) -> model.data2
            , update =
                \updateFn (Model4 model) ->
                    Model4
                        { data1 = model.data1
                        , data2 = updateFn model.data2
                        , data3 = model.data3
                        , data4 = model.data4
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Model4 model) -> model.data3
            , update =
                \updateFn (Model4 model) ->
                    Model4
                        { data1 = model.data1
                        , data2 = model.data2
                        , data3 = updateFn model.data3
                        , data4 = model.data4
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Model4 model) -> model.data4
            , update =
                \updateFn (Model4 model) ->
                    Model4
                        { data1 = model.data1
                        , data2 = model.data2
                        , data3 = model.data3
                        , data4 = updateFn model.data4
                        }
            }
        )
