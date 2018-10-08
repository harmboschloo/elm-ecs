module EcsGenerator.CodeBuilder exposing
    ( Document
    , comment
    , declaration
    , document
    , exposed
    , imported
    , replace
    , toString
    )

import EcsGenerator.Utils as Utils
import Set exposing (Set)


type alias Document =
    { moduleName : String
    , topComment : String
    , exposed : Set String
    , imported : Set String
    , statements : List String
    }


document : String -> String -> Document
document moduleName topComment =
    { moduleName = moduleName
    , topComment = String.trim topComment
    , exposed = Set.empty
    , imported = Set.empty
    , statements = []
    }


exposed : String -> Document -> Document
exposed value doc =
    { doc | exposed = Set.insert (String.trim value) doc.exposed }


imported : String -> Document -> Document
imported moduleName doc =
    { doc | imported = Set.insert (String.trim moduleName) doc.imported }


declaration : String -> Document -> Document
declaration value doc =
    { doc | statements = String.trim value :: doc.statements }


comment : String -> Document -> Document
comment value doc =
    { doc | statements = formatComment value :: doc.statements }


formatComment : String -> String
formatComment value =
    "\n" ++ String.trim value


replace : String -> String -> Document -> Document
replace from to doc =
    { doc
        | moduleName = Utils.replace from to doc.moduleName
        , exposed = Set.map (Utils.replace from to) doc.exposed
        , imported = Set.map (Utils.replace from to) doc.imported
        , statements = List.map (Utils.replace from to) doc.statements
    }


toString : Document -> String
toString doc =
    doc.topComment
        :: ("module "
                ++ doc.moduleName
                ++ " exposing\n    ( "
                ++ (Set.toList doc.exposed
                        |> List.sort
                        |> String.join "\n    , "
                   )
                ++ "\n    )\n\n"
                ++ (Set.toList doc.imported
                        |> List.sort
                        |> List.map ((++) "import ")
                        |> String.join "\n"
                   )
           )
        :: List.reverse doc.statements
        |> String.join "\n\n\n"
        |> Utils.append "\n"
