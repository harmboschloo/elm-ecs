module Main exposing (main)

import Browser
import Browser.Events
import Ecs
import Ecs.Empty
import Ecs.Process
import Ecs.Select
import Ecs.System
import Ecs.Update
import Html
import Html.Attributes



--  COMPONENTS --


type alias Position =
    { x : Float, y : Float }


type alias Velocity =
    { x : Float, y : Float }


type OutOfBoundsResolution
    = Teleport
    | Destroy


type alias Color =
    String



-- ECS SETUP --


type alias Entity =
    { position : Maybe Position
    , velocity : Maybe Velocity
    , outOfBoundsResolution : Maybe OutOfBoundsResolution
    , color : Maybe Color
    }


type alias ComponentUpdates =
    { position : Ecs.Update.Update Entity Position
    , velocity : Ecs.Update.Update Entity Velocity
    , outOfBoundsResolution : Ecs.Update.Update Entity OutOfBoundsResolution
    , color : Ecs.Update.Update Entity Color
    }


empty : Entity
empty =
    Ecs.Empty.empty4 Entity


componentUpdates : ComponentUpdates
componentUpdates =
    Ecs.Update.updates4
        ComponentUpdates
        Entity
        .position
        .velocity
        .outOfBoundsResolution
        .color



--  SPAWN SYSTEM --


spawnSystem : Ecs.System.System Entity State
spawnSystem =
    Ecs.System.system
        { preProcess = Just spawnEntity
        , process = Nothing
        , postProcess = Nothing
        }


spawnEntity : Ecs.Ecs Entity -> State -> ( Ecs.Ecs Entity, State )
spawnEntity ecs state =
    if remainderBy 10 state.frameCount == 0 then
        let
            n =
                state.frameCount // 10
        in
        ( Ecs.create ecs
            |> Ecs.andSet
                components.position
                { x = remainderBy state.worldWidth state.frameCount |> toFloat
                , y = remainderBy state.worldHeight state.frameCount |> toFloat
                }
            |> Ecs.andSet
                components.velocity
                { x = (remainderBy 5 n - 2) * 75 |> toFloat
                , y = (remainderBy 7 n - 3) * 50 |> toFloat
                }
            |> Ecs.andSet
                components.outOfBoundsResolution
                (if remainderBy 2 n == 0 then
                    Teleport

                 else
                    Destroy
                )
            |> Ecs.andSet
                components.color
                (colors
                    |> List.drop (remainderBy (List.length colors) n)
                    |> List.head
                    |> Maybe.withDefault "#f00"
                )
            |> Tuple.second
        , state
        )

    else
        ( ecs, state )


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
    { position : Position
    , velocity : Velocity
    }


selectMove : Ecs.Select.Select Entity Move
selectMove =
    Ecs.Select.map2 Move
        .position
        .velocity


moveSystem : Ecs.System.System Entity State
moveSystem =
    Ecs.System.system
        { preProcess = Nothing
        , process = Just ( selectMove, moveEntity )
        , postProcess = Nothing
        }


moveEntity :
    Move
    -> Ecs.Process.Process Entity
    -> State
    -> ( Ecs.Process.Process Entity, State )
moveEntity { position, velocity } process state =
    ( Ecs.Process.set componentUpdates.position
        { x = position.x + velocity.x * state.deltaTime
        , y = position.y + velocity.y * state.deltaTime
        }
        process
    , state
    )



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Position
    , resolution : OutOfBoundsResolution
    }


selectBoundsCheck : Ecs.Select.Select Entity BoundsCheck
selectBoundsCheck =
    Ecs.Select.map2 BoundsCheck
        .position
        .outOfBoundsResolution


boundsCheckSystem : Ecs.System.System Entity State
boundsCheckSystem =
    Ecs.system
        { preProcess = Nothing
        , process = Just ( selectBoundsCheck, boundsCheckEntity )
        , postProcess = Nothing
        }


