module Ecs exposing
    ( Ecs, empty, create, commit, checkout, size, activeSize
    , EntitySpec, Entity, copy, clear, destroy, getId
    , ComponentSpec, set, get, update, remove
    , SystemSpec, SystemConfig, NodeSpec, system, processor, process
    )

{-| Entitiy-Component-System.


# Model

@docs Ecs, empty, create, commit, checkout, size, activeSize


# Entities

@docs EntitySpec, Entity, copy, clear, destroy, getId


# Components

@docs ComponentSpec, set, get, update, remove


# Systems

@docs SystemSpec, SystemConfig, NodeSpec, system, processor, process

-}

import Ecs.Internal as Internal



-- MODEL --


{-| -}
type alias Ecs components =
    Internal.Ecs components


{-| -}
empty : Ecs components
empty =
    Internal.empty


{-| -}
create :
    EntitySpec components
    -> (Entity components -> Entity components)
    -> Ecs components
    -> ( Entity components, Ecs components )
create =
    Internal.create


{-| -}
commit :
    ( Entity components, Ecs components )
    -> ( Entity components, Ecs components )
commit =
    Internal.commit


{-| -}
checkout : Entity components -> Ecs components -> Entity components
checkout =
    Internal.checkout


{-| -}
size : Ecs components -> Int
size =
    Internal.size


{-| -}
activeSize : Ecs components -> Int
activeSize =
    Internal.activeSize



-- ENTITIES --


{-| -}
type alias EntitySpec components =
    Internal.EntitySpec components


{-| -}
type alias Entity components =
    Internal.Entity components


{-| -}
copy : Entity components -> Entity components -> Entity components
copy =
    Internal.copy


{-| -}
clear : EntitySpec components -> Entity components -> Entity components
clear =
    Internal.clear


{-| -}
destroy : Entity components -> Entity components
destroy =
    Internal.destroy


{-| -}
getId : Entity components -> Int
getId =
    Internal.getId



-- COMPONENTS --


{-| -}
type alias ComponentSpec components component =
    Internal.ComponentSpec components component


{-| -}
get :
    ComponentSpec components component
    -> Entity components
    -> Maybe component
get =
    Internal.get


{-| -}
set :
    ComponentSpec components component
    -> component
    -> Entity components
    -> Entity components
set =
    Internal.set


{-| -}
update :
    ComponentSpec components component
    -> (Maybe component -> Maybe component)
    -> Entity components
    -> Entity components
update =
    Internal.update


{-| -}
remove : ComponentSpec components component -> Entity components -> Entity components
remove =
    Internal.remove



-- SYSTEMS --


type alias SystemSpec components a =
    Internal.SystemSpec components a


type alias SystemConfig components node a =
    { node : NodeSpec components node
    , preProcess : ( Ecs components, a ) -> ( Ecs components, a )
    , process : node -> ( Entity components, a ) -> ( Entity components, a )
    , postProcess : ( Ecs components, a ) -> ( Ecs components, a )
    }


type alias NodeSpec components node =
    Internal.NodeSpec components node


system : SystemConfig components node a -> SystemSpec components a
system =
    Internal.system


processor :
    NodeSpec components node
    -> (node -> ( Entity components, a ) -> ( Entity components, a ))
    -> SystemSpec components a
processor =
    Internal.processor


process :
    List (SystemSpec components a)
    -> ( Ecs components, a )
    -> ( Ecs components, a )
process =
    Internal.process
