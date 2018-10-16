module History exposing
    ( History
    , add
    , empty
    , getMeanFps
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


getMeanFps : Int -> History -> Float
getMeanFps n (Model model) =
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
