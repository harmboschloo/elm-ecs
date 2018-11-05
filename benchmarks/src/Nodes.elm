module Nodes exposing (A, Ab, Abc)

import Components


type alias A =
    { a : Components.A
    }


type alias Ab =
    { a : Components.A
    , b : Components.B
    }


type alias Abc =
    { a : Components.A
    , b : Components.B
    , c : Components.C
    }
