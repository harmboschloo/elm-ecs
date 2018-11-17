module Main exposing (main)

import Browser
import Browser.Events
import Ecs exposing (EntityId)
import Html exposing (Html)
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


type alias Ecs =
    Ecs.Ecs Entity


type alias Empty =
    Ecs.Empty Entity


type alias Component a =
    Ecs.Component Entity a


type alias Node a =
    Ecs.Node Entity a


type alias System =
    Ecs.System Entity State


type alias Entity =
    { position : Maybe Position
    , velocity : Maybe Velocity
    , outOfBoundsResolution : Maybe OutOfBoundsResolution
    , color : Maybe Color
    }


type alias Components =
    { position : Component Position
    , velocity : Component Velocity
    , outOfBoundsResolution : Component OutOfBoundsResolution
    , color : Component Color
    }


empty : Empty
empty =
    Ecs.empty4 Entity


components : Components
components =
    Ecs.components4
        Components
        Entity
        .position
        .velocity
        .outOfBoundsResolution
        .color



--  SPAWN SYSTEM --


spawnSystem : System
spawnSystem =
    Ecs.system
        { preProcess = Just spawnEntity
        , process = Nothing
        , postProcess = Nothing
        }


spawnEntity : Ecs -> State -> ( Ecs, State )
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


moveNode : Node Move
moveNode =
    Ecs.node2 Move
        components.position
        components.velocity


moveSystem : System
moveSystem =
    Ecs.system
        { preProcess = Nothing
        , process = Just ( moveNode, moveEntity )
        , postProcess = Nothing
        }


moveEntity : Move -> EntityId -> Ecs -> State -> ( Ecs, State )
moveEntity { position, velocity } entityId ecs state =
    ( Ecs.set
        components.position
        { x = position.x + velocity.x * state.deltaTime
        , y = position.y + velocity.y * state.deltaTime
        }
        entityId
        ecs
    , state
    )



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Position
    , resolution : OutOfBoundsResolution
    }


boundsCheckNode : Node BoundsCheck
boundsCheckNode =
    Ecs.node2 BoundsCheck
        components.position
        components.outOfBoundsResolution


boundsCheckSystem : System
boundsCheckSystem =
    Ecs.system
        { preProcess = Nothing
        , process = Just ( boundsCheckNode, boundsCheckEntity )
        , postProcess = Nothing
        }


boundsCheckEntity : BoundsCheck -> EntityId -> Ecs -> State -> ( Ecs, State )
boundsCheckEntity { position, resolution } entityId ecs state =
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
                ( Ecs.set
                    components.position
                    { x = newX, y = newY }
                    entityId
                    ecs
                , state
                )

            else
                ( ecs, state )

        Destroy ->
            if
                (position.x < 0)
                    || (position.x > toFloat state.worldWidth)
                    || (position.y < 0)
                    || (position.y > toFloat state.worldHeight)
            then
                ( Ecs.destroy entityId ecs, state )

            else
                ( ecs, state )



-- RENDER SYSTEM --


type alias Render =
    { position : Position
    , color : Color
    }


renderNode : Node Render
renderNode =
    Ecs.node2 Render
        components.position
        components.color


renderSystem : System
renderSystem =
    Ecs.system
        { preProcess = Just clearViewElement
        , process = Just ( renderNode, renderEntity )
        , postProcess = Nothing
        }


clearViewElement : Ecs -> State -> ( Ecs, State )
clearViewElement ecs state =
    ( ecs, { state | viewElements = [] } )


renderEntity : Render -> EntityId -> Ecs -> State -> ( Ecs, State )
renderEntity data _ ecs state =
    ( ecs, { state | viewElements = data :: state.viewElements } )



-- MODEL --


type alias Model =
    ( Ecs, State )


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
