module Ecs.Api4 exposing (Ecs, ecs, components)

{-|

@docs Ecs, ecs, components

-}

import Dict exposing (Dict)
import Ecs.Internal exposing (ComponentType(..), EcsType(..))
import Set


type Ecs comparable a1 a2 a3 a4
    = Ecs
        { data1 : Dict comparable a1
        , data2 : Dict comparable a2
        , data3 : Dict comparable a3
        , data4 : Dict comparable a4
        }


ecs : EcsType comparable (Ecs comparable a1 a2 a3 a4)
ecs =
    EcsType
        { empty =
            Ecs
                { data1 = Dict.empty
                , data2 = Dict.empty
                , data3 = Dict.empty
                , data4 = Dict.empty
                }
        , clear =
            \id (Ecs model) ->
                Ecs
                    { data1 = Dict.remove id model.data1
                    , data2 = Dict.remove id model.data2
                    , data3 = Dict.remove id model.data3
                    , data4 = Dict.remove id model.data4
                    }
        , isEmpty =
            \(Ecs model) ->
                Dict.isEmpty model.data1
                    && Dict.isEmpty model.data2
                    && Dict.isEmpty model.data3
                    && Dict.isEmpty model.data4
        , componentCount =
            \(Ecs model) ->
                Dict.size model.data1
                    + Dict.size model.data2
                    + Dict.size model.data3
                    + Dict.size model.data4
        , ids =
            \(Ecs model) ->
                Set.fromList (Dict.keys model.data1)
                    |> Set.union (Set.fromList (Dict.keys model.data2))
                    |> Set.union (Set.fromList (Dict.keys model.data3))
                    |> Set.union (Set.fromList (Dict.keys model.data4))
        , member =
            \id (Ecs model) ->
                Dict.member id model.data1
                    || Dict.member id model.data2
                    || Dict.member id model.data3
                    || Dict.member id model.data4
        }


components :
    (ComponentType comparable (Ecs comparable a1 a2 a3 a4) a1
     -> ComponentType comparable (Ecs comparable a1 a2 a3 a4) a2
     -> ComponentType comparable (Ecs comparable a1 a2 a3 a4) a3
     -> ComponentType comparable (Ecs comparable a1 a2 a3 a4) a4
     -> b
    )
    -> b
components fn =
    fn
        (ComponentType
            { get = \(Ecs model) -> model.data1
            , update =
                \updateFn (Ecs model) ->
                    Ecs
                        { data1 = updateFn model.data1
                        , data2 = model.data2
                        , data3 = model.data3
                        , data4 = model.data4
                        }
            }
        )
        (ComponentType
            { get = \(Ecs model) -> model.data2
            , update =
                \updateFn (Ecs model) ->
                    Ecs
                        { data1 = model.data1
                        , data2 = updateFn model.data2
                        , data3 = model.data3
                        , data4 = model.data4
                        }
            }
        )
        (ComponentType
            { get = \(Ecs model) -> model.data3
            , update =
                \updateFn (Ecs model) ->
                    Ecs
                        { data1 = model.data1
                        , data2 = model.data2
                        , data3 = updateFn model.data3
                        , data4 = model.data4
                        }
            }
        )
        (ComponentType
            { get = \(Ecs model) -> model.data4
            , update =
                \updateFn (Ecs model) ->
                    Ecs
                        { data1 = model.data1
                        , data2 = model.data2
                        , data3 = model.data3
                        , data4 = updateFn model.data4
                        }
            }
        )
