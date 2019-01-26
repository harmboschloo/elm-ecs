module Ecs.Spec exposing
    ( Spec, ComponentSpec
    , Ecs1, spec1, components1
    , Ecs2, spec2, components2
    , Ecs3, spec3, components3
    )

{-|

@docs Spec, ComponentSpec
@docs Ecs1, spec1, components1
@docs Ecs2, spec2, components2
@docs Ecs3, spec3, components3

-}

import Dict exposing (Dict)
import Ecs.Internal as Internal
import Ecs.Internal.Record1 as Record1
import Ecs.Internal.Record2 as Record2
import Ecs.Internal.Record3 as Record3
import Set exposing (Set)


{-| The ecs specification type.
-}
type alias Spec ecs =
    Internal.Spec ecs


{-| A component specification type.
-}
type alias ComponentSpec ecs a =
    Internal.ComponentSpec ecs a


{-| An ecs model type with 1 component type.
-}
type Ecs1 a1
    = Ecs1
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , data : Record1.Record (Dict Int a1)
        }


{-| An ecs specification with 1 component type.
-}
spec1 : Spec (Ecs1 a1)
spec1 =
    Internal.Spec
        { empty =
            Ecs1
                { entities =
                    { nextId = 0
                    , activeIds = Set.empty
                    }
                , data =
                    { a1 = Dict.empty
                    }
                }
        , clear =
            \(Internal.EntityId entityId) (Ecs1 { entities, data }) ->
                Ecs1
                    { entities = entities
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        }
                    }
        , isEmpty =
            \(Ecs1 { data }) ->
                Dict.isEmpty data.a1
        , componentCount =
            \(Ecs1 { data }) ->
                Dict.size data.a1
        , ids =
            \(Ecs1 { entities }) ->
                entities.activeIds
        , member =
            \(Internal.EntityId entityId) (Ecs1 { entities }) ->
                Set.member entityId entities.activeIds
        , create =
            \(Ecs1 { entities, data }) ->
                ( Ecs1
                    { entities =
                        { nextId = entities.nextId + 1
                        , activeIds = Set.insert entities.nextId entities.activeIds
                        }
                    , data = data
                    }
                , Internal.EntityId (entities.nextId + 1)
                )
        , destroy =
            \(Internal.EntityId entityId) (Ecs1 { entities, data }) ->
                Ecs1
                    { entities =
                        { nextId = entities.nextId
                        , activeIds = Set.remove entityId entities.activeIds
                        }

                    -- TODO refactor with clear
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        }
                    }
        }


{-| Create component specifications for an ecs with 1 component type.
-}
components1 :
    (ComponentSpec (Ecs1 a1) a1
     -> componentSpecs
    )
    -> componentSpecs
components1 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Ecs1 { data }) -> data.a1
            , update =
                \updateFn (Ecs1 { entities, data }) ->
                    Ecs1
                        { entities = entities
                        , data = Record1.update1 updateFn data
                        }
            }
        )


{-| An ecs model type with 2 component types.
-}
type Ecs2 a1 a2
    = Ecs2
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , data : Record2.Record (Dict Int a1) (Dict Int a2)
        }


{-| An ecs specification with 2 component types.
-}
spec2 : Spec (Ecs2 a1 a2)
spec2 =
    Internal.Spec
        { empty =
            Ecs2
                { entities =
                    { nextId = 0
                    , activeIds = Set.empty
                    }
                , data =
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    }
                }
        , clear =
            \(Internal.EntityId entityId) (Ecs2 { entities, data }) ->
                Ecs2
                    { entities = entities
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        , a2 = Dict.remove entityId data.a2
                        }
                    }
        , isEmpty =
            \(Ecs2 { data }) ->
                Dict.isEmpty data.a1
                    && Dict.isEmpty data.a2
        , componentCount =
            \(Ecs2 { data }) ->
                Dict.size data.a1
                    + Dict.size data.a2
        , ids =
            \(Ecs2 { entities }) ->
                entities.activeIds
        , member =
            \(Internal.EntityId entityId) (Ecs2 { entities }) ->
                Set.member entityId entities.activeIds
        , create =
            \(Ecs2 { entities, data }) ->
                ( Ecs2
                    { entities =
                        { nextId = entities.nextId + 1
                        , activeIds = Set.insert entities.nextId entities.activeIds
                        }
                    , data = data
                    }
                , Internal.EntityId (entities.nextId + 1)
                )
        , destroy =
            \(Internal.EntityId entityId) (Ecs2 { entities, data }) ->
                Ecs2
                    { entities =
                        { nextId = entities.nextId
                        , activeIds = Set.remove entityId entities.activeIds
                        }

                    -- TODO refactor with clear
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        , a2 = Dict.remove entityId data.a2
                        }
                    }
        }


