module Components exposing (Bounce, Color, Position, Teleport, Velocity)


type alias Bounce =
    { damping : Float }


type alias Teleport =
    ()


type alias Color =
    String


type alias Position =
    { x : Float, y : Float }


type alias Velocity =
    { x : Float, y : Float }
