module Main exposing (main)

import Browser
import Browser.Events
import Ecs exposing (Entity)
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
    Ecs.Ecs Components


type alias EntityType =
    Ecs.EntityType Components


type alias ComponentType a =
    Ecs.ComponentType Components a


type alias NodeType a =
    Ecs.NodeType Components a


type alias System =
    Ecs.System Components State


type alias Components =
    { position : Maybe Position
    , velocity : Maybe Velocity
    , outOfBoundsResolution : Maybe OutOfBoundsResolution
    , color : Maybe Color
    }


type alias ComponentTypes =
    { position : ComponentType Position
    , velocity : ComponentType Velocity
    , outOfBoundsResolution : ComponentType OutOfBoundsResolution
    , color : ComponentType Color
    }


entityType : EntityType
entityType =
    Ecs.entity4 Components


componentTypes : ComponentTypes
componentTypes =
    Ecs.components4
        ComponentTypes
        Components
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
                componentTypes.position
                { x = remainderBy state.worldWidth state.frameCount |> toFloat
                , y = remainderBy state.worldHeight state.frameCount |> toFloat
                }
            |> Ecs.andSet
                componentTypes.velocity
                { x = (remainderBy 5 n - 2) * 75 |> toFloat
                , y = (remainderBy 7 n - 3) * 50 |> toFloat
                }
            |> Ecs.andSet
                componentTypes.outOfBoundsResolution
                (if remainderBy 2 n == 0 then
                    Teleport

                 else
                    Destroy
                )
            |> Ecs.andSet
                componentTypes.color
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


moveNode : NodeType Move
moveNode =
    Ecs.node2 Move
        componentTypes.position
        componentTypes.velocity


moveSystem : System
moveSystem =
    Ecs.system
        { preProcess = Nothing
        , process = Just ( moveNode, moveEntity )
        , postProcess = Nothing
        }


moveEntity : Move -> Entity -> Ecs -> State -> ( Ecs, State )
moveEntity { position, velocity } entity ecs state =
    ( Ecs.set
        componentTypes.position
        { x = position.x + velocity.x * state.deltaTime
        , y = position.y + velocity.y * state.deltaTime
        }
        entity
        ecs
    , state
    )



-- BOUNDS CHECK SYSTEM --


type alias BoundsCheck =
    { position : Position
    , resolution : OutOfBoundsResolution
    }


boundsCheckNode : NodeType BoundsCheck
boundsCheckNode =
    Ecs.node2 BoundsCheck
        componentTypes.position
        componentTypes.outOfBoundsResolution


boundsCheckSystem : System
boundsCheckSystem =
    Ecs.system
        { preProcess = Nothing
        , process = Just ( boundsCheckNode, boundsCheckEntity )
        , postProcess = Nothing
        }


boundsCheckEntity : BoundsCheck -> Entity -> Ecs -> State -> ( Ecs, State )
boundsCheckEntity { position, resolution } entity ecs state =
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
                    componentTypes.position
                    { x = newX, y = newY }
                    entity
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
                ( Ecs.destroy entity ecs, state )

            else
                ( ecs, state )



-- RENDER SYSTEM --


type alias Render =
    { position : Position
    , color : Color
    }


renderNode : NodeType Render
renderNode =
    Ecs.node2 Render
        componentTypes.position
        componentTypes.color


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


renderEntity : Render -> Entity -> Ecs -> State -> ( Ecs, State )
renderEntity data entity ecs state =
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
    ( ( Ecs.empty entityType
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
