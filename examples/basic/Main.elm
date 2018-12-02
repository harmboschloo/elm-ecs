module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Events
import Ecs exposing (Ecs)
import Html
import Html.Attributes



--  SPAWN SYSTEM --


spawnEntities : ( State, Ecs ) -> ( State, Ecs )
spawnEntities ( state, ecs ) =
    let
        ( id, newState ) =
            addEntity state

        position =
            { x = remainderBy state.worldWidth state.frameCount |> toFloat
            , y = remainderBy state.worldHeight (state.frameCount * 5) |> toFloat
            }

        display =
            if remainderBy 6 state.frameCount == 0 then
                Ecs.Image
                    { src = "./h.png"
                    , width = 16
                    , height = 16
                    }

            else
                Ecs.Circle
                    { radius = 5
                    , color = getColor state.frameCount
                    }
    in
    if remainderBy 10 state.frameCount == 0 then
        ( newState
        , ecs
            |> Ecs.insert .position id position
            |> Ecs.insert .display id display
        )

    else
        let
            velocity =
                { x = (remainderBy 5 state.frameCount - 2) * 75 |> toFloat
                , y = (remainderBy 7 state.frameCount - 3) * 50 |> toFloat
                }

            outOfBoundsResolution =
                if remainderBy 4 state.frameCount == 0 then
                    Ecs.Destroy

                else
                    Ecs.Teleport
        in
        ( newState
        , ecs
            |> Ecs.insert .position id position
            |> Ecs.insert .velocity id velocity
            |> Ecs.insert .outOfBoundsResolution id outOfBoundsResolution
            |> Ecs.insert .display id display
        )


getColor : Int -> String
getColor i =
    colors
        |> List.drop (remainderBy (List.length colors) i)
        |> List.head
        |> Maybe.withDefault "#f00"


colors : List String
colors =
    [ "#f00"
    , "#0f0"
    , "#00f"
    , "#ff0"
    , "#f0f"
    , "#0ff"
    , "#fff"
    , "#fa0"
    , "#000"
    ]



-- MOVEMENT SYSTEM --


type alias Move =
    { position : Ecs.Position
    , velocity : Ecs.Velocity
    }


moveSelector : Ecs.Selector Move
moveSelector =
    Ecs.select2 Move
        .position
        .velocity


moveEntities : ( State, Ecs ) -> ( State, Ecs )
moveEntities ( state, ecs ) =
    ( state
    , Ecs.selectList moveSelector ecs
        |> List.foldl (moveEntity state.deltaTime) ecs
    )


moveEntity : Float -> ( Ecs.EntityId, Move ) -> Ecs -> Ecs
moveEntity deltaTime ( id, { position, velocity } ) ecs =
    Ecs.insert .position
        id
        { x = position.x + velocity.x * deltaTime
        , y = position.y + velocity.y * deltaTime
        }
        ecs



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Ecs.Position
    , resolution : Ecs.OutOfBoundsResolution
    }


boundsCheckSelector : Ecs.Selector BoundsCheck
boundsCheckSelector =
    Ecs.select2 BoundsCheck
        .position
        .outOfBoundsResolution


boundsCheckEntities : ( State, Ecs ) -> ( State, Ecs )
boundsCheckEntities ( state, ecs ) =
    Ecs.selectList boundsCheckSelector ecs
        |> List.foldl
            (boundsCheckEntity
                (toFloat state.worldWidth)
                (toFloat state.worldHeight)
            )
            ( state, ecs )


boundsCheckEntity :
    Float
    -> Float
    -> ( Ecs.EntityId, BoundsCheck )
    -> ( State, Ecs )
    -> ( State, Ecs )
boundsCheckEntity worldWidth worldHeight ( id, { position, resolution } ) ( state, ecs ) =
    if
        (position.x < 0 || (position.x > worldWidth))
            || (position.y < 0 || (position.y > worldHeight))
    then
        case resolution of
            Ecs.Teleport ->
                let
                    x =
                        if position.x < 0 then
                            worldWidth

                        else if position.x > worldWidth then
                            0

                        else
                            position.x

                    y =
                        if position.y < 0 then
                            worldHeight

                        else if position.y > worldHeight then
                            0

                        else
                            position.y
                in
                ( state, Ecs.insert .position id { x = x, y = y } ecs )

            Ecs.Destroy ->
                ( removeEntity state, Ecs.clear id ecs )

    else
        ( state, ecs )



