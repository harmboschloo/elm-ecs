module Core.Animation.Sequence exposing
    ( Animation
    , Config
    , NextConfig
    , andNext
    , animate
    , animation
    , delay
    , hasEnded
    , nextAnimation
    )

import Animation


type AnimationData a
    = AnimationData Data (List Data)


type Start
    = Start


type Next
    = Next


type alias Animation =
    AnimationData Start


type alias NextAnimation =
    AnimationData Next


type alias Data =
    { startTime : Float
    , delay : Float
    , duration : Float
    , from : Float
    , to : Float
    }


type alias Config =
    { startTime : Float
    , duration : Float
    , from : Float
    , to : Float
    }


animation : Config -> Animation
animation config =
    AnimationData
        { startTime = config.startTime
        , delay = 0
        , duration = config.duration
        , from = config.from
        , to = config.to
        }
        []


type alias NextConfig =
    { duration : Float
    , to : Float
    }


nextAnimation : NextConfig -> NextAnimation
nextAnimation config =
    AnimationData
        { startTime = 0
        , delay = 0
        , duration = config.duration
        , from = 0
        , to = config.to
        }
        []


andNext : NextAnimation -> Animation -> Animation
andNext (AnimationData nextData _) (AnimationData start appended) =
    let
        lastData =
            getLast start appended

        data =
            { startTime = getEndTime lastData
            , delay = nextData.delay
            , duration = nextData.duration
            , from = lastData.to
            , to = nextData.to
            }
    in
    AnimationData start (appended ++ [ data ])


delay : Float -> AnimationData a -> AnimationData a
delay deltaTime (AnimationData data appended) =
    AnimationData { data | delay = deltaTime } appended


getEndTime : Data -> Float
getEndTime data =
    data.startTime + data.delay + data.duration


getLast : Data -> List Data -> Data
getLast data appended =
    case appended of
        [] ->
            data

        head :: tail ->
            getLast head tail


getActive : Float -> Data -> List Data -> Data
getActive time data appended =
    if time < getEndTime data then
        data

    else
        case appended of
            [] ->
                data

            head :: tail ->
                getActive time head tail


animate : Float -> Animation -> Float
animate time (AnimationData start appended) =
    let
        data =
            getActive time start appended
    in
    Animation.animation data.startTime
        |> Animation.delay data.delay
        |> Animation.duration data.duration
        |> Animation.from data.from
        |> Animation.to data.to
        |> Animation.animate time


hasEnded : Float -> Animation -> Bool
hasEnded time (AnimationData start appended) =
    let
        data =
            getActive time start appended
    in
    if getEndTime data > time then
        False

    else
        True
