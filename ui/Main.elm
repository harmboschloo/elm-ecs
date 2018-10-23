module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import Css
import Css.Global
import Dict exposing (Dict)
import EcsGenerator
import EcsGenerator.Error as Error exposing (Error)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Html.Styled.Keyed as HtmlKeyed
import Json.Decode as Decode
import Set exposing (Set)
import Task
import Url exposing (Url)



-- MODEL


type alias Model =
    { navigationKey : Navigation.Key
    , encodedConfig : String
    , decodeError : Maybe String
    , ecs : ( String, String )
    , components : Dict Int ( String, String )
    , lastComponentKey : Int
    }


init : () -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    case decodeFragment url of
        Err decodeError ->
            ( initEmpty navigationKey decodeError
            , Cmd.none
            )

        Ok config ->
            ( initFromConfig navigationKey config
            , Cmd.none
            )


initEmpty : Navigation.Key -> Maybe String -> Model
initEmpty navigationKey decodeError =
    { navigationKey = navigationKey
    , encodedConfig = ""
    , decodeError = decodeError
    , ecs = ( "Ecs", "Ecs" )
    , components = Dict.empty
    , lastComponentKey = 0
    }


initFromConfig : Navigation.Key -> EcsGenerator.Config -> Model
initFromConfig navigationKey config =
    let
        ecs =
            ( EcsGenerator.ecsModuleName config.ecs
            , EcsGenerator.ecsTypeName config.ecs
            )

        components =
            config.components
                |> List.map fromComponent
                |> List.indexedMap (\i v -> ( i, v ))
                |> Dict.fromList
    in
    { navigationKey = navigationKey
    , encodedConfig = ""
    , ecs = ecs
    , decodeError = Nothing
    , components = components
    , lastComponentKey = Dict.size components
    }


fromComponent : EcsGenerator.Component -> ( String, String )
fromComponent component =
    ( EcsGenerator.componentModuleName component
    , EcsGenerator.componentTypeName component
    )


findComponentKey : Dict Int ( String, String ) -> ( String, String ) -> Maybe Int
findComponentKey components component =
    Dict.foldl
        (\key value found ->
            if value == component then
                Just key

            else
                found
        )
        Nothing
        components


toConfig : Model -> EcsGenerator.Config
toConfig model =
    { ecs = tupleMap2 EcsGenerator.ecs model.ecs
    , components =
        Dict.values model.components
            |> List.sortBy Tuple.second
            |> List.map (tupleMap2 EcsGenerator.component)
    }


tupleMap2 : (a -> b -> c) -> ( a, b ) -> c
tupleMap2 mapper ( a, b ) =
    mapper a b


findComponent : Dict Int ( String, String ) -> Int -> Maybe ( String, String )
findComponent components key =
    Dict.get key components



-- UPDATE


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | EcsModuleNameChanged String
    | EcsTypeNameChanged String
    | ComponentModuleNameChanged Int String
    | ComponentTypeNameChanged Int String
    | ComponentRemoved Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    if
                        String.endsWith "examples/demo/build/" url.path
                            || String.endsWith "examples/basic/" url.path
                    then
                        ( model
                        , Navigation.load (Url.toString url)
                        )

                    else
                        ( model
                        , Navigation.pushUrl model.navigationKey (Url.toString url)
                        )

                Browser.External url ->
                    ( model
                    , Navigation.load url
                    )

        UrlChanged url ->
            if url.fragment == Just model.encodedConfig then
                ( model, Cmd.none )

            else
                case decodeFragment url of
                    Err decodeError ->
                        ( initEmpty model.navigationKey decodeError
                        , Cmd.none
                        )

                    Ok config ->
                        ( initFromConfig model.navigationKey config
                        , Cmd.none
                        )

        EcsModuleNameChanged name ->
            { model | ecs = ( name, Tuple.second model.ecs ) }
                |> pushUrl

        EcsTypeNameChanged name ->
            { model | ecs = ( Tuple.first model.ecs, name ) }
                |> pushUrl

        ComponentModuleNameChanged key moduleName ->
            model
                |> ensureComponent key
                |> (\( ( _, typeName ), m ) ->
                        { m
                            | components =
                                Dict.insert
                                    key
                                    ( moduleName, typeName )
                                    model.components
                        }
                   )
                |> pushUrl

        ComponentTypeNameChanged key typeName ->
            model
                |> ensureComponent key
                |> (\( ( moduleName, _ ), m ) ->
                        { m
                            | components =
                                Dict.insert
                                    key
                                    ( moduleName, typeName )
                                    model.components
                        }
                   )
                |> pushUrl

        ComponentRemoved key ->
            { model | components = Dict.remove key model.components }
                |> pushUrl