-- RENDER SYSTEM --


type alias Render =
    { position : Ecs.Position
    , display : Ecs.Display
    }


renderSelector : Ecs.Selector Render
renderSelector =
    Ecs.select2 Render
        .position
        .display


renderEntities : Ecs -> List (Html.Html msg)
renderEntities ecs =
    Ecs.selectList renderSelector ecs
        |> List.map renderEntity


renderEntity : ( Ecs.EntityId, Render ) -> Html.Html msg
renderEntity ( _, { position, display } ) =
    case display of
        Ecs.Circle { radius, color } ->
            Html.div
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "display" "inline-block"
                , Html.Attributes.style "left" (px (position.x - radius))
                , Html.Attributes.style "top" (px (position.y - radius))
                , Html.Attributes.style "width" (px (2 * radius))
                , Html.Attributes.style "height" (px (2 * radius))
                , Html.Attributes.style "background-color" color
                , Html.Attributes.style "border-radius" "50%"
                ]
                []

        Ecs.Image { src, width, height } ->
            Html.img
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "display" "inline-block"
                , Html.Attributes.style "left"
                    (px (position.x - (toFloat width / 2)))
                , Html.Attributes.style "top"
                    (px (position.y - (toFloat height / 2)))
                , Html.Attributes.src src
                , Html.Attributes.width width
                , Html.Attributes.height height
                ]
                []


px : Float -> String
px value =
    String.fromInt (round value) ++ "px"



-- MODEL --


type alias Model =
    ( State, Ecs )


type alias State =
    { nextId : Ecs.EntityId
    , entityCount : Int
    , worldWidth : Int
    , worldHeight : Int
    , deltaTime : Float
    , frameCount : Int
    , history : Array Float
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( ( { nextId = 0
        , entityCount = 0
        , worldWidth = 600
        , worldHeight = 600
        , deltaTime = 0
        , frameCount = 0
        , history = Array.repeat 30 (1 / 60)
        }
      , Ecs.empty
      )
    , Cmd.none
    )


addEntity : State -> ( Ecs.EntityId, State )
addEntity state =
    ( state.nextId
    , { state
        | nextId = state.nextId + 1
        , entityCount = state.entityCount + 1
      }
    )


removeEntity : State -> State
removeEntity state =
    { state | entityCount = state.entityCount - 1 }



-- UPDATE --


type Msg
    = OnAnimationFrameDelta Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( state, ecs ) =
    case msg of
        OnAnimationFrameDelta deltaTimeMillis ->
            ( ( { state
                    | deltaTime = deltaTimeMillis / 1000
                    , frameCount = state.frameCount + 1
                    , history =
                        Array.set
                            (remainderBy (Array.length state.history) state.frameCount)
                            (deltaTimeMillis / 1000)
                            state.history
                }
              , ecs
              )
                |> spawnEntities
                |> moveEntities
                |> boundsCheckEntities
            , Cmd.none
            )



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions state =
    Browser.Events.onAnimationFrameDelta OnAnimationFrameDelta



-- VIEW --


view : Model -> Browser.Document Msg
view ( state, ecs ) =
    { title = "Ecs Basic Example"
    , body =
        [ Html.div
            [ Html.Attributes.style "position" "relative"
            , Html.Attributes.style "display" "inline-block"
            , Html.Attributes.style "width"
                (String.fromInt state.worldWidth ++ "px")
            , Html.Attributes.style "height"
                (String.fromInt state.worldHeight ++ "px")
            , Html.Attributes.style "background-color" "#aaa"
            ]
            (renderEntities ecs)
        , Html.div []
            [ Html.text ("entities: " ++ (state.entityCount |> String.fromInt))
            , Html.text " - "
            , Html.text ("components: " ++ (Ecs.componentCount ecs |> String.fromInt))
            , Html.text " - "
            , Html.text ("fps: " ++ (getFps state.history |> String.fromInt))
            ]
        ]
    }


getFps : Array Float -> Int
getFps history =
    (toFloat (Array.length history) / Array.foldl (+) 0 history)
        |> round



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
