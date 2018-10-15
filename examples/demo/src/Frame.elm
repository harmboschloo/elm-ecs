module Frame exposing
    ( Frame
    , HistoryDataPoint
    , Msg
    , OutMsg(..)
    , getHistory
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
        , accumulatedTime : Float
        , history : BoundedDeque HistoryDataPoint
        }


type alias HistoryDataPoint =
    { index : Int
    , deltaTime : Float
    , updateTime : Float
    , frameTime : Float
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


init : { maxDeltaTime : Float, maxHistory : Int } -> Frame
init { maxDeltaTime, maxHistory } =
    Model
        { state = Initializing
        , maxDeltaTime = maxDeltaTime
        , accumulatedTime = 0
        , history = BoundedDeque.empty maxHistory
        }


getHistory : Frame -> List HistoryDataPoint
getHistory (Model model) =
    BoundedDeque.toList model.history


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
        (Cmd Msg)


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
                    BoundedDeque.last model.history
                        |> Maybe.map (\d -> d.index + 1)
                        |> Maybe.withDefault 1

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
                    , accumulatedTime = accumulatedTime
                    , history =
                        case data.updateData of
                            Nothing ->
                                model.history

                            Just updateData ->
                                BoundedDeque.pushBack
                                    { index = index
                                    , deltaTime = updateData.deltaTime
                                    , updateTime = updateData.updateTime
                                    , frameTime = frameTime
                                    }
                                    model.history
                }
            , Update
                { deltaTime = deltaTime
                , accumulatedTime = accumulatedTime
                }
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
