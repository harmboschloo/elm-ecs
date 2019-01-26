module V2W.Ecs.Operation exposing
    ( create, destroy
    , insertAll, insertEntry, insert, remove
    )

{-|

@docs create, destroy
@docs insertAll, insertEntry, insert, remove

-}

import V2W.Ecs as Ecs
import V2W.Ecs.Internal as Internal
    exposing
        ( ComponentEntry(..)
        , ComponentSpec(..)
        , EntityId
        )


type alias Operation data =
    Internal.Operation data


create : List (ComponentEntry data) -> Operation data
create =
    Internal.Create


destroy : EntityId -> Operation data
destroy =
    Internal.Destroy


insertAll : EntityId -> List (ComponentEntry data) -> Operation data
insertAll =
    Internal.InsertAll


insertEntry : EntityId -> ComponentEntry data -> Operation data
insertEntry entityId entry =
    Internal.Insert entityId entry


insert : ComponentSpec data a -> EntityId -> a -> Operation data
insert spec entityId value =
    Internal.Insert entityId (Ecs.entry spec value)


remove : ComponentSpec data a -> EntityId -> Operation data
remove (ComponentSpec spec) entityId =
    Internal.Remove entityId spec.id
