module Main exposing (main)

import Assets exposing (Assets)
import Browser exposing (Document)
import Browser.Dom exposing (Viewport, getViewport)
import Ecs exposing (Ecs)
import Ecs.Context as Context exposing (Context)
import Ecs.Entities as Entities
import Ecs.Systems as Systems
import Html exposing (Html, text)
import Random
import Task
import Time exposing (Posix, posixToMillis)
import WebGL.Texture as Texture exposing (Error)



-- MODEL --


type InitState
    = InitPending
    | InitError Error
    | InitOk Model


type alias Model =
    { assets : Assets
    , context : Context
    , ecs : Ecs
    }


type alias Screen =
    { width : Int
    , height : Int
    }


type alias InitData =
    { assets : Assets
    , posix : Posix
    , viewport : Viewport
    }


init : () -> ( InitState, Cmd Msg )
init _ =
    ( InitPending
    , Task.map3 InitData
        Assets.load
        Time.now
        getViewport
        |> Task.attempt InitReceived
    )


initModel : InitData -> Model
initModel { assets, posix, viewport } =
    let
        screen =
            { width = round viewport.viewport.width
            , height = round viewport.viewport.height
            }

        seed =
            Random.initialSeed (posixToMillis posix)

        ( ecs, context ) =
            Entities.init (Context.init assets seed screen)
    in
    { assets = assets
    , context = context
    , ecs = ecs
    }



-- UPDATE --


type Msg
    = InitReceived (Result Error InitData)
    | ContextMsg Context.Msg


update : Msg -> InitState -> ( InitState, Cmd Msg )
update msg state =
    case ( state, msg ) of
        ( InitPending, InitReceived (Err error) ) ->
            ( InitError error, Cmd.none )

        ( InitPending, InitReceived (Ok data) ) ->
            ( InitOk (initModel data), Cmd.none )

        ( InitError error, _ ) ->
            ( state, Cmd.none )

        ( InitOk model, ContextMsg contextMsg ) ->
            let
                ( context, outMsg ) =
                    Context.update contextMsg model.context
            in
            case outMsg of
                Context.None ->
                    ( InitOk { model | context = context }, Cmd.none )

                Context.DeltaTimeUpdated ->
                    let
                        ( ecs, updatedContext ) =
                            Systems.update context model.ecs
                    in
                    ( InitOk
                        { model
                            | context = updatedContext
                            , ecs = ecs
                        }
                    , Cmd.none
                    )

        _ ->
            ( state, Cmd.none )



-- SUBSCRIPTIONS --


subscriptions : InitState -> Sub Msg
subscriptions state =
    case state of
        InitOk model ->
            Sub.map ContextMsg (Context.subscriptions model.context)

        _ ->
            Sub.none



-- VIEW --


view : InitState -> Document Msg
view state =
    { title = "Ecs Example"
    , body =
        case state of
            InitPending ->
                [ text "loading..." ]

            InitError error ->
                viewError error

            InitOk internalModel ->
                viewOk internalModel
    }


viewError : Error -> List (Html Msg)
viewError error =
    case error of
        Texture.LoadError ->
            [ text "could not load texture" ]

        Texture.SizeError width height ->
            [ text <|
                "could not load texture with size "
                    ++ String.fromInt width
                    ++ "x"
                    ++ String.fromInt height
            ]


viewOk : Model -> List (Html Msg)
viewOk model =
    [ Systems.view model.context model.ecs ]



-- MAIN --


main : Program () InitState Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
