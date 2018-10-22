module EcsGenerator.Config exposing
    ( Component(..)
    , Config
    , Ecs(..)
    , component
    , componentModuleName
    , componentTypeName
    , decodeString
    , decoder
    , ecs
    , ecsModuleName
    , ecsTypeName
    , encode
    , encodeString
    )

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias Config =
    { ecs : Ecs
    , components : List Component
    }


type Ecs
    = Ecs { moduleName : String, typeName : String }


type Component
    = Component { moduleName : String, typeName : String }


ecs : String -> String -> Ecs
ecs moduleName typeName =
    Ecs
        { moduleName = moduleName
        , typeName = typeName
        }


ecsModuleName : Ecs -> String
ecsModuleName (Ecs { moduleName }) =
    moduleName


ecsTypeName : Ecs -> String
ecsTypeName (Ecs { typeName }) =
    typeName


component : String -> String -> Component
component moduleName typeName =
    Component
        { moduleName = moduleName
        , typeName = typeName
        }


componentModuleName : Component -> String
componentModuleName (Component { moduleName }) =
    moduleName


componentTypeName : Component -> String
componentTypeName (Component { typeName }) =
    typeName


decodeString : String -> Result Decode.Error Config
decodeString =
    Decode.decodeString decoder


decoder : Decoder Config
decoder =
    Decode.map2 Config
        (Decode.field "ecs" ecsDecoder)
        (Decode.field "components" (Decode.list componentDecoder))


ecsDecoder : Decoder Ecs
ecsDecoder =
    Decode.map Ecs moduleAndTypeNameDecoder


componentDecoder : Decoder Component
componentDecoder =
    Decode.map Component moduleAndTypeNameDecoder


moduleAndTypeNameDecoder : Decoder { moduleName : String, typeName : String }
moduleAndTypeNameDecoder =
    Decode.list Decode.string
        |> Decode.andThen
            (\list ->
                case list of
                    moduleName :: typeName :: [] ->
                        Decode.succeed
                            { moduleName = moduleName
                            , typeName = typeName
                            }

                    _ ->
                        Decode.fail
                            ("expected list of [moduleName, typeName] but got ["
                                ++ String.join ", " list
                                ++ "]"
                            )
            )


encodeString : Config -> String
encodeString config =
    Encode.encode 0 (encode config)


encode : Config -> Encode.Value
encode config =
    Encode.object
        [ ( "ecs", encodeEcs config.ecs )
        , ( "components", Encode.list encodeComponent config.components )
        ]


encodeEcs : Ecs -> Encode.Value
encodeEcs (Ecs ecsConfig) =
    encodeModuleAndTypeName ecsConfig


encodeComponent : Component -> Encode.Value
encodeComponent (Component componentConfig) =
    encodeModuleAndTypeName componentConfig


encodeModuleAndTypeName :
    { moduleName : String, typeName : String }
    -> Encode.Value
encodeModuleAndTypeName { moduleName, typeName } =
    Encode.list Encode.string [ moduleName, typeName ]
