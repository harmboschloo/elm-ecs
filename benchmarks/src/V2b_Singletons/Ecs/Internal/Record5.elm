module V2b_Singletons.Ecs.Internal.Record5 exposing
    ( Record
    , update1
    , update2
    , update3
    , update4
    , update5
    )


type alias Record a1 a2 a3 a4 a5 =
    { a1 : a1
    , a2 : a2
    , a3 : a3
    , a4 : a4
    , a5 : a5
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2 a3 a4 a5
    -> Record a1 a2 a3 a4 a5
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2 a3 a4 a5
    -> Record a1 a2 a3 a4 a5
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    }


update3 :
    (a3 -> a3)
    -> Record a1 a2 a3 a4 a5
    -> Record a1 a2 a3 a4 a5
update3 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = fn record.a3
    , a4 = record.a4
    , a5 = record.a5
    }


update4 :
    (a4 -> a4)
    -> Record a1 a2 a3 a4 a5
    -> Record a1 a2 a3 a4 a5
update4 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = fn record.a4
    , a5 = record.a5
    }


update5 :
    (a5 -> a5)
    -> Record a1 a2 a3 a4 a5
    -> Record a1 a2 a3 a4 a5
update5 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = fn record.a5
    }
