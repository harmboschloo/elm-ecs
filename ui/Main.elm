module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import EcsGenerator
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Html.Lazy as Lazy
import Set exposing (Set)
import Task
import Url exposing (Url)



-- MODEL


type alias Model =
    { navigationKey : Navigation.Key
    , ecsModuleName : String
    , componentModuleName : String
    , componentTypeName : String
    , components : Set ( String, String )
    }


init : () -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url navigationKey =
    let
        config =
            decodeFragment url
    in
    ( { navigationKey = navigationKey
      , ecsModuleName = config.moduleName
      , componentModuleName = ""
      , componentTypeName = ""
      , components = config.components
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | EcsModuleNameChanged String
    | ComponentModuleNameChanged String
    | ComponentTypeNameChanged String
    | ComponentSubmitted
    | ComponentRemoved ( String, String )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            ( model, Cmd.none )

        UrlChanged url ->
            let
                config =
                    decodeFragment url
            in
            ( { model
                | ecsModuleName = config.moduleName
                , components = config.components
              }
            , Cmd.none
            )

        EcsModuleNameChanged ecsModuleName ->
            ( { model | ecsModuleName = ecsModuleName }
            , pushUrlCmd model.navigationKey ecsModuleName model.components
            )

        ComponentModuleNameChanged componentModuleName ->
            ( { model | componentModuleName = componentModuleName }, Cmd.none )

        ComponentTypeNameChanged componentTypeName ->
            ( { model | componentTypeName = componentTypeName }, Cmd.none )

        ComponentSubmitted ->
            let
                moduleName =
                    model.componentModuleName

                typeName =
                    model.componentTypeName
            in
            ( { model
                | componentModuleName = ""
                , componentTypeName = ""
              }
            , Cmd.batch
                [ Task.attempt
                    (always NoOp)
                    (Dom.focus "componentModuleNameInput")
                , pushUrlCmd
                    model.navigationKey
                    model.ecsModuleName
                    (Set.insert ( moduleName, typeName ) model.components)
                ]
            )

        ComponentRemoved component ->
            ( model
            , pushUrlCmd
                model.navigationKey
                model.ecsModuleName
                (Set.remove component model.components)
            )


decodeFragment : Url -> EcsGenerator.Config
decodeFragment url =
    url.fragment
        |> Maybe.andThen Url.percentDecode
        |> Maybe.withDefault ""
        |> EcsGenerator.decode


pushUrlCmd : Navigation.Key -> String -> Set ( String, String ) -> Cmd Msg
pushUrlCmd navigationKey ecsModuleName components =
    Navigation.pushUrl
        navigationKey
        ("#"
            ++ (EcsGenerator.encode >> Url.percentEncode)
                { moduleName = ecsModuleName
                , components = components
                }
        )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "ECS Generator"
    , body =
        [ viewEcsModuleNameInput model.ecsModuleName
        , Html.hr [] []
        , viewComponentInputs model.componentModuleName model.componentTypeName
        , Lazy.lazy viewComponents model.components
        , Html.hr [] []
        , Lazy.lazy2 viewGeneratResult model.ecsModuleName model.components
        ]
    }


viewEcsModuleNameInput : String -> Html Msg
viewEcsModuleNameInput moduleName =
    Html.div []
        [ Html.text "ecs module name: "
        , Html.input
            [ Attributes.value moduleName
            , Attributes.required True
            , Events.onInput EcsModuleNameChanged
            ]
            []
        ]


viewComponentInputs : String -> String -> Html Msg
viewComponentInputs moduleName typeName =
    Html.form [ Events.onSubmit ComponentSubmitted ]
        [ Html.text "component: "
        , Html.input
            [ Attributes.id "componentModuleNameInput"
            , Attributes.value moduleName
            , Attributes.required True
            , Attributes.placeholder "module name"
            , Attributes.autofocus True
            , Events.onInput ComponentModuleNameChanged
            ]
            []
        , Html.input
            [ Attributes.value typeName
            , Attributes.required True
            , Attributes.placeholder "type name"
            , Events.onInput ComponentTypeNameChanged
            ]
            []
        , Html.button [] [ Html.text "add" ]
        ]


viewComponents : Set ( String, String ) -> Html Msg
viewComponents components =
    Html.div [] (components |> Set.toList |> List.sort |> List.map viewComponent)


viewComponent : ( String, String ) -> Html Msg
viewComponent ( moduleName, typeName ) =
    Html.div []
        [ Html.text (moduleName ++ "." ++ typeName)
        , Html.button
            [ Events.onClick (ComponentRemoved ( moduleName, typeName )) ]
            [ Html.text "remove" ]
        ]


viewGeneratResult : String -> Set ( String, String ) -> Html Msg
viewGeneratResult ecsModuleName components =
    if Set.isEmpty components then
        Html.text "-- no components --"

    else
        case
            EcsGenerator.generate
                { moduleName = ecsModuleName
                , components = components
                }
        of
            Err errors ->
                viewErrors errors

            Ok ecsCode ->
                viewEcsCode ecsCode


viewErrors : List EcsGenerator.Error -> Html Msg
viewErrors errors =
    let
        content =
            String.join "\n" (List.map errorToString errors)

        lines =
            List.length errors
    in
    Html.textarea
        (textAreaStyles lines ++ errorStyles True)
        [ Html.text content ]


viewEcsCode : String -> Html Msg
viewEcsCode ecsCode =
    let
        lines =
            List.length (String.lines ecsCode)
    in
    Html.textarea
        (textAreaStyles lines)
        [ Html.text ecsCode ]


textAreaStyles : Int -> List (Html.Attribute Msg)
textAreaStyles numberOfLines =
    [ Attributes.readonly True
    , Attributes.rows (numberOfLines + 1)
    , Attributes.wrap "off"
    , Attributes.style "width" "100%"
    ]


errorStyles : Bool -> List (Html.Attribute Msg)
errorStyles hasError =
    if hasError then
        [ Attributes.style "color" "#ff0000"
        , Attributes.style "borderColor" "#ff0000"
        ]

    else
        []


errorToString : EcsGenerator.Error -> String
errorToString error =
    case error of
        EcsGenerator.ComponentsEmpty ->
            "No components entered"

        EcsGenerator.InvalidEcsModuleName name ->
            "Invalid ecs module name: " ++ name

        EcsGenerator.InvalidComponentModuleName name ->
            "Invalid component module name: " ++ name

        EcsGenerator.InvalidComponentTypeName name ->
            "Invalid component type name: " ++ name



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
