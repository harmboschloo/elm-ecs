module Main exposing (main)

import Array exposing (Array)
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Navigation
import Css
import Css.Global
import EcsGenerator
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attributes
import Html.Styled.Events as Events
import Html.Styled.Lazy as Lazy
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

        ecsModuleName =
            if String.isEmpty config.moduleName then
                "Ecs"

            else
                config.moduleName
    in
    ( { navigationKey = navigationKey
      , ecsModuleName = ecsModuleName
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
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Navigation.pushUrl model.navigationKey (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Navigation.load url
                    )

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
                        ]
                    ]
                    [ viewEcsModuleNameInput model.ecsModuleName
                    , viewComponents
                        model.componentModuleName
                        model.componentTypeName
                        model.components
                    ]
                ]
            , viewHeading2 "generated code"
            , Lazy.lazy2 viewGeneratResult model.ecsModuleName model.components
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
        (List.intersperse (Html.text " - ")
            [ Html.text "ecs generator"
            , Html.a
                [ Attributes.href "https://harmboschloo.github.io/elm-ecs-generator/#Ecs%3BComponents%2CAi%3BComponents%2CCollectable%3BComponents%2CCollector%3BComponents%2CDestroy%3BComponents%2CKeyControlsMap%3BComponents%2CMotion%3BComponents%2CPosition%3BComponents%2CScale%3BComponents%2CScaleAnimation%3BComponents%2CSprite%3BComponents%2CVelocity%3BComponents.Controls%2CControls" ]
                [ Html.text "example" ]
            , Html.a
                [ Attributes.href "https://harmboschloo.github.io/elm-ecs-generator/example/build/" ]
                [ Html.text "example demo" ]
            , Html.a
                [ Attributes.href "https://github.com/harmboschloo/elm-ecs-generator" ]
                [ Html.text "code" ]
            ]
        )


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


viewEcsModuleNameInput : String -> Html Msg
viewEcsModuleNameInput moduleName =
    Html.div []
        [ viewHeading2 "ecs module name"
        , Html.input
            [ Attributes.value moduleName
            , Attributes.required True
            , Events.onInput EcsModuleNameChanged
            , Attributes.css
                [ Css.width (Css.pct 100)
                , Css.padding (Css.px 4)
                ]
            ]
            []
        ]


viewComponents : String -> String -> Set ( String, String ) -> Html Msg
viewComponents moduleNameInput typeNameInput components =
    Html.div []
        [ viewHeading2 "components"
        , Html.form
            [ Events.onSubmit ComponentSubmitted
            , Attributes.css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "auto auto auto"
                ]
            ]
            (viewComponentInputs moduleNameInput typeNameInput
                :: (components |> Set.toList |> List.sort |> List.map viewComponent)
                |> List.concat
            )
        ]


viewComponentInputs : String -> String -> List (Html Msg)
viewComponentInputs moduleName typeName =
    [ Html.input
        [ Attributes.id "componentModuleNameInput"
        , Attributes.value moduleName
        , Attributes.required True
        , Attributes.placeholder "module name"
        , Attributes.autofocus True
        , Events.onInput ComponentModuleNameChanged
        , Attributes.css
            [ Css.padding (Css.px 4)
            ]
        ]
        []
    , Html.input
        [ Attributes.value typeName
        , Attributes.required True
        , Attributes.placeholder "type name"
        , Events.onInput ComponentTypeNameChanged
        , Attributes.css
            [ Css.padding (Css.px 4)
            ]
        ]
        []
    , Html.button
        [ Attributes.type_ "submit" ]
        [ Html.text "add" ]
    ]


viewComponent : ( String, String ) -> List (Html Msg)
viewComponent ( moduleName, typeName ) =
    [ Html.span
        [ Attributes.css
            [ Css.padding (Css.px 5)
            ]
        ]
        [ Html.text moduleName ]
    , Html.span
        [ Attributes.css
            [ Css.padding (Css.px 5)
            ]
        ]
        [ Html.text typeName ]
    , Html.button
        [ Events.onClick (ComponentRemoved ( moduleName, typeName ))
        , Attributes.type_ "button"
        ]
        [ Html.text "remove" ]
    ]


viewGeneratResult : String -> Set ( String, String ) -> Html Msg
viewGeneratResult ecsModuleName components =
    if String.isEmpty ecsModuleName then
        viewEcsCode "-- no ecs module name --"

    else if Set.isEmpty components then
        viewEcsCode "-- no components --"

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
