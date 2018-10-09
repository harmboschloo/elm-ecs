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
    , iterators : Dict Int { name : String, components : List Int }
    , lastComponentKey : Int
    , lastIteratorKey : Int
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
    , iterators = Dict.empty
    , lastComponentKey = 0
    , lastIteratorKey = 0
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

        iterators =
            config.iterators
                |> List.map
                    (\iterator ->
                        { name = EcsGenerator.iteratorName iterator
                        , components =
                            EcsGenerator.iteratorComponents iterator
                                |> List.map fromComponent
                                |> List.filterMap (findComponentKey components)
                        }
                    )
                |> List.indexedMap (\i v -> ( i, v ))
                |> Dict.fromList
    in
    { navigationKey = navigationKey
    , encodedConfig = ""
    , ecs = ecs
    , decodeError = Nothing
    , components = components
    , iterators = iterators
    , lastComponentKey = Dict.size components
    , lastIteratorKey = Dict.size iterators
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
    , iterators =
        Dict.values model.iterators
            |> List.sortBy .name
            |> List.map
                (\{ name, components } ->
                    EcsGenerator.iterator
                        name
                        (components
                            |> List.filterMap (findComponent model.components)
                            |> List.sortBy Tuple.second
                            |> List.map (tupleMap2 EcsGenerator.component)
                        )
                )
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
    | IteratorNameChanged Int String
    | IteratorComponentChanged Int Int Bool
    | IteratorRemoved Int


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

        IteratorNameChanged key name ->
            model
                |> ensureIterator key
                |> (\( i, m ) ->
                        { m
                            | iterators =
                                Dict.insert
                                    key
                                    { i | name = name }
                                    model.iterators
                        }
                   )
                |> pushUrl

        IteratorComponentChanged iteratorKey componentKey checked ->
            model
                |> ensureIterator iteratorKey
                |> updateIteratorComponent iteratorKey componentKey checked
                |> pushUrl

        IteratorRemoved key ->
            { model | iterators = Dict.remove key model.iterators }
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


ensureIterator : Int -> Model -> ( { name : String, components : List Int }, Model )
ensureIterator key model =
    case Dict.get key model.iterators of
        Nothing ->
            ( { name = "", components = [] }
            , { model
                | lastIteratorKey =
                    if key > model.lastIteratorKey then
                        key

                    else
                        model.lastIteratorKey
              }
            )

        Just iterator ->
            ( iterator, model )


updateIteratorComponent :
    Int
    -> Int
    -> Bool
    -> ( { name : String, components : List Int }, Model )
    -> Model
updateIteratorComponent iteratorKey componentKey checked ( iterator, model ) =
    { model
        | iterators =
            Dict.insert
                iteratorKey
                { iterator
                    | components =
                        if checked then
                            componentKey :: iterator.components

                        else
                            List.filter
                                (\key -> key /= componentKey)
                                iterator.components
                }
                model.iterators
    }


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
                        ]
                    ]
                    [ viewEcsInputs model.ecs
                    , viewComponents model
                    , viewIterators model
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
        (List.intersperse (Html.text " - ")
            [ Html.text "ecs generator"
            , Html.a
                [ Attributes.href "#%7B%22ecs%22%3A%5B%22Ecs%22%2C%22Ecs%22%5D%2C%22components%22%3A%5B%5B%22Components%22%2C%22Ai%22%5D%2C%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22Destroy%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Scale%22%5D%2C%5B%22Components%22%2C%22ScaleAnimation%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%2C%22iterators%22%3A%5B%7B%22name%22%3A%22Animation%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Scale%22%5D%2C%5B%22Components%22%2C%22ScaleAnimation%22%5D%5D%7D%2C%7B%22name%22%3A%22Collectable%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collectable%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22Collector%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Collector%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%5D%7D%2C%7B%22name%22%3A%22Destroy%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Destroy%22%5D%5D%7D%2C%7B%22name%22%3A%22KeyControls%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22KeyControlsMap%22%5D%5D%7D%2C%7B%22name%22%3A%22MotionControl%22%2C%22components%22%3A%5B%5B%22Components.Controls%22%2C%22Controls%22%5D%2C%5B%22Components%22%2C%22Motion%22%5D%2C%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22Movement%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Velocity%22%5D%5D%7D%2C%7B%22name%22%3A%22Render%22%2C%22components%22%3A%5B%5B%22Components%22%2C%22Position%22%5D%2C%5B%22Components%22%2C%22Sprite%22%5D%5D%7D%5D%7D" ]
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


viewEcsInputs : ( String, String ) -> Html Msg
viewEcsInputs ( moduleName, typeName ) =
    Html.div
        [ Attributes.css
            [ Css.textAlign Css.center ]
        ]
        [ viewHeading2 "ecs (moduleName|typename)"
        , Html.div []
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
        ]


viewComponents : Model -> Html Msg
viewComponents { lastComponentKey, components } =
    Html.div []
        [ viewHeading2 "components (moduleName|typename)"
        , HtmlKeyed.ul
            [ Attributes.css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "auto auto auto"
                ]
            ]
            ((Dict.toList components ++ [ ( lastComponentKey + 1, ( "", "" ) ) ])
                |> List.map viewComponentInputs
                |> List.concat
            )
        ]


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


viewIterators : Model -> Html Msg
viewIterators { lastIteratorKey, components, iterators } =
    Html.div []
        [ viewHeading2 "iterators (name|components)"
        , HtmlKeyed.ul
            [ Attributes.css
                [ Css.property "display" "grid"
                , Css.property "grid-template-columns" "auto auto auto"
                ]
            ]
            ((Dict.toList iterators ++ [ ( lastIteratorKey + 1, { name = "", components = [] } ) ])
                |> List.map (viewIteratorInputs components)
                |> List.concat
            )
        ]


viewIteratorInputs :
    Dict Int ( String, String )
    -> ( Int, { name : String, components : List Int } )
    -> List ( String, Html Msg )
viewIteratorInputs components ( iteratorKey, iterator ) =
    [ ( "iteratorName" ++ String.fromInt iteratorKey
      , Html.input
            [ Attributes.value iterator.name
            , Attributes.placeholder "name"
            , Events.onInput (IteratorNameChanged iteratorKey)
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
      )
    , ( "iteratorComponents" ++ String.fromInt iteratorKey
      , Html.div
            [ Attributes.css
                [ Css.border2 (Css.px 1) Css.inset
                , Css.displayFlex
                , Css.flexWrap Css.wrap
                ]
            ]
            (components
                |> Dict.toList
                |> List.sort
                |> List.map
                    (\( componentKey, ( _, componentTypeName ) ) ->
                        ( List.member componentKey iterator.components
                        , componentKey
                        , componentTypeName
                        )
                    )
                |> List.map (viewIteratorComponent iteratorKey)
            )
      )
    , ( "iteratorRemoveButton" ++ String.fromInt iteratorKey
      , Html.button
            [ Events.onClick (IteratorRemoved iteratorKey)
            , Attributes.tabindex -1
            ]
            [ Html.text "remove" ]
      )
    ]


viewIteratorComponent : Int -> ( Bool, Int, String ) -> Html Msg
viewIteratorComponent iteratorKey ( isMember, componentKey, componentTypeName ) =
    Html.label
        [ Attributes.css
            (List.concat
                [ [ Css.display Css.inlineBlock
                  , Css.whiteSpace Css.noWrap
                  , Css.padding (Css.px 4)
                  ]
                , if isMember then
                    [ Css.fontWeight Css.bold
                    , Css.backgroundColor (Css.rgb 0x00 0xFF 0x00)
                    ]

                  else
                    []
                ]
            )
        ]
        [ Html.input
            [ Attributes.type_ "checkbox"
            , Attributes.checked isMember
            , Events.onCheck (IteratorComponentChanged iteratorKey componentKey)
            , Attributes.css
                [ Css.padding (Css.px 4)
                ]
            ]
            []
        , Html.text componentTypeName
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

        Error.IteratorsEmpty ->
            "no iterators entered"

        Error.IteratorNameInvalid iterator ->
            "invalid iterator name: "
                ++ EcsGenerator.iteratorName iterator

        Error.IteratorComponentsEmpty iterator ->
            "components empty for iterator '"
                ++ EcsGenerator.iteratorName iterator
                ++ "'"

        Error.UnknownIteratorComponent iterator component ->
            "unkown component for iterator '"
                ++ EcsGenerator.iteratorName iterator
                ++ "': "
                ++ EcsGenerator.componentModuleName component
                ++ "."
                ++ EcsGenerator.componentTypeName component

        Error.DuplicateIteratorComponent iterator component ->
            "duplicate component for iterator '"
                ++ EcsGenerator.iteratorName iterator
                ++ "': "
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
