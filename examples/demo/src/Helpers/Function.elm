module Helpers.Function exposing (pipeTimes)


pipeTimes : Int -> (a -> a) -> a -> a
pipeTimes count function value =
    if count <= 0 then
        value

    else
        pipeTimes (count - 1) function (function value)
