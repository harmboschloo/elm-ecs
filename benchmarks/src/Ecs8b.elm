module Ecs8b exposing
    ( ComponentType
    , Ecs
    , EntityType
    , NodeType
    , System
    , components
    , entity
    , nodes
    )

import Components
import Ecs8b.Ecs as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Components


type alias EntityType =
    Ecs.EntityType Components


type alias ComponentType a =
    Ecs.ComponentType Components a


type alias NodeType a =
    Ecs.NodeType Components a


type alias System a =
    Ecs.System Components a


type alias Components =
    { a : Maybe Components.A
    , b : Maybe Components.B
    , c : Maybe Components.C
    }


type alias ComponentTypes =
    { a : ComponentType Components.A
    , b : ComponentType Components.B
    , c : ComponentType Components.C
    }


type alias NodeTypes =
    { a : NodeType Nodes.A
    , ab : NodeType Nodes.Ab
    , abc : NodeType Nodes.Abc
    }


entity : EntityType
entity =
    Ecs.entity3 Components


components : ComponentTypes
components =
    Ecs.components3 ComponentTypes Components .a .b .c


nodes : NodeTypes
nodes =
    NodeTypes
        (Ecs.node1 Nodes.A components.a)
        (Ecs.node2 Nodes.Ab components.a components.b)
        (Ecs.node3 Nodes.Abc components.a components.b components.c)
