module Utils exposing (times)


times : Int -> (a -> a) -> a -> a
times count function value =
    if count <= 0 then
        value

    else
        times (count - 1) function (function value)
