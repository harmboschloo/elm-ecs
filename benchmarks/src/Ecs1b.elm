module Ecs1b exposing (Ecs, a, aNode, abNode, abcNode, b, c, container)

import Components
import Ecs.Ecs1 as Ecs
import Nodes


type alias Ecs =
    Ecs.Ecs Container


type alias Container =
    { a : Ecs.Components Components.A
    , b : Ecs.Components Components.B
    , c : Ecs.Components Components.C
    }


type alias ComponentSpecs =
    { a : Ecs.ComponentSpec Container Components.A
    , b : Ecs.ComponentSpec Container Components.B
    , c : Ecs.ComponentSpec Container Components.C
    }


specs : Ecs.Specs Container ComponentSpecs
specs =
    Ecs.specs3 Container ComponentSpecs .a .b .c


container : Ecs.ContainerSpec Container
container =
    specs.container


a : Ecs.ComponentSpec Container Components.A
a =
    specs.components.a


b : Ecs.ComponentSpec Container Components.B
b =
    specs.components.b


c : Ecs.ComponentSpec Container Components.C
c =
    specs.components.c


aNode : Ecs.NodeSpec x Container Nodes.A
aNode =
    Ecs.node1 Nodes.A a


abNode : Ecs.NodeSpec x Container Nodes.Ab
abNode =
    Ecs.node2 Nodes.Ab a b


abcNode : Ecs.NodeSpec x Container Nodes.Abc
abcNode =
    Ecs.node3 Nodes.Abc a b c
