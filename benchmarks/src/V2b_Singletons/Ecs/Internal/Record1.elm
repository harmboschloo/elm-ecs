module V2b_Singletons.Ecs.Internal.Record1 exposing
    ( Record
    , update1
    )


type alias Record a1 =
    { a1 : a1
    }


update1 :
    (a1 -> a1)
    -> Record a1
    -> Record a1
update1 fn record =
    { a1 = fn record.a1
    }
