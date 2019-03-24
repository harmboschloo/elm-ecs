module Main exposing (main)

import Browser
import Browser.Dom
import Browser.Events
import Color
import Ecs
import Ecs.Components7
import Ecs.EntityComponents
import Ecs.Singletons5
import Html
import Html.Attributes
import Html.Events.Extra.Mouse as Mouse
import Html.Events.Extra.Touch as Touch
import Random
import Task
import Time



-- COMPONENTS --


type alias Components =
    Ecs.Components7.Components7 EntityId Position Velocity GravityWell GravityTagA GravityTagB EndOfLife Display


type alias EntityId =
    Int


type alias Position =
    { x : Float
    , y : Float
    }


type alias Velocity =
    { velocityX : Float
    , velocityY : Float
    }


type alias GravityWell =
    { mass : Float }


type GravityTagA
    = GravityTagA


type GravityTagB
    = GravityTagB


type EndOfLife
    = EndOfLife Float


type Display
    = Circle
        { color : Color.Color
        , radius : Float
        }



-- SINGLETONS --


type alias Singletons =
    Ecs.Singletons5.Singletons5 EntityId Screen Pointer Frame Random.Seed


type alias Screen =
    { width : Float
    , height : Float
    }


type Pointer
    = NoPointer
    | MousePointer
    | TouchPointer


type alias Frame =
    { deltaTime : Float
    , totalTime : Float
    }



-- SPECS --


type alias Specs =
    { components : AllComponentsSpec
    , position : ComponentSpec Position
    , velocity : ComponentSpec Velocity
    , gravityWell : ComponentSpec GravityWell
    , gravityTagA : ComponentSpec GravityTagA
    , gravityTagB : ComponentSpec GravityTagB
    , endOfLife : ComponentSpec EndOfLife
    , display : ComponentSpec Display
    , nextEntityId : SingletonSpec EntityId
    , screen : SingletonSpec Screen
    , pointer : SingletonSpec Pointer
    , frame : SingletonSpec Frame
    , randomSeed : SingletonSpec Random.Seed
    }


type alias AllComponentsSpec =
    Ecs.AllComponentsSpec EntityId Components


type alias ComponentSpec a =
    Ecs.ComponentSpec EntityId a Components


type alias SingletonSpec a =
    Ecs.SingletonSpec a Singletons


specs : Specs
specs =
    Specs |> Ecs.Components7.specs |> Ecs.Singletons5.specs



-- INIT --


type alias Model =
    Maybe World


type alias World =
    Ecs.World EntityId Components Singletons


type alias InitData =
    { time : Time.Posix
    , viewport : Browser.Dom.Viewport
    }


type alias GravityWellInit =
    { position : Position
    , radius : Float
    , tag : GravityTagInit
    }


type alias SatelliteInit =
    { velocity : Velocity
    , radius : Float
    , tag : GravityTagInit
    , lifeTime : Float
    }


type alias GravityTagInit =
    { insertComponents : World -> World
    , color : Color.Color
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Nothing
    , Task.perform GotInitData
        (Task.map2 InitData
            Time.now
            Browser.Dom.getViewport
        )
    )


initWorld : InitData -> World
initWorld initData =
    Ecs.emptyWorld specs.components (initSingletons initData)
        |> initGravityWell
        |> initGravityWell
        |> initGravityWell
        |> initSatellite (Position 0 0)
        |> initSatellite (Position 0 0)
        |> initSatellite (Position 0 0)
        |> initSatellite (Position 0 0)
        |> initSatellite (Position 0 0)


initSingletons : InitData -> Singletons
initSingletons { time, viewport } =
    Ecs.Singletons5.init
        0
        { width = viewport.viewport.width
        , height = viewport.viewport.height
        }
        NoPointer
        { deltaTime = 0
        , totalTime = 0
        }
        (Random.initialSeed (Time.posixToMillis time))


initGravityWell : World -> World
initGravityWell world1 =
    let
        ( world2, generated ) =
            randomStep
                (Random.map3 GravityWellInit
                    gravityWellPositionGenerator
                    gravityWellRadiusGenerator
                    gravityWellTagGenerator
                )
                world1
    in
    world2
        |> newEntity
        |> Ecs.insertComponent specs.gravityWell { mass = generated.radius ^ 1.4 }
        |> generated.tag.insertComponents
        |> Ecs.insertComponent specs.position generated.position
        |> Ecs.insertComponent specs.display
            (Circle
                { radius = generated.radius
                , color = generated.tag.color
                }
            )


