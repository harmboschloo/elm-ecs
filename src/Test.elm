module Test exposing (components, empty)

import Ecs.Api



--  COMPONENTS --


type alias Position =
    { x : Float, y : Float }


type alias Velocity =
    { x : Float, y : Float }


type OutOfBoundsResolution
    = Teleport
    | Destroy


type alias Color =
    String



-- ECS SETUP --


type alias Data =
    Ecs.Data Position Velocity OutOfBoundsResolution Color


type alias Component a =
    Ecs.Component Data a


type alias Components =
    { position : Component Position
    , velocity : Component Velocity
    , outOfBoundsResolution : Component OutOfBoundsResolution
    , color : Component Color
    }


empty : Data
empty =
    Ecs.empty


components : Components
components =
    Ecs.components Components
