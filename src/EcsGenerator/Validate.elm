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
        , Node(..)
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
                |> validateNodes config.components config.nodes
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


validateNodes : List Component -> List Node -> Errors -> Errors
validateNodes components nodes errors =
    if List.isEmpty nodes then
        NodesEmpty :: errors

    else
        List.foldl
            (\node ->
                validateNodeName node
                    >> validateNodeComponents components node
            )
            errors
            nodes


validateNodeName : Node -> Errors -> Errors
validateNodeName ((Node { name }) as node) errors =
    if isValidName (always True) name then
        errors

    else
        NodeNameInvalid node :: errors


validateNodeComponents : List Component -> Node -> Errors -> Errors
validateNodeComponents components (Node node) errors =
    if List.isEmpty node.components then
        NodeComponentsEmpty (Node node) :: errors

    else
        List.foldl
            (\nodeComponent errs ->
                (if not (List.member nodeComponent components) then
                    UnknownNodeComponent
                        (Node node)
                        nodeComponent
                        :: errs

                 else
                    errs
                )
                    |> validateNoDuplicate
                        (DuplicateNodeComponent
                            (Node node)
                            nodeComponent
                        )
                        nodeComponent
                        node.components
            )
            errors
            node.components


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
