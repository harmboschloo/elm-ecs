module EcsSpecs exposing
    ( ComponentSpec
    , Ecs
    , Entity
    , EntitySpec
    , NodeSpec
    , SystemSpec
    , components
    , entity
    , nodes
    )

import Components
import Ecs
import Ecs.Entity5 as EcsEntity
import Ecs.Nodes as EcsNodes
import Nodes


type alias Ecs =
    Ecs.Ecs Components


type alias Entity =
    Ecs.Entity Components


type alias EntitySpec =
    Ecs.EntitySpec Components


type alias ComponentSpec a =
    Ecs.ComponentSpec Components a


type alias SystemSpec a =
    Ecs.SystemSpec Components a


type alias NodeSpec a =
    Ecs.NodeSpec Components a


type alias Components =
    { position : Maybe Components.Position
    , velocity : Maybe Components.Velocity
    , bounce : Maybe Components.Bounce
    , teleport : Maybe Components.Teleport
    , color : Maybe Components.Color
    }


type alias ComponentSpecs =
    { position : ComponentSpec Components.Position
    , velocity : ComponentSpec Components.Velocity
    , bounce : ComponentSpec Components.Bounce
    , teleport : ComponentSpec Components.Teleport
    , color : ComponentSpec Components.Color
    }


type alias NodeSpecs =
    { move : NodeSpec Nodes.Move
    , bounce : NodeSpec Nodes.Bounce
    , teleport : NodeSpec Nodes.Teleport
    , render : NodeSpec Nodes.Render
    }


entity : EntitySpec
entity =
    EcsEntity.entity Components


components : ComponentSpecs
components =
    EcsEntity.components
        ComponentSpecs
        Components
        .position
        .velocity
        .bounce
        .teleport
        .color


nodes : NodeSpecs
nodes =
    NodeSpecs
        (EcsNodes.node2 Nodes.Move
            components.position
            components.velocity
        )
        (EcsNodes.node3 Nodes.Bounce
            components.position
            components.velocity
            components.bounce
        )
        (EcsNodes.node2 Nodes.Teleport
            components.position
            components.teleport
        )
        (EcsNodes.node2 Nodes.Render
            components.position
            components.color
        )
