module EcsGenerator.Utils exposing
    ( append
    , firstToLower
    , firstToUpper
    , replace
    )


firstToLower : String -> String
firstToLower string =
    (String.left 1 string |> String.toLower) ++ String.dropLeft 1 string


firstToUpper : String -> String
firstToUpper string =
    (String.left 1 string |> String.toUpper) ++ String.dropLeft 1 string


append : String -> String -> String
append last first =
    first ++ last


replace : String -> String -> String -> String
replace from to =
    String.split from
        >> String.join to
