module EcsGenerator.Config exposing
    ( Component(..)
    , Config
    , Ecs(..)
    , Iterator(..)
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
    , iterator
    , iteratorComponents
    , iteratorName
    )

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode


type alias Config =
    { ecs : Ecs
    , components : List Component
    , iterators : List Iterator
    }


type Ecs
    = Ecs { moduleName : String, typeName : String }


type Component
    = Component { moduleName : String, typeName : String }


type Iterator
    = Iterator IteratorConfig


type alias IteratorConfig =
    { name : String
    , components : List Component
    }


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


iterator : String -> List Component -> Iterator
iterator name components =
    Iterator
        { name = name
        , components = components
        }


iteratorName : Iterator -> String
iteratorName (Iterator { name }) =
    name


iteratorComponents : Iterator -> List Component
iteratorComponents (Iterator { components }) =
    components


decodeString : String -> Result Decode.Error Config
decodeString =
    Decode.decodeString decoder


decoder : Decoder Config
decoder =
    Decode.map3 Config
        (Decode.field "ecs" ecsDecoder)
        (Decode.field "components" (Decode.list componentDecoder))
        (Decode.field "iterators" (Decode.list iteratorDecoder))


ecsDecoder : Decoder Ecs
ecsDecoder =
    Decode.map Ecs moduleAndTypeNameDecoder


componentDecoder : Decoder Component
componentDecoder =
    Decode.map Component moduleAndTypeNameDecoder


iteratorDecoder : Decoder Iterator
iteratorDecoder =
    Decode.map Iterator
        (Decode.map2 IteratorConfig
            (Decode.field "name" Decode.string)
            (Decode.field "components" (Decode.list componentDecoder))
        )


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
        , ( "iterators", Encode.list encodeIterator config.iterators )
        ]


encodeEcs : Ecs -> Encode.Value
encodeEcs (Ecs ecsConfig) =
    encodeModuleAndTypeName ecsConfig


encodeComponent : Component -> Encode.Value
encodeComponent (Component componentConfig) =
    encodeModuleAndTypeName componentConfig


encodeIterator : Iterator -> Encode.Value
encodeIterator (Iterator { name, components }) =
    Encode.object
        [ ( "name", Encode.string name )
        , ( "components", Encode.list encodeComponent components )
        ]


encodeModuleAndTypeName :
    { moduleName : String, typeName : String }
    -> Encode.Value
encodeModuleAndTypeName { moduleName, typeName } =
    Encode.list Encode.string [ moduleName, typeName ]
