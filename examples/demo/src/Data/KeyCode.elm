module Data.KeyCode exposing
    ( KeyCode
    , arrowDown
    , arrowLeft
    , arrowRight
    , arrowUp
    , esc
    , t
    )


type alias KeyCode =
    Int


esc : KeyCode
esc =
    27


arrowLeft : KeyCode
arrowLeft =
    37


arrowUp : KeyCode
arrowUp =
    38


arrowRight : KeyCode
arrowRight =
    39


arrowDown : KeyCode
arrowDown =
    40


t : KeyCode
t =
    84
