module Ecs8 exposing (Ecs, components, nodes)

import Components
import Ecs8.Entity3 as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Components.A Components.B Components.C


type alias ComponentSpec a =
    Ecs.ComponentSpec Components.A Components.B Components.C a


type alias EntityUpdate x =
    Ecs.EntityUpdate Components.A Components.B Components.C x


type alias NodeSpec node x =
    (node -> EntityUpdate x) -> EntityUpdate x


type alias ComponentSpecs =
    { a : ComponentSpec Components.A
    , b : ComponentSpec Components.B
    , c : ComponentSpec Components.C
    }


type alias NodeSpecs x =
    { a : NodeSpec Nodes.A x
    , ab : NodeSpec Nodes.Ab x
    , abc : NodeSpec Nodes.Abc x
    }


components : ComponentSpecs
components =
    Ecs.componentSpecs ComponentSpecs


nodes : NodeSpecs x
nodes =
    NodeSpecs
        (Ecs.nodeUpdate1 Nodes.A components.a)
        (Ecs.nodeUpdate2 Nodes.Ab components.a components.b)
        (Ecs.nodeUpdate3 Nodes.Abc components.a components.b components.c)
