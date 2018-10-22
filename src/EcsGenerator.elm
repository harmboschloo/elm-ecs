module EcsGenerator exposing
    ( Config, Ecs, Component
    , ecs, ecsModuleName, ecsTypeName
    , component, componentModuleName, componentTypeName
    , validate, isValidModuleName, isValidTypeName, isValidVariableName
    , generate
    , encode, decode
    )

{-|


# Config

@docs Config, Ecs, Component
@docs ecs, ecsModuleName, ecsTypeName
@docs component, componentModuleName, componentTypeName


# Validation

@docs validate, isValidModuleName, isValidTypeName, isValidVariableName


# Generation

@docs generate


# Encoding

@docs encode, decode

-}

import EcsGenerator.Config as Config
import EcsGenerator.Error exposing (Error)
import EcsGenerator.Generate as Generate
import EcsGenerator.Validate as Validate
import Json.Decode as Decode
import Json.Encode as Encode



-- CONFIG --


{-| -}
type alias Config =
    Config.Config


{-| -}
type alias Ecs =
    Config.Ecs


{-| -}
type alias Component =
    Config.Component


{-| -}
ecs : String -> String -> Ecs
ecs =
    Config.ecs


{-| -}
ecsModuleName : Ecs -> String
ecsModuleName =
    Config.ecsModuleName


{-| -}
ecsTypeName : Ecs -> String
ecsTypeName =
    Config.ecsTypeName


{-| -}
component : String -> String -> Component
component =
    Config.component


{-| -}
componentModuleName : Component -> String
componentModuleName =
    Config.componentModuleName


{-| -}
componentTypeName : Component -> String
componentTypeName =
    Config.componentTypeName



-- VALIDATION --


{-| -}
validate : Config -> Result (List Error) Config
validate =
    Validate.validate


{-| -}
isValidModuleName : String -> Bool
isValidModuleName =
    Validate.isValidModuleName


{-| -}
isValidTypeName : String -> Bool
isValidTypeName =
    Validate.isValidTypeName


{-| -}
isValidVariableName : String -> Bool
isValidVariableName =
    Validate.isValidVariableName



-- GENERATION --


{-| -}
generate : Config -> Result (List Error) String
generate =
    Validate.validate >> Result.map Generate.generate



-- ENCODING --


{-| -}
decode : String -> Result Decode.Error Config
decode =
    Config.decodeString


{-| -}
encode : Config -> String
encode =
    Config.encodeString
