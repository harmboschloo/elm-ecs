module Frame exposing
    ( Frame
    , FrameData
    , Msg
    , UpdateMsg(..)
    , getHistory
    , init
    , isPaused
    , maximum
    , mean
    , medium
    , minimum
    , setPaused
    , subscriptions
    , togglePaused
    , update
    )

import Browser.Events exposing (onAnimationFrame)
import Task
import Time exposing (Posix)



-- Frame


type Frame
    = Frame Model


type alias Model =
    { state : Global
    , maxDeltaTime : Float
    , frameCount : Int
    , accumulatedTime : Float
    , historyFrameCount : Int
    , history : List FrameData
    }


type Global
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


init : Float -> Int -> Frame
init maxDeltaTime historyFrameCount =
    Frame
        { state = Initializing
        , maxDeltaTime = maxDeltaTime
        , frameCount = 0
        , accumulatedTime = 0
        , historyFrameCount = historyFrameCount
        , history = []
        }


isPaused : Frame -> Bool
isPaused (Frame model) =
    case model.state of
        Paused ->
            True

        _ ->
            False


setPaused : Bool -> Frame -> Frame
setPaused paused (Frame model) =
    case model.state of
        Paused ->
            if not paused then
                Frame { model | state = Initializing }

            else
                Frame model

        _ ->
            if paused then
                Frame { model | state = Paused }

            else
                Frame model


togglePaused : Frame -> Frame
togglePaused (Frame model) =
    case model.state of
        Paused ->
            Frame { model | state = Initializing }

        _ ->
            Frame { model | state = Paused }


getHistory : Frame -> List FrameData
getHistory (Frame model) =
    List.reverse model.history



-- Update


type Msg
    = OnAnimationFrame Posix
    | OnUpdateTime Posix


type UpdateMsg
    = None
    | Update
        { deltaTime : Float
        , accumulatedTime : Float
        }
        (Cmd Msg)


type alias FrameData =
    { frameCount : Int
    , deltaTime : Float
    , updateTime : Float
    , frameTime : Float
    }


update : Msg -> Frame -> ( Frame, UpdateMsg )
update msg (Frame model) =
    case ( model.state, msg ) of
        ( Initializing, OnAnimationFrame posix ) ->
            ( Frame
                { model
                    | state =
                        NextFramePending
                            { startTime = getSeconds posix
                            , updateData = Nothing
                            }
                }
            , None
            )

        ( NextFramePending data, OnAnimationFrame posix ) ->
            let
                time =
                    getSeconds posix

                frameTime =
                    time - data.startTime

                deltaTime =
                    min frameTime model.maxDeltaTime

                frameCount =
                    model.frameCount + 1

                accumulatedTime =
                    model.accumulatedTime + deltaTime

                history =
                    case data.updateData of
                        Nothing ->
                            model.history

                        Just updateData ->
                            addHistoryFrame
                                { frameCount = model.frameCount
                                , deltaTime = updateData.deltaTime
                                , updateTime = updateData.updateTime
                                , frameTime = frameTime
                                }
                                model.historyFrameCount
                                model.history
            in
            ( Frame
                { model
                    | state =
                        FrameUpdatePending
                            { startTime = time
                            , deltaTime = deltaTime
                            }
                    , frameCount = frameCount
                    , accumulatedTime = accumulatedTime
                    , history = history
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
            ( Frame
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
            , None
            )

        _ ->
            ( Frame model, None )


getSeconds : Posix -> Float
getSeconds posix =
    toFloat (Time.posixToMillis posix) / 1000


addHistoryFrame : FrameData -> Int -> List FrameData -> List FrameData
addHistoryFrame data historyFrameCount history =
    data :: List.take (historyFrameCount - 1) history


mean : (FrameData -> Float) -> Frame -> Float
mean getData (Frame model) =
    let
        ( length, sum ) =
            List.foldl
                (\data ( n, s ) -> ( n + 1, s + getData data ))
                ( 0, 0 )
                model.history
    in
    if length > 0 then
        sum / toFloat length

    else
        0


medium : (FrameData -> Float) -> Frame -> Float
medium getData (Frame model) =
    let
        length =
            List.length model.history

        data =
            model.history
                |> List.map getData
                |> List.sort

        mediumData =
            if isEven length then
                data
                    |> List.drop ((length // 2) - 1)
                    |> List.take 2

            else
                data
                    |> List.drop (length // 2)
                    |> List.take 1

        value =
            case mediumData of
                a :: [] ->
                    a

                a :: b :: [] ->
                    (a + b) / 2

                _ ->
                    0
    in
    value


minimum : (FrameData -> Float) -> Frame -> Float
minimum getData (Frame model) =
    model.history
        |> List.map getData
        |> List.minimum
        |> Maybe.withDefault 0


maximum : (FrameData -> Float) -> Frame -> Float
maximum getData (Frame model) =
    model.history
        |> List.map getData
        |> List.maximum
        |> Maybe.withDefault 0


isEven : Int -> Bool
isEven n =
    modBy 2 n == 0



-- Subscriptions


subscriptions : Frame -> Sub Msg
subscriptions (Frame model) =
    case model.state of
        Paused ->
            Sub.none

        _ ->
            onAnimationFrame OnAnimationFrame
