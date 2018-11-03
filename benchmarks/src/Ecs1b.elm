module Ecs1b exposing (Ecs, components, container)

import Components
import Ecs.Ecs1 as Ecs


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


components : ComponentSpecs
components =
    specs.components
