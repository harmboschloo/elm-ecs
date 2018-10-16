module Frame exposing
    ( Frame
    , Msg
    , OutMsg(..)
    , Stats
    , init
    , isPaused
    , subscriptions
    , togglePaused
    , update
    )

import BoundedDeque exposing (BoundedDeque)
import Browser.Events exposing (onAnimationFrame)
import Task
import Time exposing (Posix)



-- Model


type Frame
    = Model
        { state : State
        , maxDeltaTime : Float
        , index : Int
        , accumulatedTime : Float
        }


type State
    = Paused
    | Initializing
    | NextFramePending
        { startTime : Float
        , updateData :
            Maybe
                { deltaTime : Float
                , updateTime : Float
                }
        }
    | FrameUpdatePending
        { startTime : Float
        , deltaTime : Float
        }


init : Float  -> Frame
init maxDeltaTime =
    Model
        { state = Initializing
        , maxDeltaTime = maxDeltaTime
        , index = 0
        , accumulatedTime = 0
        }


togglePaused : Frame -> Frame
togglePaused (Model model) =
    case model.state of
        Paused ->
            Model { model | state = Initializing }

        _ ->
            Model { model | state = Paused }


isPaused : Frame -> Bool
isPaused (Model model) =
    case model.state of
        Paused ->
            True

        _ ->
            False



-- Update


type Msg
    = OnAnimationFrame Posix
    | OnUpdateTime Posix


type OutMsg
    = NoOp
    | Update
        { deltaTime : Float
        , accumulatedTime : Float
        }
        (Maybe Stats)
        (Cmd Msg)


type alias Stats =
    { index : Int
    , deltaTime : Float
    , updateTime : Float
    , frameTime : Float
    }


update : Msg -> Frame -> ( Frame, OutMsg )
update msg (Model model) =
    case ( model.state, msg ) of
        ( Initializing, OnAnimationFrame posix ) ->
            ( Model
                { model
                    | state =
                        NextFramePending
                            { startTime = getSeconds posix
                            , updateData = Nothing
                            }
                }
            , NoOp
            )

        ( NextFramePending data, OnAnimationFrame posix ) ->
            let
                time =
                    getSeconds posix

                frameTime =
                    time - data.startTime

                deltaTime =
                    min frameTime model.maxDeltaTime

                index =
                    model.index + 1

                accumulatedTime =
                    model.accumulatedTime + deltaTime
            in
            ( Model
                { model
                    | state =
                        FrameUpdatePending
                            { startTime = time
                            , deltaTime = deltaTime
                            }
                    , index = index
                    , accumulatedTime = accumulatedTime
                }
            , Update
                { deltaTime = deltaTime
                , accumulatedTime = accumulatedTime
                }
                (Maybe.map
                    (\updateData ->
                        { index = model.index
                        , deltaTime = updateData.deltaTime
                        , updateTime = updateData.updateTime
                        , frameTime = frameTime
                        }
                    )
                    data.updateData
                )
                (Task.perform OnUpdateTime Time.now)
            )

        ( FrameUpdatePending data, OnUpdateTime posix ) ->
            let
                updateTime =
                    getSeconds posix - data.startTime
            in
            ( Model
                { model
                    | state =
                        NextFramePending
                            { startTime = data.startTime
                            , updateData =
                                Just
                                    { deltaTime = data.deltaTime
                                    , updateTime = updateTime
                                    }
                            }
                }
            , NoOp
            )

        _ ->
            ( Model model, NoOp )


getSeconds : Posix -> Float
getSeconds posix =
    toFloat (Time.posixToMillis posix) / 1000



-- Subscriptions


subscriptions : Frame -> Sub Msg
subscriptions (Model model) =
    case model.state of
        Paused ->
            Sub.none

        _ ->
            onAnimationFrame OnAnimationFrame
