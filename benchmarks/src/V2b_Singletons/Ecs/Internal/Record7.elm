module V2b_Singletons.Ecs.Internal.Record7 exposing
    ( Record
    , update1
    , update2
    , update3
    , update4
    , update5
    , update6
    , update7
    )


type alias Record a1 a2 a3 a4 a5 a6 a7 =
    { a1 : a1
    , a2 : a2
    , a3 : a3
    , a4 : a4
    , a5 : a5
    , a6 : a6
    , a7 : a7
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    }


update3 :
    (a3 -> a3)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update3 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = fn record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    }


update4 :
    (a4 -> a4)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update4 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = fn record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    }


update5 :
    (a5 -> a5)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update5 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = fn record.a5
    , a6 = record.a6
    , a7 = record.a7
    }


update6 :
    (a6 -> a6)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update6 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = fn record.a6
    , a7 = record.a7
    }


update7 :
    (a7 -> a7)
    -> Record a1 a2 a3 a4 a5 a6 a7
    -> Record a1 a2 a3 a4 a5 a6 a7
update7 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = fn record.a7
    }
