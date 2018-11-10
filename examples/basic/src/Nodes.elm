module Nodes exposing (Bounce, Move, Render, Teleport)

import Components


type alias Move =
    { position : Components.Position
    , velocity : Components.Velocity
    }


type alias Bounce =
    { position : Components.Position
    , velocity : Components.Velocity
    , bounce : Components.Bounce
    }


type alias Teleport =
    { position : Components.Position
    , teleport : Components.Teleport
    }


type alias Render =
    { position : Components.Position
    , color : Components.Color
    }
