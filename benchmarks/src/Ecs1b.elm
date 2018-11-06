module Ecs1b exposing (Ecs, a, aNode, abNode, abcNode, b, c)

import Components
import Ecs1.Ecs3 as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Components.A Components.B Components.C


type alias ComponentSpec a =
    Ecs.ComponentSpec Components.A Components.B Components.C a


type alias NodeSpec a x =
    Ecs.NodeSpec Components.A Components.B Components.C a x


a : ComponentSpec Components.A
a =
    Ecs.component1


b : ComponentSpec Components.B
b =
    Ecs.component2


c : ComponentSpec Components.C
c =
    Ecs.component3


aNode : NodeSpec  Nodes.A x
aNode =
    Ecs.node1 Nodes.A a


abNode : NodeSpec  Nodes.Ab x
abNode =
    Ecs.node2 Nodes.Ab a b


abcNode : NodeSpec Nodes.Abc x
abcNode =
    Ecs.node3 Nodes.Abc a b c
