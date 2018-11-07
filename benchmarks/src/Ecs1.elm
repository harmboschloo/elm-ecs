module Ecs1 exposing (Ecs, components, nodes)

import Components
import Ecs1.Dict3 as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Components.A Components.B Components.C


type alias ComponentSpec a =
    Ecs.ComponentSpec Components.A Components.B Components.C a


type alias NodeSpec a x =
    Ecs.NodeSpec Components.A Components.B Components.C a x


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
        (Ecs.nodeSpec1 Nodes.A components.a)
        (Ecs.nodeSpec2 Nodes.Ab components.a components.b)
        (Ecs.nodeSpec3 Nodes.Abc components.a components.b components.c)