{-| Create component specifications for an ecs with 2 component types.
-}
components2 :
    (ComponentSpec (Ecs2 a1 a2) a1
     -> ComponentSpec (Ecs2 a1 a2) a2
     -> componentSpecs
    )
    -> componentSpecs
components2 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Ecs2 { data }) -> data.a1
            , update =
                \updateFn (Ecs2 { entities, data }) ->
                    Ecs2
                        { entities = entities
                        , data = Record2.update1 updateFn data
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Ecs2 { data }) -> data.a2
            , update =
                \updateFn (Ecs2 { entities, data }) ->
                    Ecs2
                        { entities = entities
                        , data = Record2.update2 updateFn data
                        }
            }
        )


{-| An ecs model type with 3 component types.
-}
type Ecs3 a1 a2 a3
    = Ecs3
        { entities :
            { nextId : Int
            , activeIds : Set Int
            }
        , data : Record3.Record (Dict Int a1) (Dict Int a2) (Dict Int a3)
        }


{-| An ecs specification with 3 component types.
-}
spec3 : Spec (Ecs3 a1 a2 a3)
spec3 =
    Internal.Spec
        { empty =
            Ecs3
                { entities =
                    { nextId = 0
                    , activeIds = Set.empty
                    }
                , data =
                    { a1 = Dict.empty
                    , a2 = Dict.empty
                    , a3 = Dict.empty
                    }
                }
        , clear =
            \(Internal.EntityId entityId) (Ecs3 { entities, data }) ->
                Ecs3
                    { entities = entities
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        , a2 = Dict.remove entityId data.a2
                        , a3 = Dict.remove entityId data.a3
                        }
                    }
        , isEmpty =
            \(Ecs3 { data }) ->
                Dict.isEmpty data.a1
                    && Dict.isEmpty data.a2
                    && Dict.isEmpty data.a3
        , componentCount =
            \(Ecs3 { data }) ->
                Dict.size data.a1
                    + Dict.size data.a2
                    + Dict.size data.a3
        , ids =
            \(Ecs3 { entities }) ->
                entities.activeIds
        , member =
            \(Internal.EntityId entityId) (Ecs3 { entities }) ->
                Set.member entityId entities.activeIds
        , create =
            \(Ecs3 { entities, data }) ->
                ( Ecs3
                    { entities =
                        { nextId = entities.nextId + 1
                        , activeIds = Set.insert entities.nextId entities.activeIds
                        }
                    , data = data
                    }
                , Internal.EntityId (entities.nextId + 1)
                )
        , destroy =
            \(Internal.EntityId entityId) (Ecs3 { entities, data }) ->
                Ecs3
                    { entities =
                        { nextId = entities.nextId
                        , activeIds = Set.remove entityId entities.activeIds
                        }

                    -- TODO refactor with clear
                    , data =
                        { a1 = Dict.remove entityId data.a1
                        , a2 = Dict.remove entityId data.a2
                        , a3 = Dict.remove entityId data.a3
                        }
                    }
        }


{-| Create component specifications for an ecs with 3 component types.
-}
components3 :
    (ComponentSpec (Ecs3 a1 a2 a3) a1
     -> ComponentSpec (Ecs3 a1 a2 a3) a2
     -> ComponentSpec (Ecs3 a1 a2 a3) a3
     -> componentSpecs
    )
    -> componentSpecs
components3 fn =
    fn
        (Internal.ComponentSpec
            { get = \(Ecs3 { data }) -> data.a1
            , update =
                \updateFn (Ecs3 { entities, data }) ->
                    Ecs3
                        { entities = entities
                        , data = Record3.update1 updateFn data
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Ecs3 { data }) -> data.a2
            , update =
                \updateFn (Ecs3 { entities, data }) ->
                    Ecs3
                        { entities = entities
                        , data = Record3.update2 updateFn data
                        }
            }
        )
        (Internal.ComponentSpec
            { get = \(Ecs3 { data }) -> data.a3
            , update =
                \updateFn (Ecs3 { entities, data }) ->
                    Ecs3
                        { entities = entities
                        , data = Record3.update3 updateFn data
                        }
            }
        )
