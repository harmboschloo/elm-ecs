module Ecs.Internal.Record4 exposing
    ( Record
    , update1
    , update2
    , update3
    , update4
    )


type alias Record a1 a2 a3 a4 =
    { a1 : a1
    , a2 : a2
    , a3 : a3
    , a4 : a4
    }


update1 :
    (a1 -> a1)
    -> Record a1 a2 a3 a4
    -> Record a1 a2 a3 a4
update1 fn record =
    { a1 = fn record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = record.a4
    }


update2 :
    (a2 -> a2)
    -> Record a1 a2 a3 a4
    -> Record a1 a2 a3 a4
update2 fn record =
    { a1 = record.a1
    , a2 = fn record.a2
    , a3 = record.a3
    , a4 = record.a4
    }


update3 :
    (a3 -> a3)
    -> Record a1 a2 a3 a4
    -> Record a1 a2 a3 a4
update3 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = fn record.a3
    , a4 = record.a4
    }


update4 :
    (a4 -> a4)
    -> Record a1 a2 a3 a4
    -> Record a1 a2 a3 a4
update4 fn record =
    { a1 = record.a1
    , a2 = record.a2
    , a3 = record.a3
    , a4 = fn record.a4
    }
