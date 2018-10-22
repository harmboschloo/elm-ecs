module EcsGenerator.Validate exposing
    ( isValidModuleName
    , isValidTypeName
    , isValidVariableName
    , validate
    )

import EcsGenerator.Config
    exposing
        ( Component(..)
        , Config
        , Ecs(..)
        )
import EcsGenerator.Error exposing (Error(..))


type alias Errors =
    List Error


validate : Config -> Result Errors Config
validate config =
    let
        errors =
            []
                |> validateEcs config.ecs
                |> validateComponents config.components
    in
    case errors of
        [] ->
            Ok config

        _ ->
            Err (List.reverse errors)


validateEcs : Ecs -> Errors -> Errors
validateEcs ((Ecs { moduleName, typeName }) as ecs) =
    validateModuleName (InvalidEcsModuleName ecs) moduleName
        >> validateTypeName (InvalidEcsTypeName ecs) typeName


validateComponents : List Component -> Errors -> Errors
validateComponents components errors =
    if List.isEmpty components then
        ComponentsEmpty :: errors

    else
        List.foldl (validateComponent components) errors components


validateComponent : List Component -> Component -> Errors -> Errors
validateComponent components ((Component { moduleName, typeName }) as component) =
    validateModuleName (InvalidComponentModuleName component) moduleName
        >> validateTypeName (InvalidComponentTypeName component) typeName
        >> validateNoDuplicate (DuplicateComponent component) component components


validateNoDuplicate : Error -> a -> List a -> Errors -> Errors
validateNoDuplicate error value list errors =
    let
        totalCount =
            List.foldl
                (\item count ->
                    if item == value then
                        count + 1

                    else
                        count
                )
                0
                list
    in
    if totalCount > 1 then
        error :: errors

    else
        errors


validateModuleName : Error -> String -> Errors -> Errors
validateModuleName error moduleName errors =
    if isValidModuleName moduleName then
        errors

    else
        error :: errors


validateTypeName : Error -> String -> Errors -> Errors
validateTypeName error typeName errors =
    if isValidModuleName typeName then
        errors

    else
        error :: errors


isValidModuleName : String -> Bool
isValidModuleName moduleName =
    List.all isValidNameUpper (String.split "." moduleName)


isValidTypeName : String -> Bool
isValidTypeName =
    isValidNameUpper


isValidVariableName : String -> Bool
isValidVariableName =
    isValidNameLower


isValidNameUpper : String -> Bool
isValidNameUpper =
    isValidName Char.isUpper


isValidNameLower : String -> Bool
isValidNameLower =
    isValidName Char.isLower


isValidName : (Char -> Bool) -> String -> Bool
isValidName checkHead name =
    case String.uncons name of
        Nothing ->
            False

        Just ( head, tail ) ->
            checkHead head
                && Char.isAlpha head
                && String.all (\char -> Char.isAlphaNum char || char == '_') tail
