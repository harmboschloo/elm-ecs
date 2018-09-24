module Data.Clamped exposing (Clamped, get, init, set, update)


type Clamped number
    = Clamped number number number


init : number -> number -> number -> Clamped number
init min max value =
    Clamped min max (clamp min max value)


set : number -> Clamped number -> Clamped number
set value (Clamped min max _) =
    init min max value


update : (number -> number) -> Clamped number -> Clamped number
update updateValue (Clamped min max value) =
    init min max (updateValue value)


get : Clamped number -> number
get (Clamped _ _ value) =
    value
