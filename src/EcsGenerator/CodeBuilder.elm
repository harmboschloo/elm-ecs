module EcsGenerator.CodeBuilder exposing
    ( Builder
    , comment
    , declaration
    , exposed
    , imported
    , init
    , internal
    , replace
    , toString
    )

import Dict exposing (Dict)
import EcsGenerator.Utils as Utils
import Set exposing (Set)


type Builder
    = Model
        { moduleName : String
        , topComment : String
        , topDocs : String
        , exposed : Dict String ( Int, List String )
        , imported : Set String
        , statements : List String
        }


type DeclarationType
    = InternalDeclaration
    | ExposedDeclaration String String


init : String -> String -> String -> Builder
init moduleName topComment topDocs =
    Model
        { moduleName = moduleName
        , topComment = String.trim topComment
        , topDocs = String.trim topDocs
        , exposed = Dict.empty
        , imported = Set.empty
        , statements = []
        }


internal : DeclarationType
internal =
    InternalDeclaration


exposed : String -> String -> DeclarationType
exposed =
    ExposedDeclaration


imported : String -> Builder -> Builder
imported moduleName (Model model) =
    Model { model | imported = Set.insert (String.trim moduleName) model.imported }


declaration : DeclarationType -> String -> Builder -> Builder
declaration type_ value (Model model) =
    let
        trimmed =
            String.trim value

        ( statement, updatedExposed ) =
            case type_ of
                InternalDeclaration ->
                    ( trimmed
                    , model.exposed
                    )

                ExposedDeclaration name category ->
                    ( "{-| -}\n" ++ trimmed
                    , Dict.update
                        category
                        (Maybe.withDefault ( Dict.size model.exposed, [] )
                            >> Tuple.mapSecond ((::) name)
                            >> Just
                        )
                        model.exposed
                    )
    in
    Model
        { model
            | statements = statement :: model.statements
            , exposed = updatedExposed
        }


comment : String -> Builder -> Builder
comment value (Model model) =
    Model { model | statements = formatComment value :: model.statements }


formatComment : String -> String
formatComment value =
    "\n" ++ String.trim value


replace : String -> String -> Builder -> Builder
replace from to (Model model) =
    Model
        { model
            | moduleName = Utils.replace from to model.moduleName
            , exposed =
                Dict.map
                    (\_ -> Tuple.mapSecond (List.map (Utils.replace from to)))
                    model.exposed
            , imported = Set.map (Utils.replace from to) model.imported
            , statements = List.map (Utils.replace from to) model.statements
        }


toString : Builder -> String
toString (Model model) =
    let
        exposedValues =
            Dict.toList model.exposed
                |> List.sortBy (Tuple.second >> Tuple.first)
                |> List.map
                    (\( heading, ( _, values ) ) ->
                        ( heading, List.reverse values )
                    )
    in
    model.topComment
        :: ("module "
                ++ model.moduleName
                ++ " exposing\n    ( "
                ++ (exposedValues
                        |> List.map (Tuple.second >> String.join ", ")
                        |> String.join "\n    , "
                   )
                ++ "\n    )\n\n"
                ++ "{-| "
                ++ model.topDocs
                ++ "\n\n\n"
                ++ (exposedValues
                        |> List.map
                            (\( heading, values ) ->
                                "# "
                                    ++ heading
                                    ++ "\n\n"
                                    ++ "@docs "
                                    ++ String.join ", " values
                            )
                        |> String.join "\n\n\n"
                        |> Utils.append "\n\n-}\n\n"
                   )
                ++ (Set.toList model.imported
                        |> List.sort
                        |> List.map ((++) "import ")
                        |> String.join "\n"
                   )
           )
        :: List.reverse model.statements
        |> String.join "\n\n\n"
        |> Utils.append "\n"