ensureComponent : Int -> Model -> ( ( String, String ), Model )
ensureComponent key model =
    case Dict.get key model.components of
        Nothing ->
            ( ( "", "" )
            , { model
                | lastComponentKey =
                    if key > model.lastComponentKey then
                        key

                    else
                        model.lastComponentKey
              }
            )

        Just compnent ->
            ( compnent, model )


decodeFragment : Url -> Result (Maybe String) EcsGenerator.Config
decodeFragment url =
    case url.fragment of
        Nothing ->
            Err Nothing

        Just "" ->
            Err Nothing

        Just fragment ->
            fragment
                |> Url.percentDecode
                |> Maybe.withDefault ""
                |> EcsGenerator.decode
                |> Result.mapError (Decode.errorToString >> Just)


pushUrl : Model -> ( Model, Cmd Msg )
pushUrl model =
    EcsGenerator.validate (toConfig model)
        |> Result.map
            (\config ->
                let
                    encodedConfig =
                        Url.percentEncode (EcsGenerator.encode config)
                in
                ( { model
                    | encodedConfig = encodedConfig
                    , decodeError = Nothing
                  }
                , Navigation.pushUrl model.navigationKey ("#" ++ encodedConfig)
                )
            )
        |> Result.withDefault ( model, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "ECS Generator"
    , body =
        List.map Html.toUnstyled
            [ Css.Global.global
                [ Css.Global.everything
                    [ Css.boxSizing Css.borderBox
                    , Css.fontFamily Css.monospace
                    , Css.fontSize (Css.px 16)
                    ]
                , Css.Global.body
                    [ Css.padding Css.zero
                    , Css.margin Css.zero
                    ]
                ]
            , viewHeading
            , Html.div
                [ Attributes.css
                    [ Css.displayFlex
                    , Css.justifyContent Css.center
                    ]
                ]
                [ Html.div
                    [ Attributes.css
                        [ Css.flexDirection Css.column
                        , Css.textAlign Css.center
                        ]
                    ]
                    [ viewHeading2 "ecs (module name | type name)"
                    , viewEcsInputs model.ecs
                    , viewHeading2 "components (module name | type name)"
                    , viewComponents model
                    ]
                ]
            , viewHeading2 "generated code"
            , viewGeneratResult model
            ]
    }


viewHeading : Html Msg
viewHeading =
    Html.h1
        [ Attributes.css
            [ Css.fontSize (Css.em 1)
            , Css.textAlign Css.center
            , Css.margin3 (Css.px 5) Css.zero Css.zero
            ]
        ]
        [ Html.text "ecs generator"
        , Html.text " - basic "
        , Html.a
            [ Attributes.href "#%7B%22ecs%22%3A%5B%22Ecs%22%2C%22Ecs%22%5D%2C%22components%22%3A%5B%5B%22Components%22%2C%22Bounce%22%5D%2C%5B%22Components%22%2C%22Color%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Teleport%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%2C%22nodes%22%3A%5B%7B%22name%22%3A%22boundsBounce%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Bounce%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22boundsTeleport%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Teleport%22%5D%5D%7D%2C%7B%22name%22%3A%22movement%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22render%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Color%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%5D%7D" ]
            [ Html.text "example" ]
        , Html.text "/"
        , Html.a
            [ Attributes.href "../examples/basic/" ]
            [ Html.text "live" ]
        , Html.text " - demo "
        , Html.a
            [ Attributes.href "#%7B%22ecs%22%3A%5B%22Ecs%22%2C%22Ecs%22%5D%2C%22components%22%3A%5B%5B%22Components%22%2C%22Ai%22%5D%2C%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Scale%22%5D%2C%5B%22Components%22%2C%22ScaleAnimation%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%2C%5B%22Components.Transforms%22%2C%22Transforms%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%2C%22nodes%22%3A%5B%7B%22name%22%3A%22collectable%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22collector%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22keyControls%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%5D%7D%2C%7B%22name%22%3A%22motionControl%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22movement%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22render%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%5D%7D%2C%7B%22name%22%3A%22scaleAnimation%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22ScaleAnimation%22%5D%5D%7D%2C%7B%22name%22%3A%22transform%22%2C%22components%22%3A%5B%5B%22Components.Transforms%22%2C%22Transforms%22%5D%5D%7D%5D%7D" ]
            [ Html.text "example" ]
        , Html.text "/"
        , Html.a
            [ Attributes.href "../examples/demo/build/" ]
            [ Html.text "live" ]
        , Html.text " - "
        , Html.a
            [ Attributes.href "https://github.com/harmboschloo/elm-ecs-generator" ]
            [ Html.text "code" ]
        ]