initSatellites : List Position -> World -> World
initSatellites screenPositions world =
    let
        worldToScreen =
            getWorldToScreen world

        worldPositions =
            List.map (screenToWorldPosition worldToScreen) screenPositions
    in
    List.foldl initSatellite world worldPositions


initSatellite : Position -> World -> World
initSatellite position world1 =
    let
        frame =
            Ecs.getSingleton specs.frame world1

        ( world2, generated ) =
            randomStep
                (Random.map4 SatelliteInit
                    satelliteVelocityGenerator
                    satelliteRadiusGenerator
                    satelliteTagGenerator
                    satelliteLifeTimeGenerator
                )
                world1
    in
    world2
        |> newEntity
        |> generated.tag.insertComponents
        |> Ecs.insertComponent specs.position position
        |> Ecs.insertComponent specs.velocity generated.velocity
        |> Ecs.insertComponent specs.display
            (Circle
                { radius = generated.radius
                , color = generated.tag.color
                }
            )
        |> Ecs.insertComponent specs.endOfLife (EndOfLife (frame.totalTime + generated.lifeTime))


gravityWellPositionGenerator : Random.Generator Position
gravityWellPositionGenerator =
    Random.map2 Position
        (Random.float -0.5 0.5)
        (Random.float -0.5 0.5)


gravityWellRadiusGenerator : Random.Generator Float
gravityWellRadiusGenerator =
    Random.float 0.05 0.1


gravityWellTagGenerator : Random.Generator GravityTagInit
gravityWellTagGenerator =
    Random.uniform
        (GravityTagInit insertGravityTagA Color.lightRed)
        [ GravityTagInit insertGravityTagB Color.lightGreen
        ]


satelliteVelocityGenerator : Random.Generator Velocity
satelliteVelocityGenerator =
    Random.map2 Velocity
        (Random.float -1 1)
        (Random.float -1 1)


satelliteRadiusGenerator : Random.Generator Float
satelliteRadiusGenerator =
    Random.float 0.01 0.005


satelliteTagGenerator : Random.Generator GravityTagInit
satelliteTagGenerator =
    Random.uniform
        (GravityTagInit insertGravityTagA Color.red)
        [ GravityTagInit insertGravityTagB Color.green
        , GravityTagInit (insertGravityTagA >> insertGravityTagB) Color.yellow
        ]


insertGravityTagA : World -> World
insertGravityTagA =
    Ecs.insertComponent specs.gravityTagA GravityTagA


insertGravityTagB : World -> World
insertGravityTagB =
    Ecs.insertComponent specs.gravityTagB GravityTagB


satelliteLifeTimeGenerator : Random.Generator Float
satelliteLifeTimeGenerator =
    Random.float 5 20


randomStep : Random.Generator a -> World -> ( World, a )
randomStep generator world =
    let
        seed1 =
            Ecs.getSingleton specs.randomSeed world

        ( a, seed2 ) =
            Random.step generator seed1
    in
    ( Ecs.setSingleton specs.randomSeed seed2 world, a )



-- UPDATE --


