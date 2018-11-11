module Ecs8b exposing
    ( ComponentSpec
    , Ecs
    , EntitySpec
    , NodeSpec
    , SystemSpec
    , components
    , entity
    , nodes
    )

import Components
import Ecs8b.Ecs as Ecs
import Ecs8b.Entity3 as Ecs
import Ecs8b.Nodes as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Components


type alias EntitySpec =
    Ecs.EntitySpec Components


type alias ComponentSpec a =
    Ecs.ComponentSpec Components a


type alias SystemSpec a =
    Ecs.SystemSpec Components a


type alias NodeSpec a =
    Ecs.NodeSpec Components a


type alias Components =
    { a : Maybe Components.A
    , b : Maybe Components.B
    , c : Maybe Components.C
    }


type alias ComponentSpecs =
    { a : ComponentSpec Components.A
    , b : ComponentSpec Components.B
    , c : ComponentSpec Components.C
    }


type alias NodeSpecs =
    { a : NodeSpec Nodes.A
    , ab : NodeSpec Nodes.Ab
    , abc : NodeSpec Nodes.Abc
    }


entity : EntitySpec
entity =
    Ecs.entity Components


components : ComponentSpecs
components =
    Ecs.components ComponentSpecs Components .a .b .c


nodes : NodeSpecs
nodes =
    NodeSpecs
        (Ecs.node1 Nodes.A components.a)
        (Ecs.node2 Nodes.Ab components.a components.b)
        (Ecs.node3 Nodes.Abc components.a components.b components.c)