viewHeading2 : String -> Html Msg
viewHeading2 heading =
    Html.h2
        [ Attributes.css
            [ Css.fontSize (Css.em 0.9)
            , Css.textAlign Css.center
            , Css.margin3 (Css.px 8) Css.zero (Css.px 4)
            ]
        ]
        [ Html.text heading ]


viewEcsInputs : ( String, String ) -> Html Msg
viewEcsInputs ( moduleName, typeName ) =
    Html.div
        [ Attributes.css
            [ Css.display Css.inlineBlock
            ]
        ]
        [ Html.input
            [ Attributes.value moduleName
            , Events.onInput EcsModuleNameChanged
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
        , Html.input
            [ Attributes.value typeName
            , Events.onInput EcsTypeNameChanged
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
        ]


viewComponents : Model -> Html Msg
viewComponents { lastComponentKey, components } =
    HtmlKeyed.node "div"
        [ Attributes.css
            [ Css.property "display" "inline-grid"
            , Css.property "grid-template-columns" "auto auto auto"
            ]
        ]
        ((Dict.toList components ++ [ ( lastComponentKey + 1, ( "", "" ) ) ])
            |> List.map viewComponentInputs
            |> List.concat
        )


viewComponentInputs : ( Int, ( String, String ) ) -> List ( String, Html Msg )
viewComponentInputs ( key, ( moduleName, typeName ) ) =
    [ ( "componentModuleName" ++ String.fromInt key
      , Html.input
            [ Attributes.value moduleName
            , Attributes.placeholder "module name"
            , Events.onInput (ComponentModuleNameChanged key)
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
      )
    , ( "componentTypeName" ++ String.fromInt key
      , Html.input
            [ Attributes.value typeName
            , Attributes.placeholder "type name"
            , Events.onInput (ComponentTypeNameChanged key)
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
      )
    , ( "componentRemoveButton" ++ String.fromInt key
      , Html.button
            [ Events.onClick (ComponentRemoved key)
            , Attributes.tabindex -1
            ]
            [ Html.text "remove" ]
      )
    ]


viewGeneratResult : Model -> Html Msg
viewGeneratResult model =
    case ( model.decodeError, EcsGenerator.generate (toConfig model) ) of
        ( Just decodeError, Err errors ) ->
            viewErrors decodeError errors

        ( Just decodeError, Ok _ ) ->
            viewErrors decodeError []

        ( Nothing, Err errors ) ->
            viewErrors "" errors

        ( Nothing, Ok ecsCode ) ->
            viewEcsCode ecsCode


viewErrors : String -> List Error -> Html Msg
viewErrors decodeError errors =
    let
        content =
            String.join "\n" (decodeError :: List.map errorToString errors)

        lines =
            List.length (String.lines content)
    in
    Html.textarea
        (textAreaAttributes lines errorStyles)
        [ Html.text content ]


viewEcsCode : String -> Html Msg
viewEcsCode ecsCode =
    let
        lines =
            List.length (String.lines ecsCode)
    in
    Html.textarea
        (textAreaAttributes lines [])
        [ Html.text ecsCode ]


textAreaAttributes : Int -> List Css.Style -> List (Html.Attribute Msg)
textAreaAttributes numberOfLines extraStyles =
    [ Attributes.readonly True
    , Attributes.rows (numberOfLines + 1)
    , Attributes.wrap "off"
    , Attributes.css
        ([ Css.width (Css.pct 100)
         , Css.fontSize (Css.px 14)
         ]
            ++ extraStyles
        )
    ]


errorStyles : List Css.Style
errorStyles =
    [ Css.color (Css.rgb 255 0 0)
    , Css.borderColor (Css.rgb 255 0 0)
    ]


errorToString : Error -> String
errorToString error =
    case error of
        Error.InvalidEcsModuleName ecs ->
            "invalid ecs module name: " ++ EcsGenerator.ecsModuleName ecs

        Error.InvalidEcsTypeName ecs ->
            "invalid ecs type name: " ++ EcsGenerator.ecsTypeName ecs

        Error.ComponentsEmpty ->
            "no components entered"

        Error.InvalidComponentModuleName component ->
            "invalid component module name: "
                ++ EcsGenerator.componentModuleName component

        Error.InvalidComponentTypeName component ->
            "invalid component type name: "
                ++ EcsGenerator.componentTypeName component

        Error.DuplicateComponent component ->
            "duplicate component: "
                ++ EcsGenerator.componentModuleName component
                ++ "."
                ++ EcsGenerator.componentTypeName component



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }
