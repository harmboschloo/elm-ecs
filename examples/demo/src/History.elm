module History exposing
    ( History
    , add
    , empty
    , getFps
    , getFpsMean
    , getFpsMedium
    , view
    )

import BoundedDeque exposing (BoundedDeque)
import Html exposing (Html)
import Html.Attributes exposing (style)
import Plot



-- Model


type History
    = Model (BoundedDeque DataPoint)


type alias DataPoint =
    { index : Int
    , updateTime : Float
    , frameTime : Float
    , entityCount : Int
    }


empty : Int -> History
empty maxSize =
    Model (BoundedDeque.empty maxSize)


add : DataPoint -> History -> History
add data (Model model) =
    Model (BoundedDeque.pushBack data model)


getFps : History -> Float
getFps =
    getFpsMedium 50


getFpsMean : Int -> History -> Float
getFpsMean n (Model model) =
    let
        ( totalSum, totalSize ) =
            List.foldl
                (\point ( sum, size ) -> ( sum + point.frameTime, size + 1 ))
                ( 0, 0 )
                (BoundedDeque.takeBack n model)
    in
    if totalSum > 0 then
        totalSize / totalSum

    else
        0


getFpsMedium : Int -> History -> Float
getFpsMedium n (Model model) =
    let
        length =
            min (BoundedDeque.length model) n

        times =
            model
                |> BoundedDeque.takeBack length
                |> List.map .frameTime
                |> List.sort

        mediumTimes =
            if isEven length then
                times
                    |> List.drop ((length // 2) - 1)
                    |> List.take 2

            else
                times
                    |> List.drop (length // 2)
                    |> List.take 1

        deltaTime =
            case mediumTimes of
                a :: [] ->
                    a

                a :: b :: [] ->
                    (a + b) / 2

                _ ->
                    0
    in
    if deltaTime > 0 then
        1 / deltaTime

    else
        0


isEven : Int -> Bool
isEven n =
    modBy 2 n == 0


view : History -> Html msg
view (Model model) =
    let
        data =
            BoundedDeque.toList model
    in
    Html.div
        [ style "background-color" "#fff"
        , style "padding" "10px"
        ]
        [ Plot.viewSeries
            [ Plot.line
                (List.map
                    (\point ->
                        Plot.clear
                            (toFloat point.index)
                            point.frameTime
                    )
                )
            , Plot.line
                (List.map
                    (\point ->
                        Plot.clear
                            (toFloat point.index)
                            point.updateTime
                    )
                )
            ]
            data
        , Plot.viewSeries
            [ Plot.line
                (List.map
                    (\point ->
                        Plot.clear
                            (toFloat point.index)
                            (toFloat point.entityCount)
                    )
                )
            ]
            data
        ]