type Msg
    = GotInitData InitData
    | GotScreenResize Int Int
    | GotPointerPosition Pointer (List Position)
    | GotPointerEnd Pointer
    | GotAnimationFrameDelta Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( GotInitData initData, Nothing ) ->
            ( Just (initWorld initData), Cmd.none )

        ( GotScreenResize width height, Just world ) ->
            ( world
                |> Ecs.setSingleton specs.screen
                    { width = toFloat width
                    , height = toFloat height
                    }
                |> Just
            , Cmd.none
            )

        ( GotPointerPosition type_ positions, Just world ) ->
            ( Just
                (case ( Ecs.getSingleton specs.pointer world, type_ ) of
                    ( NoPointer, _ ) ->
                        world
                            |> Ecs.setSingleton specs.pointer type_
                            |> initSatellites positions

                    ( MousePointer, MousePointer ) ->
                        world
                            |> initSatellites positions

                    ( TouchPointer, TouchPointer ) ->
                        world
                            |> Ecs.setSingleton specs.pointer type_
                            |> initSatellites positions

                    _ ->
                        world
                )
            , Cmd.none
            )

        ( GotPointerEnd type_, Just world ) ->
            ( Just
                (case ( Ecs.getSingleton specs.pointer world, type_ ) of
                    ( MousePointer, MousePointer ) ->
                        Ecs.setSingleton specs.pointer NoPointer world

                    ( TouchPointer, TouchPointer ) ->
                        Ecs.setSingleton specs.pointer NoPointer world

                    _ ->
                        world
                )
            , Cmd.none
            )

        ( GotAnimationFrameDelta deltaTimeMillis, Just world ) ->
            ( world
                |> updateFrame (deltaTimeMillis / 1000)
                |> applyGravity specs.gravityTagA
                |> applyGravity specs.gravityTagB
                |> updatePositions
                |> checkEndOfLife
                |> Just
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


updateFrame : Float -> World -> World
updateFrame deltaTime world =
    Ecs.updateSingleton specs.frame
        (\frame ->
            { totalTime = frame.totalTime + deltaTime
            , deltaTime = deltaTime
            }
        )
        world


applyGravity : ComponentSpec a -> World -> World
applyGravity tagSpec world =
    Ecs.EntityComponents.processFromLeft3
        specs.gravityWell
        tagSpec
        specs.position
        (processGravityWell tagSpec)
        world


processGravityWell : ComponentSpec a -> EntityId -> GravityWell -> a -> Position -> World -> World
processGravityWell tagSpec _ gravityWell _ position world =
    Ecs.EntityComponents.processFromLeft3
        tagSpec
        specs.velocity
        specs.position
        (applyGravityToEntity gravityWell position)
        world


applyGravityToEntity : GravityWell -> Position -> EntityId -> a -> Velocity -> Position -> World -> World
applyGravityToEntity well wellPosition _ _ velocity position world =
    let
        positionDiffX =
            wellPosition.x - position.x

        positionDiffY =
            wellPosition.y - position.y

        distanceSquared =
            positionDiffX * positionDiffX + positionDiffY * positionDiffY

        distance =
            sqrt distanceSquared
    in
    if distance > 0.05 then
        let
            frame =
                Ecs.getSingleton specs.frame world

            acceleration =
                5 * well.mass / distanceSquared

            accelerationX =
                acceleration * positionDiffX / distance

            accelerationY =
                acceleration * positionDiffY / distance

            newVelocity =
                { velocityX = velocity.velocityX + accelerationX * frame.deltaTime
                , velocityY = velocity.velocityY + accelerationY * frame.deltaTime
                }
        in
        Ecs.insertComponent specs.velocity newVelocity world

    else
        world


updatePositions : World -> World
updatePositions world =
    Ecs.EntityComponents.processFromLeft2 specs.velocity specs.position updatePosition world


updatePosition : EntityId -> Velocity -> Position -> World -> World
updatePosition _ velocity position world =
    let
        frame =
            Ecs.getSingleton specs.frame world
    in
    Ecs.insertComponent specs.position
        { x = position.x + velocity.velocityX * frame.deltaTime
        , y = position.y + velocity.velocityY * frame.deltaTime
        }
        world


checkEndOfLife : World -> World
checkEndOfLife world =
    Ecs.EntityComponents.processFromLeft specs.endOfLife checkEntityEndOfLife world


checkEntityEndOfLife : EntityId -> EndOfLife -> World -> World
checkEntityEndOfLife _ (EndOfLife endOfLifeTime) world =
    let
        frame =
            Ecs.getSingleton specs.frame world
    in
    if frame.totalTime >= endOfLifeTime then
        Ecs.removeEntity specs.components world

    else
        world


newEntity : World -> World
newEntity world =
    world
        |> Ecs.insertEntity (Ecs.getSingleton specs.nextEntityId world)
        |> Ecs.updateSingleton specs.nextEntityId (\id -> id + 1)



-- SUBSCRIPTIONS --


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Just _ ->
            Sub.batch
                [ Browser.Events.onAnimationFrameDelta GotAnimationFrameDelta
                , Browser.Events.onResize GotScreenResize
                ]

        Nothing ->
            Sub.none



-- VIEW --


view : Model -> Browser.Document Msg
view model =
    { title = "bounce - elm-ecs"
    , body =
        case model of
            Just world ->
                render world

            Nothing ->
                []
    }


render : World -> List (Html.Html Msg)
render world =
    let
        worldToScreen =
            getWorldToScreen world

        frame =
            Ecs.getSingleton specs.frame world
    in
    [ Html.div
        ([ Html.Attributes.style "position" "fixed"
         , Html.Attributes.style "left" "0"
         , Html.Attributes.style "right" "0"
         , Html.Attributes.style "top" "0"
         , Html.Attributes.style "bottom" "0"
         , Html.Attributes.style "background-color" "#000"
         , Html.Attributes.style "overflow" "hidden"
         ]
            |> withPointerEvents world
        )
        (Ecs.EntityComponents.foldFromRight2
            specs.display
            specs.position
            (\entityId display position list ->
                renderEntity
                    (worldToScreenPosition worldToScreen position)
                    (worldToScreenDisplay worldToScreen display)
                    (world |> Ecs.onEntity entityId |> Ecs.getComponent specs.endOfLife |> endOfLifeOpacity frame)
                    :: list
            )
            []
            world
        )
    , Html.div
        [ Html.Attributes.style "color" "#fff"
        , Html.Attributes.style "position" "fixed"
        , Html.Attributes.style "font-family" "monospace"
        ]
        [ Html.text "mouse/touch to spawn entities"
        , Html.text " - "
        , Html.text ("entities: " ++ (Ecs.worldEntityCount world |> String.fromInt))
        , Html.text " - "
        , Html.text ("components: " ++ (Ecs.worldComponentCount specs.components world |> String.fromInt))
        ]
    ]


withPointerEvents : World -> List (Html.Attribute Msg) -> List (Html.Attribute Msg)
withPointerEvents world attributes =
    case Ecs.getSingleton specs.pointer world of
        NoPointer ->
            Touch.onStart handleTouchPosition
                :: Mouse.onDown handleMousePosition
                :: attributes

        MousePointer ->
            Mouse.onMove handleMousePosition
                :: Mouse.onUp handleMouseEnd
                :: attributes

        TouchPointer ->
            Touch.onMove handleTouchPosition
                :: Touch.onCancel handleTouchEnd
                :: Touch.onEnd handleTouchEnd
                :: attributes


endOfLifeOpacity : Frame -> Maybe EndOfLife -> Float
endOfLifeOpacity frame maybeEndOfLife =
    case maybeEndOfLife of
        Just (EndOfLife endOfLifeTime) ->
            min 1 ((endOfLifeTime - frame.totalTime) / 5)

        Nothing ->
            1


renderEntity : Position -> Display -> Float -> Html.Html msg
renderEntity position display opacity =
    case display of
        Circle { radius, color } ->
            Html.div
                [ Html.Attributes.style "position" "absolute"
                , Html.Attributes.style "display" "inline-block"
                , Html.Attributes.style "left" (px (position.x - radius))
                , Html.Attributes.style "top" (px (position.y - radius))
                , Html.Attributes.style "width" (px (2 * radius))
                , Html.Attributes.style "height" (px (2 * radius))
                , Html.Attributes.style "background-color" (Color.toCssString color)
                , Html.Attributes.style "border-radius" "50%"
                , Html.Attributes.style "opacity" (String.fromFloat opacity)
                ]
                []


handleMousePosition : Mouse.Event -> Msg
handleMousePosition event =
    let
        ( x, y ) =
            event.pagePos
    in
    GotPointerPosition MousePointer [ Position x y ]


handleMouseEnd : Mouse.Event -> Msg
handleMouseEnd _ =
    GotPointerEnd MousePointer


handleTouchPosition : Touch.Event -> Msg
handleTouchPosition event =
    event.changedTouches
        |> List.map (.pagePos >> (\( x, y ) -> Position x y))
        |> GotPointerPosition TouchPointer


handleTouchEnd : Touch.Event -> Msg
handleTouchEnd event =
    case event.touches of
        [] ->
            GotPointerEnd TouchPointer

        _ ->
            GotPointerPosition TouchPointer []


px : Float -> String
px value =
    String.fromFloat value ++ "px"



-- HELPERS --


type alias WorldToScreen =
    { offsetX : Float
    , offsetY : Float
    , scale : Float
    }


getWorldToScreen : World -> WorldToScreen
getWorldToScreen world =
    let
        screen =
            Ecs.getSingleton specs.screen world
    in
    if screen.width > screen.height then
        { offsetX = screen.width / screen.height
        , offsetY = 1
        , scale = screen.height / 2
        }

    else
        { offsetX = 1
        , offsetY = screen.height / screen.width
        , scale = screen.width / 2
        }


worldToScreenPosition : WorldToScreen -> Position -> Position
worldToScreenPosition { offsetX, offsetY, scale } { x, y } =
    { x = scale * (offsetX + x)
    , y = scale * (offsetY + y)
    }


screenToWorldPosition : WorldToScreen -> Position -> Position
screenToWorldPosition { offsetX, offsetY, scale } { x, y } =
    { x = (x / scale) - offsetX
    , y = y / scale - offsetY
    }


worldToScreenDisplay : WorldToScreen -> Display -> Display
worldToScreenDisplay { scale } display =
    case display of
        Circle { radius, color } ->
            Circle
                { radius = scale * radius
                , color = color
                }



-- MAIN --


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
