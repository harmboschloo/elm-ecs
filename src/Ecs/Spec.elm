module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , Ecs3, spec3
    )

{-|

@docs Spec, ComponentSpec
@docs Ecs3, spec3

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Set


{-| -}
type alias Spec componentSpecs comparable model =
    Internal.Spec componentSpecs comparable model


{-| -}
type alias ComponentSpec comparable model data =
    Internal.ComponentSpec comparable model data


{-| -}
type Ecs3 comparable a1 a2 a3 
    = Ecs3
        { data1 : Dict comparable a1
        , data2 : Dict comparable a2
        , data3 : Dict comparable a3
        }


{-| -}
spec3 :
    (ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a1
     -> ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a2
     -> ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a3
     -> componentSpecs
    )
    -> Spec componentSpecs comparable (Ecs3 comparable a1 a2 a3 )
spec3 fn =
    Internal.Spec
        { empty =
            Ecs3
                { data1 = Dict.empty
                , data2 = Dict.empty
                , data3 = Dict.empty
                }
        , clear =
            \id (Ecs3 model) ->
                Ecs3
                    { data1 = Dict.remove id model.data1
                    , data2 = Dict.remove id model.data2
                    , data3 = Dict.remove id model.data3
                    }
        , isEmpty =
            \(Ecs3 model) ->
                Dict.isEmpty model.data1
                    && Dict.isEmpty model.data2
                    && Dict.isEmpty model.data3
        , componentCount =
            \(Ecs3 model) ->
                Dict.size model.data1
                    + Dict.size model.data2
                    + Dict.size model.data3
        , ids =
            \(Ecs3 model) ->
                [ Dict.keys model.data1
                , Dict.keys model.data2
                , Dict.keys model.data3
                ]
                    |> List.foldl
                        (\keys a ->
                            List.foldl (\key b -> Set.insert key b) a keys
                        )
                        Set.empty
        , member =
            \id (Ecs3 model) ->
                Dict.member id model.data1
                    || Dict.member id model.data2
                    || Dict.member id model.data3
        , components = components3 fn
        }


components3 :
    (ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a1
     -> ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a2
     -> ComponentSpec comparable (Ecs3 comparable a1 a2 a3 ) a3
     -> b
    )
    -> b
components3 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Ecs3 model) -> model.data1
            , update =
                \updateFn (Ecs3 model) ->
                    Ecs3
                        { data1 = updateFn model.data1
                        , data2 = model.data2
                        , data3 = model.data3
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Ecs3 model) -> model.data2
            , update =
                \updateFn (Ecs3 model) ->
                    Ecs3
                        { data1 = model.data1
                        , data2 = updateFn model.data2
                        , data3 = model.data3
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Ecs3 model) -> model.data3
            , update =
                \updateFn (Ecs3 model) ->
                    Ecs3
                        { data1 = model.data1
                        , data2 = model.data2
                        , data3 = updateFn model.data3
                        }
            }
        )
      