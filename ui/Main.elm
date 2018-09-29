module Main exposing (main)

import Array exposing (Array)
import Browser exposing (Document, UrlRequest)
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import EcsGenerator
    exposing
        ( Config
        , Error(..)
        , decode
        , encode
        , generate
        )
import Html
    exposing
        ( Attribute
        , Html
        , button
        , div
        , form
        , hr
        , input
        , text
        , textarea
        )
import Html.Attributes
    exposing
        ( autofocus
        , id
        , pattern
        , placeholder
        , readonly
        , required
        , rows
        , style
        , value
        , wrap
        )
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Lazy exposing (lazy, lazy2)
import Set exposing (Set)
import Task
import Url exposing (Url, percentDecode, percentEncode)



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
    | LinkClicked UrlRequest
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


decodeFragment : Url -> Config
decodeFragment url =
    url.fragment
        |> Maybe.andThen percentDecode
        |> Maybe.withDefault ""
        |> decode


pushUrlCmd : Navigation.Key -> String -> Set ( String, String ) -> Cmd Msg
pushUrlCmd navigationKey ecsModuleName components =
    Navigation.pushUrl
        navigationKey
        ("#"
            ++ (encode >> percentEncode)
                { moduleName = ecsModuleName
                , components = components
                }
        )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "ECS Generator"
    , body =
        [ viewEcsModuleNameInput model.ecsModuleName
        , hr [] []
        , viewComponentInputs model.componentModuleName model.componentTypeName
        , lazy viewComponents model.components
        , hr [] []
        , lazy2 viewGeneratResult model.ecsModuleName model.components
        ]
    }


viewEcsModuleNameInput : String -> Html Msg
viewEcsModuleNameInput moduleName =
    div []
        [ text "ecs module name: "
        , input
            [ value moduleName
            , required True
            , onInput EcsModuleNameChanged
            ]
            []
        ]


viewComponentInputs : String -> String -> Html Msg
viewComponentInputs moduleName typeName =
    form [ onSubmit ComponentSubmitted ]
        [ text "component: "
        , input
            [ id "componentModuleNameInput"
            , value moduleName
            , required True
            , placeholder "module name"
            , autofocus True
            , onInput ComponentModuleNameChanged
            ]
            []
        , input
            [ value typeName
            , required True
            , placeholder "type name"
            , onInput ComponentTypeNameChanged
            ]
            []
        , button [] [ text "add" ]
        ]


viewComponents : Set ( String, String ) -> Html Msg
viewComponents components =
    div [] (components |> Set.toList |> List.sort |> List.map viewComponent)


viewComponent : ( String, String ) -> Html Msg
viewComponent ( moduleName, typeName ) =
    div []
        [ text (moduleName ++ "." ++ typeName)
        , button
            [ onClick (ComponentRemoved ( moduleName, typeName )) ]
            [ text "remove" ]
        ]


viewGeneratResult : String -> Set ( String, String ) -> Html Msg
viewGeneratResult ecsModuleName components =
    if Set.isEmpty components then
        text "-- no components --"

    else
        case
            generate
                { moduleName = ecsModuleName
                , components = components
                }
        of
            Err errors ->
                viewErrors errors

            Ok ecsCode ->
                viewEcsCode ecsCode


viewErrors : List Error -> Html Msg
viewErrors errors =
    let
        content =
            String.join "\n" (List.map errorToString errors)

        lines =
            List.length errors
    in
    textarea
        (textAreaStyles lines ++ errorStyles True)
        [ text content ]


viewEcsCode : String -> Html Msg
viewEcsCode ecsCode =
    let
        lines =
            List.length (String.lines ecsCode)
    in
    textarea
        (textAreaStyles lines)
        [ text ecsCode ]


textAreaStyles : Int -> List (Attribute Msg)
textAreaStyles numberOfLines =
    [ readonly True
    , rows (numberOfLines + 1)
    , wrap "off"
    , style "width" "100%"
    ]


errorStyles : Bool -> List (Attribute Msg)
errorStyles hasError =
    if hasError then
        [ style "color" "#ff0000"
        , style "borderColor" "#ff0000"
        ]

    else
        []


errorToString : Error -> String
errorToString error =
    case error of
        ComponentsEmpty ->
            "No components entered"

        InvalidEcsModuleName name ->
            "Invalid ecs module name: " ++ name

        InvalidComponentModuleName name ->
            "Invalid component module name: " ++ name

        InvalidComponentTypeName name ->
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
