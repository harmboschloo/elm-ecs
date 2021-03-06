module V2b_Singletons.Ecs.Internal.Record10 exposing
    ( Record
    , update1
    , update10
    , update2
    , update3
    , update4
    , update5
    , update6
    , update7
    , update8
    , update9
    )


type alias Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 =
    { a1 : a1
    , a2 : a2
    , a3 : a3
    , a4 : a4
    , a5 : a5
    , a6 : a6
    , a7 : a7
    , a8 : a8
    , a9 : a9
    , a10 : a10
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update3 :
    (a3 -> a3)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update3 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = fn record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update4 :
    (a4 -> a4)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update4 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = fn record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update5 :
    (a5 -> a5)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update5 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = fn record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update6 :
    (a6 -> a6)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update6 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = fn record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update7 :
    (a7 -> a7)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update7 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = fn record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update8 :
    (a8 -> a8)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update8 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = fn record.a8
    , a9 = record.a9
    , a10 = record.a10
    }


update9 :
    (a9 -> a9)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update9 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = fn record.a9
    , a10 = record.a10
    }


update10 :
    (a10 -> a10)
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
    -> Record a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
update10 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    , a5 = record.a5
    , a6 = record.a6
    , a7 = record.a7
    , a8 = record.a8
    , a9 = record.a9
    , a10 = fn record.a10
    }