boundsCheckEntity :
    BoundsCheck
    -> Ecs.Process.Process Entity
    -> State
    -> ( Ecs.Process.Process Entity, State )
boundsCheckEntity { position, resolution } process state =
    case resolution of
        Teleport ->
            let
                newX =
                    if position.x < 0 then
                        toFloat state.worldWidth

                    else if position.x > toFloat state.worldWidth then
                        0

                    else
                        position.x

                newY =
                    if position.y < 0 then
                        toFloat state.worldHeight

                    else if position.y > toFloat state.worldHeight then
                        0

                    else
                        position.y
            in
            if position.x /= newX || position.y /= newY then
                ( Ecs.Process.set componentUpdates.position
                    { x = newX, y = newY }
                    process
                , state
                )

            else
                ( process, state )

        Destroy ->
            if
                (position.x < 0)
                    || (position.x > toFloat state.worldWidth)
                    || (position.y < 0)
                    || (position.y > toFloat state.worldHeight)
            then
                ( Ecs.Process.destroy process, state )

            else
                ( process, state )



-- RENDER SYSTEM --


type alias Render =
    { position : Position
    , color : Color
    }


selectRender : Ecs.Select.Select Entity Render
selectRender =
    Ecs.node2 Render
        components.position
        components.color


renderSystem : Ecs.System.System Entity State
renderSystem =
    Ecs.system
        { preProcess = Just clearViewElements
        , process = Just ( selectRender, renderEntity )
        , postProcess = Nothing
        }


clearViewElements : Ecs -> State -> ( Ecs, State )
clearViewElements ecs state =
    ( ecs, { state | viewElements = [] } )


renderEntity :
    Render
    -> Ecs.Process.Process
    -> State
    -> ( Ecs.Process.Process, State )
renderEntity data _ ecs state =
    ( ecs, { state | viewElements = data :: state.viewElements } )



-- MODEL --


type alias Model =
    ( Ecs.Ecs Entity, State )


type alias State =
    { worldWidth : Int
    , worldHeight : Int
    , deltaTime : Float
    , frameCount : Int
    , viewElements : List ViewElement
    }


type alias ViewElement =
    { position : Position
    , color : Color
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( ( Ecs.empty empty
      , { worldWidth = 300
        , worldHeight = 300
        , deltaTime = 0
        , frameCount = 0
        , viewElements = []
        }
      )
    , Cmd.none
    )



-- UPDATE --


type Msg
    = OnAnimationFrameDelta Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg ( ecs, state ) =
    case msg of
        OnAnimationFrameDelta deltaTimeMillis ->
            ( Ecs.process
                [ spawnSystem
                , moveSystem
                , boundsCheckSystem
                , renderSystem
                ]
                ecs
                { state
                    | deltaTime = deltaTimeMillis / 1000
                    , frameCount = state.frameCount + 1
                }
            , Cmd.none
            )



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions state =
    Browser.Events.onAnimationFrameDelta OnAnimationFrameDelta



-- VIEW --


view : Model -> Browser.Document Msg
view ( ecs, state ) =
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
            (List.map viewElement state.viewElements)
        , Html.div []
            [ Html.text ("entities: " ++ (Ecs.size ecs |> String.fromInt))
            , Html.text " - "
            , Html.text
                ("fps: " ++ (1 / state.deltaTime |> round |> String.fromInt))
            ]
        ]
    }


viewElement : ViewElement -> Html msg
viewElement { position, color } =
    Html.div
        [ Html.Attributes.style "position" "absolute"
        , Html.Attributes.style "display" "inline-block"
        , Html.Attributes.style "left"
            (String.fromInt (round position.x - 2) ++ "px")
        , Html.Attributes.style "top"
            (String.fromInt (round position.y - 2) ++ "px")
        , Html.Attributes.style "width" "4px"
        , Html.Attributes.style "height" "4px"
        , Html.Attributes.style "background-color" color
        ]
        []



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
